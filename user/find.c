#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p)+1);
  return buf;
}

void find(char *path,char *file_name)
{
  char buf[512], *p;
  int fd;
  struct dirent de; //目录项 kernel/fs.h
  struct stat st; //文件统计信息 kernel/stat.h

  if((fd = open(path, 0)) < 0){ //open返回的fd是文件描述符
    fprintf(2, "find: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){       //st得到文件状态
    fprintf(2, "find: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  case T_FILE:        //如果是文件，直接匹配后输出
    if(strcmp(file_name,fmtname(path)) == 0){
      printf("%s\n", path);
    } 
    // printf("test2%s\n",path);
    // printf("%s\n", file_name);
    // printf("%s\n", fmtname(path));
    break;

  case T_DIR:       //如果是目录
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf("find: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
        if(de.inum == 0)
            continue;
        memmove(p, de.name, DIRSIZ);
        p[strlen(de.name)] = 0;
        if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) {
            continue;
        }
        // printf("%s\n",path);
        find(buf, file_name);
    }
    break;
  }
  close(fd);
}

int main(int argc, char *argv[])
{
  if(argc < 3){
    printf("too short");
    exit(0);
  }
  find(argv[1],argv[2]);
  exit(0);
}