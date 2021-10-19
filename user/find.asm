
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   e:	00000097          	auipc	ra,0x0
  12:	2b8080e7          	jalr	696(ra) # 2c6 <strlen>
  16:	02051593          	slli	a1,a0,0x20
  1a:	9181                	srli	a1,a1,0x20
  1c:	95a6                	add	a1,a1,s1
  1e:	02f00713          	li	a4,47
  22:	0095e963          	bltu	a1,s1,34 <fmtname+0x34>
  26:	0005c783          	lbu	a5,0(a1)
  2a:	00e78563          	beq	a5,a4,34 <fmtname+0x34>
  2e:	15fd                	addi	a1,a1,-1
  30:	fe95fbe3          	bgeu	a1,s1,26 <fmtname+0x26>
    ;
  p++;
  34:	00158493          	addi	s1,a1,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  38:	8526                	mv	a0,s1
  3a:	00000097          	auipc	ra,0x0
  3e:	28c080e7          	jalr	652(ra) # 2c6 <strlen>
  42:	2501                	sext.w	a0,a0
  44:	47b5                	li	a5,13
  46:	00a7f963          	bgeu	a5,a0,58 <fmtname+0x58>
    return p;
  memmove(buf, p, strlen(p)+1);
  return buf;
}
  4a:	8526                	mv	a0,s1
  4c:	60e2                	ld	ra,24(sp)
  4e:	6442                	ld	s0,16(sp)
  50:	64a2                	ld	s1,8(sp)
  52:	6902                	ld	s2,0(sp)
  54:	6105                	addi	sp,sp,32
  56:	8082                	ret
  memmove(buf, p, strlen(p)+1);
  58:	8526                	mv	a0,s1
  5a:	00000097          	auipc	ra,0x0
  5e:	26c080e7          	jalr	620(ra) # 2c6 <strlen>
  62:	00001917          	auipc	s2,0x1
  66:	a3e90913          	addi	s2,s2,-1474 # aa0 <buf.0>
  6a:	0015061b          	addiw	a2,a0,1
  6e:	85a6                	mv	a1,s1
  70:	854a                	mv	a0,s2
  72:	00000097          	auipc	ra,0x0
  76:	3c8080e7          	jalr	968(ra) # 43a <memmove>
  return buf;
  7a:	84ca                	mv	s1,s2
  7c:	b7f9                	j	4a <fmtname+0x4a>

000000000000007e <find>:

void find(char *path,char *file_name)
{
  7e:	d9010113          	addi	sp,sp,-624
  82:	26113423          	sd	ra,616(sp)
  86:	26813023          	sd	s0,608(sp)
  8a:	24913c23          	sd	s1,600(sp)
  8e:	25213823          	sd	s2,592(sp)
  92:	25313423          	sd	s3,584(sp)
  96:	25413023          	sd	s4,576(sp)
  9a:	23513c23          	sd	s5,568(sp)
  9e:	1c80                	addi	s0,sp,624
  a0:	892a                	mv	s2,a0
  a2:	89ae                	mv	s3,a1
  char buf[512], *p;
  int fd;
  struct dirent de; //目录项 kernel/fs.h
  struct stat st; //文件统计信息 kernel/stat.h

  if((fd = open(path, 0)) < 0){ //open返回的fd是文件描述符
  a4:	4581                	li	a1,0
  a6:	00000097          	auipc	ra,0x0
  aa:	486080e7          	jalr	1158(ra) # 52c <open>
  ae:	06054763          	bltz	a0,11c <find+0x9e>
  b2:	84aa                	mv	s1,a0
    fprintf(2, "find: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){       //st得到文件状态
  b4:	d9840593          	addi	a1,s0,-616
  b8:	00000097          	auipc	ra,0x0
  bc:	48c080e7          	jalr	1164(ra) # 544 <fstat>
  c0:	06054963          	bltz	a0,132 <find+0xb4>
    fprintf(2, "find: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  c4:	da041783          	lh	a5,-608(s0)
  c8:	0007869b          	sext.w	a3,a5
  cc:	4705                	li	a4,1
  ce:	08e68c63          	beq	a3,a4,166 <find+0xe8>
  d2:	4709                	li	a4,2
  d4:	00e69e63          	bne	a3,a4,f0 <find+0x72>
  case T_FILE:        //如果是文件，直接匹配后输出
    if(strcmp(file_name,fmtname(path)) == 0){
  d8:	854a                	mv	a0,s2
  da:	00000097          	auipc	ra,0x0
  de:	f26080e7          	jalr	-218(ra) # 0 <fmtname>
  e2:	85aa                	mv	a1,a0
  e4:	854e                	mv	a0,s3
  e6:	00000097          	auipc	ra,0x0
  ea:	1b4080e7          	jalr	436(ra) # 29a <strcmp>
  ee:	c135                	beqz	a0,152 <find+0xd4>
        // printf("%s\n",path);
        find(buf, file_name);
    }
    break;
  }
  close(fd);
  f0:	8526                	mv	a0,s1
  f2:	00000097          	auipc	ra,0x0
  f6:	422080e7          	jalr	1058(ra) # 514 <close>
}
  fa:	26813083          	ld	ra,616(sp)
  fe:	26013403          	ld	s0,608(sp)
 102:	25813483          	ld	s1,600(sp)
 106:	25013903          	ld	s2,592(sp)
 10a:	24813983          	ld	s3,584(sp)
 10e:	24013a03          	ld	s4,576(sp)
 112:	23813a83          	ld	s5,568(sp)
 116:	27010113          	addi	sp,sp,624
 11a:	8082                	ret
    fprintf(2, "find: cannot open %s\n", path);
 11c:	864a                	mv	a2,s2
 11e:	00001597          	auipc	a1,0x1
 122:	8ea58593          	addi	a1,a1,-1814 # a08 <malloc+0xe6>
 126:	4509                	li	a0,2
 128:	00000097          	auipc	ra,0x0
 12c:	70e080e7          	jalr	1806(ra) # 836 <fprintf>
    return;
 130:	b7e9                	j	fa <find+0x7c>
    fprintf(2, "find: cannot stat %s\n", path);
 132:	864a                	mv	a2,s2
 134:	00001597          	auipc	a1,0x1
 138:	8ec58593          	addi	a1,a1,-1812 # a20 <malloc+0xfe>
 13c:	4509                	li	a0,2
 13e:	00000097          	auipc	ra,0x0
 142:	6f8080e7          	jalr	1784(ra) # 836 <fprintf>
    close(fd);
 146:	8526                	mv	a0,s1
 148:	00000097          	auipc	ra,0x0
 14c:	3cc080e7          	jalr	972(ra) # 514 <close>
    return;
 150:	b76d                	j	fa <find+0x7c>
      printf("%s\n", path);
 152:	85ca                	mv	a1,s2
 154:	00001517          	auipc	a0,0x1
 158:	8e450513          	addi	a0,a0,-1820 # a38 <malloc+0x116>
 15c:	00000097          	auipc	ra,0x0
 160:	708080e7          	jalr	1800(ra) # 864 <printf>
 164:	b771                	j	f0 <find+0x72>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 166:	854a                	mv	a0,s2
 168:	00000097          	auipc	ra,0x0
 16c:	15e080e7          	jalr	350(ra) # 2c6 <strlen>
 170:	2541                	addiw	a0,a0,16
 172:	20000793          	li	a5,512
 176:	00a7fb63          	bgeu	a5,a0,18c <find+0x10e>
      printf("find: path too long\n");
 17a:	00001517          	auipc	a0,0x1
 17e:	8c650513          	addi	a0,a0,-1850 # a40 <malloc+0x11e>
 182:	00000097          	auipc	ra,0x0
 186:	6e2080e7          	jalr	1762(ra) # 864 <printf>
      break;
 18a:	b79d                	j	f0 <find+0x72>
    strcpy(buf, path);
 18c:	85ca                	mv	a1,s2
 18e:	dc040513          	addi	a0,s0,-576
 192:	00000097          	auipc	ra,0x0
 196:	0ec080e7          	jalr	236(ra) # 27e <strcpy>
    p = buf+strlen(buf);
 19a:	dc040513          	addi	a0,s0,-576
 19e:	00000097          	auipc	ra,0x0
 1a2:	128080e7          	jalr	296(ra) # 2c6 <strlen>
 1a6:	1502                	slli	a0,a0,0x20
 1a8:	9101                	srli	a0,a0,0x20
 1aa:	dc040793          	addi	a5,s0,-576
 1ae:	953e                	add	a0,a0,a5
    *p++ = '/';
 1b0:	00150913          	addi	s2,a0,1
 1b4:	02f00793          	li	a5,47
 1b8:	00f50023          	sb	a5,0(a0)
        if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) {
 1bc:	00001a17          	auipc	s4,0x1
 1c0:	89ca0a13          	addi	s4,s4,-1892 # a58 <malloc+0x136>
 1c4:	00001a97          	auipc	s5,0x1
 1c8:	89ca8a93          	addi	s5,s5,-1892 # a60 <malloc+0x13e>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1cc:	4641                	li	a2,16
 1ce:	db040593          	addi	a1,s0,-592
 1d2:	8526                	mv	a0,s1
 1d4:	00000097          	auipc	ra,0x0
 1d8:	330080e7          	jalr	816(ra) # 504 <read>
 1dc:	47c1                	li	a5,16
 1de:	f0f519e3          	bne	a0,a5,f0 <find+0x72>
        if(de.inum == 0)
 1e2:	db045783          	lhu	a5,-592(s0)
 1e6:	d3fd                	beqz	a5,1cc <find+0x14e>
        memmove(p, de.name, DIRSIZ);
 1e8:	4639                	li	a2,14
 1ea:	db240593          	addi	a1,s0,-590
 1ee:	854a                	mv	a0,s2
 1f0:	00000097          	auipc	ra,0x0
 1f4:	24a080e7          	jalr	586(ra) # 43a <memmove>
        p[strlen(de.name)] = 0;
 1f8:	db240513          	addi	a0,s0,-590
 1fc:	00000097          	auipc	ra,0x0
 200:	0ca080e7          	jalr	202(ra) # 2c6 <strlen>
 204:	1502                	slli	a0,a0,0x20
 206:	9101                	srli	a0,a0,0x20
 208:	954a                	add	a0,a0,s2
 20a:	00050023          	sb	zero,0(a0)
        if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) {
 20e:	85d2                	mv	a1,s4
 210:	db240513          	addi	a0,s0,-590
 214:	00000097          	auipc	ra,0x0
 218:	086080e7          	jalr	134(ra) # 29a <strcmp>
 21c:	d945                	beqz	a0,1cc <find+0x14e>
 21e:	85d6                	mv	a1,s5
 220:	db240513          	addi	a0,s0,-590
 224:	00000097          	auipc	ra,0x0
 228:	076080e7          	jalr	118(ra) # 29a <strcmp>
 22c:	d145                	beqz	a0,1cc <find+0x14e>
        find(buf, file_name);
 22e:	85ce                	mv	a1,s3
 230:	dc040513          	addi	a0,s0,-576
 234:	00000097          	auipc	ra,0x0
 238:	e4a080e7          	jalr	-438(ra) # 7e <find>
 23c:	bf41                	j	1cc <find+0x14e>

000000000000023e <main>:

int main(int argc, char *argv[])
{
 23e:	1141                	addi	sp,sp,-16
 240:	e406                	sd	ra,8(sp)
 242:	e022                	sd	s0,0(sp)
 244:	0800                	addi	s0,sp,16
  if(argc < 3){
 246:	4709                	li	a4,2
 248:	00a74f63          	blt	a4,a0,266 <main+0x28>
    printf("too short");
 24c:	00001517          	auipc	a0,0x1
 250:	81c50513          	addi	a0,a0,-2020 # a68 <malloc+0x146>
 254:	00000097          	auipc	ra,0x0
 258:	610080e7          	jalr	1552(ra) # 864 <printf>
    exit(0);
 25c:	4501                	li	a0,0
 25e:	00000097          	auipc	ra,0x0
 262:	28e080e7          	jalr	654(ra) # 4ec <exit>
 266:	87ae                	mv	a5,a1
  }
  find(argv[1],argv[2]);
 268:	698c                	ld	a1,16(a1)
 26a:	6788                	ld	a0,8(a5)
 26c:	00000097          	auipc	ra,0x0
 270:	e12080e7          	jalr	-494(ra) # 7e <find>
  exit(0);
 274:	4501                	li	a0,0
 276:	00000097          	auipc	ra,0x0
 27a:	276080e7          	jalr	630(ra) # 4ec <exit>

000000000000027e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 284:	87aa                	mv	a5,a0
 286:	0585                	addi	a1,a1,1
 288:	0785                	addi	a5,a5,1
 28a:	fff5c703          	lbu	a4,-1(a1)
 28e:	fee78fa3          	sb	a4,-1(a5)
 292:	fb75                	bnez	a4,286 <strcpy+0x8>
    ;
  return os;
}
 294:	6422                	ld	s0,8(sp)
 296:	0141                	addi	sp,sp,16
 298:	8082                	ret

000000000000029a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 29a:	1141                	addi	sp,sp,-16
 29c:	e422                	sd	s0,8(sp)
 29e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	cb91                	beqz	a5,2b8 <strcmp+0x1e>
 2a6:	0005c703          	lbu	a4,0(a1)
 2aa:	00f71763          	bne	a4,a5,2b8 <strcmp+0x1e>
    p++, q++;
 2ae:	0505                	addi	a0,a0,1
 2b0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2b2:	00054783          	lbu	a5,0(a0)
 2b6:	fbe5                	bnez	a5,2a6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2b8:	0005c503          	lbu	a0,0(a1)
}
 2bc:	40a7853b          	subw	a0,a5,a0
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <strlen>:

uint
strlen(const char *s)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	cf91                	beqz	a5,2ec <strlen+0x26>
 2d2:	0505                	addi	a0,a0,1
 2d4:	87aa                	mv	a5,a0
 2d6:	4685                	li	a3,1
 2d8:	9e89                	subw	a3,a3,a0
 2da:	00f6853b          	addw	a0,a3,a5
 2de:	0785                	addi	a5,a5,1
 2e0:	fff7c703          	lbu	a4,-1(a5)
 2e4:	fb7d                	bnez	a4,2da <strlen+0x14>
    ;
  return n;
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret
  for(n = 0; s[n]; n++)
 2ec:	4501                	li	a0,0
 2ee:	bfe5                	j	2e6 <strlen+0x20>

00000000000002f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2f0:	1141                	addi	sp,sp,-16
 2f2:	e422                	sd	s0,8(sp)
 2f4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2f6:	ca19                	beqz	a2,30c <memset+0x1c>
 2f8:	87aa                	mv	a5,a0
 2fa:	1602                	slli	a2,a2,0x20
 2fc:	9201                	srli	a2,a2,0x20
 2fe:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 302:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 306:	0785                	addi	a5,a5,1
 308:	fee79de3          	bne	a5,a4,302 <memset+0x12>
  }
  return dst;
}
 30c:	6422                	ld	s0,8(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret

0000000000000312 <strchr>:

char*
strchr(const char *s, char c)
{
 312:	1141                	addi	sp,sp,-16
 314:	e422                	sd	s0,8(sp)
 316:	0800                	addi	s0,sp,16
  for(; *s; s++)
 318:	00054783          	lbu	a5,0(a0)
 31c:	cb99                	beqz	a5,332 <strchr+0x20>
    if(*s == c)
 31e:	00f58763          	beq	a1,a5,32c <strchr+0x1a>
  for(; *s; s++)
 322:	0505                	addi	a0,a0,1
 324:	00054783          	lbu	a5,0(a0)
 328:	fbfd                	bnez	a5,31e <strchr+0xc>
      return (char*)s;
  return 0;
 32a:	4501                	li	a0,0
}
 32c:	6422                	ld	s0,8(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret
  return 0;
 332:	4501                	li	a0,0
 334:	bfe5                	j	32c <strchr+0x1a>

0000000000000336 <gets>:

char*
gets(char *buf, int max)
{
 336:	711d                	addi	sp,sp,-96
 338:	ec86                	sd	ra,88(sp)
 33a:	e8a2                	sd	s0,80(sp)
 33c:	e4a6                	sd	s1,72(sp)
 33e:	e0ca                	sd	s2,64(sp)
 340:	fc4e                	sd	s3,56(sp)
 342:	f852                	sd	s4,48(sp)
 344:	f456                	sd	s5,40(sp)
 346:	f05a                	sd	s6,32(sp)
 348:	ec5e                	sd	s7,24(sp)
 34a:	1080                	addi	s0,sp,96
 34c:	8baa                	mv	s7,a0
 34e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 350:	892a                	mv	s2,a0
 352:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 354:	4aa9                	li	s5,10
 356:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 358:	89a6                	mv	s3,s1
 35a:	2485                	addiw	s1,s1,1
 35c:	0344d863          	bge	s1,s4,38c <gets+0x56>
    cc = read(0, &c, 1);
 360:	4605                	li	a2,1
 362:	faf40593          	addi	a1,s0,-81
 366:	4501                	li	a0,0
 368:	00000097          	auipc	ra,0x0
 36c:	19c080e7          	jalr	412(ra) # 504 <read>
    if(cc < 1)
 370:	00a05e63          	blez	a0,38c <gets+0x56>
    buf[i++] = c;
 374:	faf44783          	lbu	a5,-81(s0)
 378:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 37c:	01578763          	beq	a5,s5,38a <gets+0x54>
 380:	0905                	addi	s2,s2,1
 382:	fd679be3          	bne	a5,s6,358 <gets+0x22>
  for(i=0; i+1 < max; ){
 386:	89a6                	mv	s3,s1
 388:	a011                	j	38c <gets+0x56>
 38a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 38c:	99de                	add	s3,s3,s7
 38e:	00098023          	sb	zero,0(s3)
  return buf;
}
 392:	855e                	mv	a0,s7
 394:	60e6                	ld	ra,88(sp)
 396:	6446                	ld	s0,80(sp)
 398:	64a6                	ld	s1,72(sp)
 39a:	6906                	ld	s2,64(sp)
 39c:	79e2                	ld	s3,56(sp)
 39e:	7a42                	ld	s4,48(sp)
 3a0:	7aa2                	ld	s5,40(sp)
 3a2:	7b02                	ld	s6,32(sp)
 3a4:	6be2                	ld	s7,24(sp)
 3a6:	6125                	addi	sp,sp,96
 3a8:	8082                	ret

00000000000003aa <stat>:

int
stat(const char *n, struct stat *st)
{
 3aa:	1101                	addi	sp,sp,-32
 3ac:	ec06                	sd	ra,24(sp)
 3ae:	e822                	sd	s0,16(sp)
 3b0:	e426                	sd	s1,8(sp)
 3b2:	e04a                	sd	s2,0(sp)
 3b4:	1000                	addi	s0,sp,32
 3b6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b8:	4581                	li	a1,0
 3ba:	00000097          	auipc	ra,0x0
 3be:	172080e7          	jalr	370(ra) # 52c <open>
  if(fd < 0)
 3c2:	02054563          	bltz	a0,3ec <stat+0x42>
 3c6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3c8:	85ca                	mv	a1,s2
 3ca:	00000097          	auipc	ra,0x0
 3ce:	17a080e7          	jalr	378(ra) # 544 <fstat>
 3d2:	892a                	mv	s2,a0
  close(fd);
 3d4:	8526                	mv	a0,s1
 3d6:	00000097          	auipc	ra,0x0
 3da:	13e080e7          	jalr	318(ra) # 514 <close>
  return r;
}
 3de:	854a                	mv	a0,s2
 3e0:	60e2                	ld	ra,24(sp)
 3e2:	6442                	ld	s0,16(sp)
 3e4:	64a2                	ld	s1,8(sp)
 3e6:	6902                	ld	s2,0(sp)
 3e8:	6105                	addi	sp,sp,32
 3ea:	8082                	ret
    return -1;
 3ec:	597d                	li	s2,-1
 3ee:	bfc5                	j	3de <stat+0x34>

00000000000003f0 <atoi>:

int
atoi(const char *s)
{
 3f0:	1141                	addi	sp,sp,-16
 3f2:	e422                	sd	s0,8(sp)
 3f4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f6:	00054603          	lbu	a2,0(a0)
 3fa:	fd06079b          	addiw	a5,a2,-48
 3fe:	0ff7f793          	zext.b	a5,a5
 402:	4725                	li	a4,9
 404:	02f76963          	bltu	a4,a5,436 <atoi+0x46>
 408:	86aa                	mv	a3,a0
  n = 0;
 40a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 40c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 40e:	0685                	addi	a3,a3,1
 410:	0025179b          	slliw	a5,a0,0x2
 414:	9fa9                	addw	a5,a5,a0
 416:	0017979b          	slliw	a5,a5,0x1
 41a:	9fb1                	addw	a5,a5,a2
 41c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 420:	0006c603          	lbu	a2,0(a3)
 424:	fd06071b          	addiw	a4,a2,-48
 428:	0ff77713          	zext.b	a4,a4
 42c:	fee5f1e3          	bgeu	a1,a4,40e <atoi+0x1e>
  return n;
}
 430:	6422                	ld	s0,8(sp)
 432:	0141                	addi	sp,sp,16
 434:	8082                	ret
  n = 0;
 436:	4501                	li	a0,0
 438:	bfe5                	j	430 <atoi+0x40>

000000000000043a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 43a:	1141                	addi	sp,sp,-16
 43c:	e422                	sd	s0,8(sp)
 43e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 440:	02b57463          	bgeu	a0,a1,468 <memmove+0x2e>
    while(n-- > 0)
 444:	00c05f63          	blez	a2,462 <memmove+0x28>
 448:	1602                	slli	a2,a2,0x20
 44a:	9201                	srli	a2,a2,0x20
 44c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 450:	872a                	mv	a4,a0
      *dst++ = *src++;
 452:	0585                	addi	a1,a1,1
 454:	0705                	addi	a4,a4,1
 456:	fff5c683          	lbu	a3,-1(a1)
 45a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 45e:	fee79ae3          	bne	a5,a4,452 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 462:	6422                	ld	s0,8(sp)
 464:	0141                	addi	sp,sp,16
 466:	8082                	ret
    dst += n;
 468:	00c50733          	add	a4,a0,a2
    src += n;
 46c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 46e:	fec05ae3          	blez	a2,462 <memmove+0x28>
 472:	fff6079b          	addiw	a5,a2,-1
 476:	1782                	slli	a5,a5,0x20
 478:	9381                	srli	a5,a5,0x20
 47a:	fff7c793          	not	a5,a5
 47e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 480:	15fd                	addi	a1,a1,-1
 482:	177d                	addi	a4,a4,-1
 484:	0005c683          	lbu	a3,0(a1)
 488:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 48c:	fee79ae3          	bne	a5,a4,480 <memmove+0x46>
 490:	bfc9                	j	462 <memmove+0x28>

0000000000000492 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 492:	1141                	addi	sp,sp,-16
 494:	e422                	sd	s0,8(sp)
 496:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 498:	ca05                	beqz	a2,4c8 <memcmp+0x36>
 49a:	fff6069b          	addiw	a3,a2,-1
 49e:	1682                	slli	a3,a3,0x20
 4a0:	9281                	srli	a3,a3,0x20
 4a2:	0685                	addi	a3,a3,1
 4a4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4a6:	00054783          	lbu	a5,0(a0)
 4aa:	0005c703          	lbu	a4,0(a1)
 4ae:	00e79863          	bne	a5,a4,4be <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4b2:	0505                	addi	a0,a0,1
    p2++;
 4b4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4b6:	fed518e3          	bne	a0,a3,4a6 <memcmp+0x14>
  }
  return 0;
 4ba:	4501                	li	a0,0
 4bc:	a019                	j	4c2 <memcmp+0x30>
      return *p1 - *p2;
 4be:	40e7853b          	subw	a0,a5,a4
}
 4c2:	6422                	ld	s0,8(sp)
 4c4:	0141                	addi	sp,sp,16
 4c6:	8082                	ret
  return 0;
 4c8:	4501                	li	a0,0
 4ca:	bfe5                	j	4c2 <memcmp+0x30>

00000000000004cc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e406                	sd	ra,8(sp)
 4d0:	e022                	sd	s0,0(sp)
 4d2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4d4:	00000097          	auipc	ra,0x0
 4d8:	f66080e7          	jalr	-154(ra) # 43a <memmove>
}
 4dc:	60a2                	ld	ra,8(sp)
 4de:	6402                	ld	s0,0(sp)
 4e0:	0141                	addi	sp,sp,16
 4e2:	8082                	ret

00000000000004e4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4e4:	4885                	li	a7,1
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <exit>:
.global exit
exit:
 li a7, SYS_exit
 4ec:	4889                	li	a7,2
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4f4:	488d                	li	a7,3
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4fc:	4891                	li	a7,4
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <read>:
.global read
read:
 li a7, SYS_read
 504:	4895                	li	a7,5
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <write>:
.global write
write:
 li a7, SYS_write
 50c:	48c1                	li	a7,16
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <close>:
.global close
close:
 li a7, SYS_close
 514:	48d5                	li	a7,21
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <kill>:
.global kill
kill:
 li a7, SYS_kill
 51c:	4899                	li	a7,6
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <exec>:
.global exec
exec:
 li a7, SYS_exec
 524:	489d                	li	a7,7
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <open>:
.global open
open:
 li a7, SYS_open
 52c:	48bd                	li	a7,15
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 534:	48c5                	li	a7,17
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 53c:	48c9                	li	a7,18
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 544:	48a1                	li	a7,8
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <link>:
.global link
link:
 li a7, SYS_link
 54c:	48cd                	li	a7,19
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 554:	48d1                	li	a7,20
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 55c:	48a5                	li	a7,9
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <dup>:
.global dup
dup:
 li a7, SYS_dup
 564:	48a9                	li	a7,10
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 56c:	48ad                	li	a7,11
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 574:	48b1                	li	a7,12
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 57c:	48b5                	li	a7,13
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 584:	48b9                	li	a7,14
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 58c:	1101                	addi	sp,sp,-32
 58e:	ec06                	sd	ra,24(sp)
 590:	e822                	sd	s0,16(sp)
 592:	1000                	addi	s0,sp,32
 594:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 598:	4605                	li	a2,1
 59a:	fef40593          	addi	a1,s0,-17
 59e:	00000097          	auipc	ra,0x0
 5a2:	f6e080e7          	jalr	-146(ra) # 50c <write>
}
 5a6:	60e2                	ld	ra,24(sp)
 5a8:	6442                	ld	s0,16(sp)
 5aa:	6105                	addi	sp,sp,32
 5ac:	8082                	ret

00000000000005ae <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5ae:	7139                	addi	sp,sp,-64
 5b0:	fc06                	sd	ra,56(sp)
 5b2:	f822                	sd	s0,48(sp)
 5b4:	f426                	sd	s1,40(sp)
 5b6:	f04a                	sd	s2,32(sp)
 5b8:	ec4e                	sd	s3,24(sp)
 5ba:	0080                	addi	s0,sp,64
 5bc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5be:	c299                	beqz	a3,5c4 <printint+0x16>
 5c0:	0805c863          	bltz	a1,650 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5c4:	2581                	sext.w	a1,a1
  neg = 0;
 5c6:	4881                	li	a7,0
 5c8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5cc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5ce:	2601                	sext.w	a2,a2
 5d0:	00000517          	auipc	a0,0x0
 5d4:	4b050513          	addi	a0,a0,1200 # a80 <digits>
 5d8:	883a                	mv	a6,a4
 5da:	2705                	addiw	a4,a4,1
 5dc:	02c5f7bb          	remuw	a5,a1,a2
 5e0:	1782                	slli	a5,a5,0x20
 5e2:	9381                	srli	a5,a5,0x20
 5e4:	97aa                	add	a5,a5,a0
 5e6:	0007c783          	lbu	a5,0(a5)
 5ea:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5ee:	0005879b          	sext.w	a5,a1
 5f2:	02c5d5bb          	divuw	a1,a1,a2
 5f6:	0685                	addi	a3,a3,1
 5f8:	fec7f0e3          	bgeu	a5,a2,5d8 <printint+0x2a>
  if(neg)
 5fc:	00088b63          	beqz	a7,612 <printint+0x64>
    buf[i++] = '-';
 600:	fd040793          	addi	a5,s0,-48
 604:	973e                	add	a4,a4,a5
 606:	02d00793          	li	a5,45
 60a:	fef70823          	sb	a5,-16(a4)
 60e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 612:	02e05863          	blez	a4,642 <printint+0x94>
 616:	fc040793          	addi	a5,s0,-64
 61a:	00e78933          	add	s2,a5,a4
 61e:	fff78993          	addi	s3,a5,-1
 622:	99ba                	add	s3,s3,a4
 624:	377d                	addiw	a4,a4,-1
 626:	1702                	slli	a4,a4,0x20
 628:	9301                	srli	a4,a4,0x20
 62a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 62e:	fff94583          	lbu	a1,-1(s2)
 632:	8526                	mv	a0,s1
 634:	00000097          	auipc	ra,0x0
 638:	f58080e7          	jalr	-168(ra) # 58c <putc>
  while(--i >= 0)
 63c:	197d                	addi	s2,s2,-1
 63e:	ff3918e3          	bne	s2,s3,62e <printint+0x80>
}
 642:	70e2                	ld	ra,56(sp)
 644:	7442                	ld	s0,48(sp)
 646:	74a2                	ld	s1,40(sp)
 648:	7902                	ld	s2,32(sp)
 64a:	69e2                	ld	s3,24(sp)
 64c:	6121                	addi	sp,sp,64
 64e:	8082                	ret
    x = -xx;
 650:	40b005bb          	negw	a1,a1
    neg = 1;
 654:	4885                	li	a7,1
    x = -xx;
 656:	bf8d                	j	5c8 <printint+0x1a>

0000000000000658 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 658:	7119                	addi	sp,sp,-128
 65a:	fc86                	sd	ra,120(sp)
 65c:	f8a2                	sd	s0,112(sp)
 65e:	f4a6                	sd	s1,104(sp)
 660:	f0ca                	sd	s2,96(sp)
 662:	ecce                	sd	s3,88(sp)
 664:	e8d2                	sd	s4,80(sp)
 666:	e4d6                	sd	s5,72(sp)
 668:	e0da                	sd	s6,64(sp)
 66a:	fc5e                	sd	s7,56(sp)
 66c:	f862                	sd	s8,48(sp)
 66e:	f466                	sd	s9,40(sp)
 670:	f06a                	sd	s10,32(sp)
 672:	ec6e                	sd	s11,24(sp)
 674:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 676:	0005c903          	lbu	s2,0(a1)
 67a:	18090f63          	beqz	s2,818 <vprintf+0x1c0>
 67e:	8aaa                	mv	s5,a0
 680:	8b32                	mv	s6,a2
 682:	00158493          	addi	s1,a1,1
  state = 0;
 686:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 688:	02500a13          	li	s4,37
      if(c == 'd'){
 68c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 690:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 694:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 698:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 69c:	00000b97          	auipc	s7,0x0
 6a0:	3e4b8b93          	addi	s7,s7,996 # a80 <digits>
 6a4:	a839                	j	6c2 <vprintf+0x6a>
        putc(fd, c);
 6a6:	85ca                	mv	a1,s2
 6a8:	8556                	mv	a0,s5
 6aa:	00000097          	auipc	ra,0x0
 6ae:	ee2080e7          	jalr	-286(ra) # 58c <putc>
 6b2:	a019                	j	6b8 <vprintf+0x60>
    } else if(state == '%'){
 6b4:	01498f63          	beq	s3,s4,6d2 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6b8:	0485                	addi	s1,s1,1
 6ba:	fff4c903          	lbu	s2,-1(s1)
 6be:	14090d63          	beqz	s2,818 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6c2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6c6:	fe0997e3          	bnez	s3,6b4 <vprintf+0x5c>
      if(c == '%'){
 6ca:	fd479ee3          	bne	a5,s4,6a6 <vprintf+0x4e>
        state = '%';
 6ce:	89be                	mv	s3,a5
 6d0:	b7e5                	j	6b8 <vprintf+0x60>
      if(c == 'd'){
 6d2:	05878063          	beq	a5,s8,712 <vprintf+0xba>
      } else if(c == 'l') {
 6d6:	05978c63          	beq	a5,s9,72e <vprintf+0xd6>
      } else if(c == 'x') {
 6da:	07a78863          	beq	a5,s10,74a <vprintf+0xf2>
      } else if(c == 'p') {
 6de:	09b78463          	beq	a5,s11,766 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6e2:	07300713          	li	a4,115
 6e6:	0ce78663          	beq	a5,a4,7b2 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ea:	06300713          	li	a4,99
 6ee:	0ee78e63          	beq	a5,a4,7ea <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6f2:	11478863          	beq	a5,s4,802 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6f6:	85d2                	mv	a1,s4
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	e92080e7          	jalr	-366(ra) # 58c <putc>
        putc(fd, c);
 702:	85ca                	mv	a1,s2
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	e86080e7          	jalr	-378(ra) # 58c <putc>
      }
      state = 0;
 70e:	4981                	li	s3,0
 710:	b765                	j	6b8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 712:	008b0913          	addi	s2,s6,8
 716:	4685                	li	a3,1
 718:	4629                	li	a2,10
 71a:	000b2583          	lw	a1,0(s6)
 71e:	8556                	mv	a0,s5
 720:	00000097          	auipc	ra,0x0
 724:	e8e080e7          	jalr	-370(ra) # 5ae <printint>
 728:	8b4a                	mv	s6,s2
      state = 0;
 72a:	4981                	li	s3,0
 72c:	b771                	j	6b8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 72e:	008b0913          	addi	s2,s6,8
 732:	4681                	li	a3,0
 734:	4629                	li	a2,10
 736:	000b2583          	lw	a1,0(s6)
 73a:	8556                	mv	a0,s5
 73c:	00000097          	auipc	ra,0x0
 740:	e72080e7          	jalr	-398(ra) # 5ae <printint>
 744:	8b4a                	mv	s6,s2
      state = 0;
 746:	4981                	li	s3,0
 748:	bf85                	j	6b8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 74a:	008b0913          	addi	s2,s6,8
 74e:	4681                	li	a3,0
 750:	4641                	li	a2,16
 752:	000b2583          	lw	a1,0(s6)
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	e56080e7          	jalr	-426(ra) # 5ae <printint>
 760:	8b4a                	mv	s6,s2
      state = 0;
 762:	4981                	li	s3,0
 764:	bf91                	j	6b8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 766:	008b0793          	addi	a5,s6,8
 76a:	f8f43423          	sd	a5,-120(s0)
 76e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 772:	03000593          	li	a1,48
 776:	8556                	mv	a0,s5
 778:	00000097          	auipc	ra,0x0
 77c:	e14080e7          	jalr	-492(ra) # 58c <putc>
  putc(fd, 'x');
 780:	85ea                	mv	a1,s10
 782:	8556                	mv	a0,s5
 784:	00000097          	auipc	ra,0x0
 788:	e08080e7          	jalr	-504(ra) # 58c <putc>
 78c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 78e:	03c9d793          	srli	a5,s3,0x3c
 792:	97de                	add	a5,a5,s7
 794:	0007c583          	lbu	a1,0(a5)
 798:	8556                	mv	a0,s5
 79a:	00000097          	auipc	ra,0x0
 79e:	df2080e7          	jalr	-526(ra) # 58c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7a2:	0992                	slli	s3,s3,0x4
 7a4:	397d                	addiw	s2,s2,-1
 7a6:	fe0914e3          	bnez	s2,78e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7aa:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	b721                	j	6b8 <vprintf+0x60>
        s = va_arg(ap, char*);
 7b2:	008b0993          	addi	s3,s6,8
 7b6:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7ba:	02090163          	beqz	s2,7dc <vprintf+0x184>
        while(*s != 0){
 7be:	00094583          	lbu	a1,0(s2)
 7c2:	c9a1                	beqz	a1,812 <vprintf+0x1ba>
          putc(fd, *s);
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	dc6080e7          	jalr	-570(ra) # 58c <putc>
          s++;
 7ce:	0905                	addi	s2,s2,1
        while(*s != 0){
 7d0:	00094583          	lbu	a1,0(s2)
 7d4:	f9e5                	bnez	a1,7c4 <vprintf+0x16c>
        s = va_arg(ap, char*);
 7d6:	8b4e                	mv	s6,s3
      state = 0;
 7d8:	4981                	li	s3,0
 7da:	bdf9                	j	6b8 <vprintf+0x60>
          s = "(null)";
 7dc:	00000917          	auipc	s2,0x0
 7e0:	29c90913          	addi	s2,s2,668 # a78 <malloc+0x156>
        while(*s != 0){
 7e4:	02800593          	li	a1,40
 7e8:	bff1                	j	7c4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7ea:	008b0913          	addi	s2,s6,8
 7ee:	000b4583          	lbu	a1,0(s6)
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	d98080e7          	jalr	-616(ra) # 58c <putc>
 7fc:	8b4a                	mv	s6,s2
      state = 0;
 7fe:	4981                	li	s3,0
 800:	bd65                	j	6b8 <vprintf+0x60>
        putc(fd, c);
 802:	85d2                	mv	a1,s4
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	d86080e7          	jalr	-634(ra) # 58c <putc>
      state = 0;
 80e:	4981                	li	s3,0
 810:	b565                	j	6b8 <vprintf+0x60>
        s = va_arg(ap, char*);
 812:	8b4e                	mv	s6,s3
      state = 0;
 814:	4981                	li	s3,0
 816:	b54d                	j	6b8 <vprintf+0x60>
    }
  }
}
 818:	70e6                	ld	ra,120(sp)
 81a:	7446                	ld	s0,112(sp)
 81c:	74a6                	ld	s1,104(sp)
 81e:	7906                	ld	s2,96(sp)
 820:	69e6                	ld	s3,88(sp)
 822:	6a46                	ld	s4,80(sp)
 824:	6aa6                	ld	s5,72(sp)
 826:	6b06                	ld	s6,64(sp)
 828:	7be2                	ld	s7,56(sp)
 82a:	7c42                	ld	s8,48(sp)
 82c:	7ca2                	ld	s9,40(sp)
 82e:	7d02                	ld	s10,32(sp)
 830:	6de2                	ld	s11,24(sp)
 832:	6109                	addi	sp,sp,128
 834:	8082                	ret

0000000000000836 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 836:	715d                	addi	sp,sp,-80
 838:	ec06                	sd	ra,24(sp)
 83a:	e822                	sd	s0,16(sp)
 83c:	1000                	addi	s0,sp,32
 83e:	e010                	sd	a2,0(s0)
 840:	e414                	sd	a3,8(s0)
 842:	e818                	sd	a4,16(s0)
 844:	ec1c                	sd	a5,24(s0)
 846:	03043023          	sd	a6,32(s0)
 84a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 84e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 852:	8622                	mv	a2,s0
 854:	00000097          	auipc	ra,0x0
 858:	e04080e7          	jalr	-508(ra) # 658 <vprintf>
}
 85c:	60e2                	ld	ra,24(sp)
 85e:	6442                	ld	s0,16(sp)
 860:	6161                	addi	sp,sp,80
 862:	8082                	ret

0000000000000864 <printf>:

void
printf(const char *fmt, ...)
{
 864:	711d                	addi	sp,sp,-96
 866:	ec06                	sd	ra,24(sp)
 868:	e822                	sd	s0,16(sp)
 86a:	1000                	addi	s0,sp,32
 86c:	e40c                	sd	a1,8(s0)
 86e:	e810                	sd	a2,16(s0)
 870:	ec14                	sd	a3,24(s0)
 872:	f018                	sd	a4,32(s0)
 874:	f41c                	sd	a5,40(s0)
 876:	03043823          	sd	a6,48(s0)
 87a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 87e:	00840613          	addi	a2,s0,8
 882:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 886:	85aa                	mv	a1,a0
 888:	4505                	li	a0,1
 88a:	00000097          	auipc	ra,0x0
 88e:	dce080e7          	jalr	-562(ra) # 658 <vprintf>
}
 892:	60e2                	ld	ra,24(sp)
 894:	6442                	ld	s0,16(sp)
 896:	6125                	addi	sp,sp,96
 898:	8082                	ret

000000000000089a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 89a:	1141                	addi	sp,sp,-16
 89c:	e422                	sd	s0,8(sp)
 89e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8a0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a4:	00000797          	auipc	a5,0x0
 8a8:	1f47b783          	ld	a5,500(a5) # a98 <freep>
 8ac:	a805                	j	8dc <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8ae:	4618                	lw	a4,8(a2)
 8b0:	9db9                	addw	a1,a1,a4
 8b2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b6:	6398                	ld	a4,0(a5)
 8b8:	6318                	ld	a4,0(a4)
 8ba:	fee53823          	sd	a4,-16(a0)
 8be:	a091                	j	902 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8c0:	ff852703          	lw	a4,-8(a0)
 8c4:	9e39                	addw	a2,a2,a4
 8c6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8c8:	ff053703          	ld	a4,-16(a0)
 8cc:	e398                	sd	a4,0(a5)
 8ce:	a099                	j	914 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d0:	6398                	ld	a4,0(a5)
 8d2:	00e7e463          	bltu	a5,a4,8da <free+0x40>
 8d6:	00e6ea63          	bltu	a3,a4,8ea <free+0x50>
{
 8da:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8dc:	fed7fae3          	bgeu	a5,a3,8d0 <free+0x36>
 8e0:	6398                	ld	a4,0(a5)
 8e2:	00e6e463          	bltu	a3,a4,8ea <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e6:	fee7eae3          	bltu	a5,a4,8da <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8ea:	ff852583          	lw	a1,-8(a0)
 8ee:	6390                	ld	a2,0(a5)
 8f0:	02059813          	slli	a6,a1,0x20
 8f4:	01c85713          	srli	a4,a6,0x1c
 8f8:	9736                	add	a4,a4,a3
 8fa:	fae60ae3          	beq	a2,a4,8ae <free+0x14>
    bp->s.ptr = p->s.ptr;
 8fe:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 902:	4790                	lw	a2,8(a5)
 904:	02061593          	slli	a1,a2,0x20
 908:	01c5d713          	srli	a4,a1,0x1c
 90c:	973e                	add	a4,a4,a5
 90e:	fae689e3          	beq	a3,a4,8c0 <free+0x26>
  } else
    p->s.ptr = bp;
 912:	e394                	sd	a3,0(a5)
  freep = p;
 914:	00000717          	auipc	a4,0x0
 918:	18f73223          	sd	a5,388(a4) # a98 <freep>
}
 91c:	6422                	ld	s0,8(sp)
 91e:	0141                	addi	sp,sp,16
 920:	8082                	ret

0000000000000922 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 922:	7139                	addi	sp,sp,-64
 924:	fc06                	sd	ra,56(sp)
 926:	f822                	sd	s0,48(sp)
 928:	f426                	sd	s1,40(sp)
 92a:	f04a                	sd	s2,32(sp)
 92c:	ec4e                	sd	s3,24(sp)
 92e:	e852                	sd	s4,16(sp)
 930:	e456                	sd	s5,8(sp)
 932:	e05a                	sd	s6,0(sp)
 934:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 936:	02051493          	slli	s1,a0,0x20
 93a:	9081                	srli	s1,s1,0x20
 93c:	04bd                	addi	s1,s1,15
 93e:	8091                	srli	s1,s1,0x4
 940:	0014899b          	addiw	s3,s1,1
 944:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 946:	00000517          	auipc	a0,0x0
 94a:	15253503          	ld	a0,338(a0) # a98 <freep>
 94e:	c515                	beqz	a0,97a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 950:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 952:	4798                	lw	a4,8(a5)
 954:	02977f63          	bgeu	a4,s1,992 <malloc+0x70>
 958:	8a4e                	mv	s4,s3
 95a:	0009871b          	sext.w	a4,s3
 95e:	6685                	lui	a3,0x1
 960:	00d77363          	bgeu	a4,a3,966 <malloc+0x44>
 964:	6a05                	lui	s4,0x1
 966:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 96a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 96e:	00000917          	auipc	s2,0x0
 972:	12a90913          	addi	s2,s2,298 # a98 <freep>
  if(p == (char*)-1)
 976:	5afd                	li	s5,-1
 978:	a895                	j	9ec <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 97a:	00000797          	auipc	a5,0x0
 97e:	13678793          	addi	a5,a5,310 # ab0 <base>
 982:	00000717          	auipc	a4,0x0
 986:	10f73b23          	sd	a5,278(a4) # a98 <freep>
 98a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 98c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 990:	b7e1                	j	958 <malloc+0x36>
      if(p->s.size == nunits)
 992:	02e48c63          	beq	s1,a4,9ca <malloc+0xa8>
        p->s.size -= nunits;
 996:	4137073b          	subw	a4,a4,s3
 99a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 99c:	02071693          	slli	a3,a4,0x20
 9a0:	01c6d713          	srli	a4,a3,0x1c
 9a4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9a6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9aa:	00000717          	auipc	a4,0x0
 9ae:	0ea73723          	sd	a0,238(a4) # a98 <freep>
      return (void*)(p + 1);
 9b2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9b6:	70e2                	ld	ra,56(sp)
 9b8:	7442                	ld	s0,48(sp)
 9ba:	74a2                	ld	s1,40(sp)
 9bc:	7902                	ld	s2,32(sp)
 9be:	69e2                	ld	s3,24(sp)
 9c0:	6a42                	ld	s4,16(sp)
 9c2:	6aa2                	ld	s5,8(sp)
 9c4:	6b02                	ld	s6,0(sp)
 9c6:	6121                	addi	sp,sp,64
 9c8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9ca:	6398                	ld	a4,0(a5)
 9cc:	e118                	sd	a4,0(a0)
 9ce:	bff1                	j	9aa <malloc+0x88>
  hp->s.size = nu;
 9d0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9d4:	0541                	addi	a0,a0,16
 9d6:	00000097          	auipc	ra,0x0
 9da:	ec4080e7          	jalr	-316(ra) # 89a <free>
  return freep;
 9de:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9e2:	d971                	beqz	a0,9b6 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e6:	4798                	lw	a4,8(a5)
 9e8:	fa9775e3          	bgeu	a4,s1,992 <malloc+0x70>
    if(p == freep)
 9ec:	00093703          	ld	a4,0(s2)
 9f0:	853e                	mv	a0,a5
 9f2:	fef719e3          	bne	a4,a5,9e4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 9f6:	8552                	mv	a0,s4
 9f8:	00000097          	auipc	ra,0x0
 9fc:	b7c080e7          	jalr	-1156(ra) # 574 <sbrk>
  if(p == (char*)-1)
 a00:	fd5518e3          	bne	a0,s5,9d0 <malloc+0xae>
        return 0;
 a04:	4501                	li	a0,0
 a06:	bf45                	j	9b6 <malloc+0x94>
