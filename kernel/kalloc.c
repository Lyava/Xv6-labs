// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"

void freerange(void *pa_start, void *pa_end);

extern char end[]; // first address after kernel.
                   // defined by kernel.ld.

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  struct run *freelist;
} kmems[NCPU];

char*lock_name[] = {"keme_1","keme_2","keme_3","keme_4","keme_5","keme_6","keme_7","keme_8",};

void
kinit()
{
  for(int i = 0; i < NCPU; i++){
    initlock(&kmems[i].lock, lock_name[i]);
  }
  freerange(end, (void*)PHYSTOP);
}

void
freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    kfree(p);
}

// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);

  r = (struct run*)pa;

  push_off();
  int cpu_id = cpuid();  //正在运行的cpu序号

  acquire(&kmems[cpu_id].lock);
  r->next = kmems[cpu_id].freelist;
  kmems[cpu_id].freelist = r;
  release(&kmems[cpu_id].lock);
  pop_off();
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
  struct run *r;

  push_off();
  int cpu_id = cpuid();

  acquire(&kmems[cpu_id].lock);
  r = kmems[cpu_id].freelist;
  if(r){
    kmems[cpu_id].freelist = r->next;
  }else{
    int flag = 0;

    for(int i = 0; i< NCPU;i++){
      if( i == cpu_id)  continue;

      acquire(&kmems[i].lock);
      struct run *rp = kmems[i].freelist;

      if(rp){
        struct run *fr = rp;
        struct run *pre = rp;
        while(fr && fr->next){
          fr = fr->next->next;
          pre = rp;
          rp = rp->next;
        }
        kmems[cpu_id].freelist = kmems[i].freelist;
        if(rp == kmems[i].freelist){
          kmems[i].freelist = 0;
        }else {
          kmems[i].freelist = rp;
          pre->next = 0;
        }
        flag = 1;
      }
      release(&kmems[i].lock);
      if(flag){
        r = kmems[cpu_id].freelist;
        kmems[cpu_id].freelist = r->next;
        break;
      }
    }

  }
  release(&kmems[cpu_id].lock);
  pop_off();
  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
  return (void*)r;
}
