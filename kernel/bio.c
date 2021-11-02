// Buffer cache.
//
// The buffer cache is a linked list of buf structures holding
// cached copies of disk block contents.  Caching disk blocks
// in memory reduces the number of disk reads and also provides
// a synchronization point for disk blocks used by multiple processes.
//
// Interface:
// * To get a buffer for a particular disk block, call bread.
// * After changing buffer data, call bwrite to write it to disk.
// * When done with the buffer, call brelse.
// * Do not use the buffer after calling brelse.
// * Only one process at a time can use a buffer,
//     so do not keep them longer than necessary.


#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "riscv.h"
#include "defs.h"
#include "fs.h"
#include "buf.h"

struct bucket{
  struct spinlock lock;
  struct buf head;
};

struct {
  struct spinlock lock;
  struct buf buf[NBUF];

  // Linked list of all buffers, through prev/next.
  // Sorted by how recently the buffer was used.
  // head.next is most recent, head.prev is least.
  struct bucket bhash[HASHKEY];
} bcache;

int
hash(uint64 blockno){
  return blockno % HASHKEY;
}

void
binit(void)
{
  struct buf *b;
  struct bucket *h;
  initlock(&bcache.lock, "bcache");
  for(int i = 0; i < HASHKEY; i++){
    h = bcache.bhash + i;
    initlock(&h->lock, "bhash");
    h->head.prev = &h->head;
    h->head.next = &h->head;
  }

  int j = 0;
  // Create linked list of buffers
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    j++;
    h = bcache.bhash + (j % HASHKEY);
    b->next = h->head.next;
    b->prev = &h->head;
    initsleeplock(&b->lock, "buffer");
    h->head.next->prev = b;
    h->head.next = b;
  }
}

// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;
  struct bucket *h;
  int h_blockno = blockno % HASHKEY;
  h = bcache.bhash + h_blockno;
  acquire(&h->lock);

  // Is the block already cached?
  for(b = h->head.next; b != &h->head; b = b->next){
    if(b->dev == dev && b->blockno == blockno){
      b->refcnt++;
      release(&h->lock);
      acquiresleep(&b->lock);
      return b;
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = h->head.prev; b != &h->head; b = b->prev){
    if(b->refcnt == 0) {
      b->dev = dev;
      b->blockno = blockno;
      b->valid = 0;
      b->refcnt = 1;
      release(&h->lock);
      acquiresleep(&b->lock);
      return b;
    }
  }

  release(&h->lock);
  for(int i = 0; i < HASHKEY;i++){
    if(i == h_blockno)  continue;
    h = bcache.bhash + i;
    acquire(&h->lock);
    for(b = h->head.prev; b != &h->head; b = b->prev){
      if(b->refcnt == 0){
        b->next->prev = b -> prev;
        b->prev->next = b->next;
        release(&h->lock);
        h = bcache.bhash + h_blockno;
        acquire(&h->lock);
        b->next = h->head.next;
        b->prev = &h->head;
        h->head.next -> prev = b;
        h->head.next = b;

        for(b = h->head.next; b != &h->head; b = b->next){
          if(b->dev == dev && b->blockno == blockno){
            b->refcnt++;
            release(&h->lock);
            acquiresleep(&b->lock);
            return b;
          }
        }
        b = h -> head.next;
        b->dev = dev;
        b->blockno = blockno;
        b->valid = 0;
        b->refcnt = 1;
        release(&h->lock);
        acquiresleep(&b->lock);
        return b;

      }
    }
    release(&h->lock);
  }
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  virtio_disk_rw(b, 1);
}

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");

  releasesleep(&b->lock);
  struct bucket *h;
  h = bcache.bhash+hash(b->blockno);
  acquire(&h->lock);
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = h->head.next;
    b->prev = &h->head;
    h->head.next->prev = b;
    h->head.next = b;
  }
  
  release(&h->lock);
}

void
bpin(struct buf *b) {
  acquire(&bcache.lock);
  b->refcnt++;
  release(&bcache.lock);
}

void
bunpin(struct buf *b) {
  acquire(&bcache.lock);
  b->refcnt--;
  release(&bcache.lock);
}


