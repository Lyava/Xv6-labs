
user/_sleep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user.h"

int main(int argc,char* argv[]){
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    if(argc != 2){
   8:	4789                	li	a5,2
   a:	00f50f63          	beq	a0,a5,28 <main+0x28>
        printf("Sleep needs one argument!\n"); //检查参数数量是否正确
   e:	00000517          	auipc	a0,0x0
  12:	7d250513          	addi	a0,a0,2002 # 7e0 <malloc+0xe8>
  16:	00000097          	auipc	ra,0x0
  1a:	624080e7          	jalr	1572(ra) # 63a <printf>
        exit(-1);
  1e:	557d                	li	a0,-1
  20:	00000097          	auipc	ra,0x0
  24:	2a2080e7          	jalr	674(ra) # 2c2 <exit>
    }
    int ticks = atoi(argv[1]); //将字符串参数转为整数
  28:	6588                	ld	a0,8(a1)
  2a:	00000097          	auipc	ra,0x0
  2e:	19c080e7          	jalr	412(ra) # 1c6 <atoi>
    sleep(ticks);              //使用系统调用sleep
  32:	00000097          	auipc	ra,0x0
  36:	320080e7          	jalr	800(ra) # 352 <sleep>
    printf("(nothing happens for a little while)\n");
  3a:	00000517          	auipc	a0,0x0
  3e:	7c650513          	addi	a0,a0,1990 # 800 <malloc+0x108>
  42:	00000097          	auipc	ra,0x0
  46:	5f8080e7          	jalr	1528(ra) # 63a <printf>
    exit(0); //确保进程退出
  4a:	4501                	li	a0,0
  4c:	00000097          	auipc	ra,0x0
  50:	276080e7          	jalr	630(ra) # 2c2 <exit>

0000000000000054 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  54:	1141                	addi	sp,sp,-16
  56:	e422                	sd	s0,8(sp)
  58:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  5a:	87aa                	mv	a5,a0
  5c:	0585                	addi	a1,a1,1
  5e:	0785                	addi	a5,a5,1
  60:	fff5c703          	lbu	a4,-1(a1)
  64:	fee78fa3          	sb	a4,-1(a5)
  68:	fb75                	bnez	a4,5c <strcpy+0x8>
    ;
  return os;
}
  6a:	6422                	ld	s0,8(sp)
  6c:	0141                	addi	sp,sp,16
  6e:	8082                	ret

0000000000000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  70:	1141                	addi	sp,sp,-16
  72:	e422                	sd	s0,8(sp)
  74:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  76:	00054783          	lbu	a5,0(a0)
  7a:	cb91                	beqz	a5,8e <strcmp+0x1e>
  7c:	0005c703          	lbu	a4,0(a1)
  80:	00f71763          	bne	a4,a5,8e <strcmp+0x1e>
    p++, q++;
  84:	0505                	addi	a0,a0,1
  86:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  88:	00054783          	lbu	a5,0(a0)
  8c:	fbe5                	bnez	a5,7c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  8e:	0005c503          	lbu	a0,0(a1)
}
  92:	40a7853b          	subw	a0,a5,a0
  96:	6422                	ld	s0,8(sp)
  98:	0141                	addi	sp,sp,16
  9a:	8082                	ret

000000000000009c <strlen>:

uint
strlen(const char *s)
{
  9c:	1141                	addi	sp,sp,-16
  9e:	e422                	sd	s0,8(sp)
  a0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  a2:	00054783          	lbu	a5,0(a0)
  a6:	cf91                	beqz	a5,c2 <strlen+0x26>
  a8:	0505                	addi	a0,a0,1
  aa:	87aa                	mv	a5,a0
  ac:	4685                	li	a3,1
  ae:	9e89                	subw	a3,a3,a0
  b0:	00f6853b          	addw	a0,a3,a5
  b4:	0785                	addi	a5,a5,1
  b6:	fff7c703          	lbu	a4,-1(a5)
  ba:	fb7d                	bnez	a4,b0 <strlen+0x14>
    ;
  return n;
}
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	addi	sp,sp,16
  c0:	8082                	ret
  for(n = 0; s[n]; n++)
  c2:	4501                	li	a0,0
  c4:	bfe5                	j	bc <strlen+0x20>

00000000000000c6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c6:	1141                	addi	sp,sp,-16
  c8:	e422                	sd	s0,8(sp)
  ca:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  cc:	ca19                	beqz	a2,e2 <memset+0x1c>
  ce:	87aa                	mv	a5,a0
  d0:	1602                	slli	a2,a2,0x20
  d2:	9201                	srli	a2,a2,0x20
  d4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  d8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  dc:	0785                	addi	a5,a5,1
  de:	fee79de3          	bne	a5,a4,d8 <memset+0x12>
  }
  return dst;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	addi	sp,sp,16
  e6:	8082                	ret

00000000000000e8 <strchr>:

char*
strchr(const char *s, char c)
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	addi	s0,sp,16
  for(; *s; s++)
  ee:	00054783          	lbu	a5,0(a0)
  f2:	cb99                	beqz	a5,108 <strchr+0x20>
    if(*s == c)
  f4:	00f58763          	beq	a1,a5,102 <strchr+0x1a>
  for(; *s; s++)
  f8:	0505                	addi	a0,a0,1
  fa:	00054783          	lbu	a5,0(a0)
  fe:	fbfd                	bnez	a5,f4 <strchr+0xc>
      return (char*)s;
  return 0;
 100:	4501                	li	a0,0
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret
  return 0;
 108:	4501                	li	a0,0
 10a:	bfe5                	j	102 <strchr+0x1a>

000000000000010c <gets>:

char*
gets(char *buf, int max)
{
 10c:	711d                	addi	sp,sp,-96
 10e:	ec86                	sd	ra,88(sp)
 110:	e8a2                	sd	s0,80(sp)
 112:	e4a6                	sd	s1,72(sp)
 114:	e0ca                	sd	s2,64(sp)
 116:	fc4e                	sd	s3,56(sp)
 118:	f852                	sd	s4,48(sp)
 11a:	f456                	sd	s5,40(sp)
 11c:	f05a                	sd	s6,32(sp)
 11e:	ec5e                	sd	s7,24(sp)
 120:	1080                	addi	s0,sp,96
 122:	8baa                	mv	s7,a0
 124:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 126:	892a                	mv	s2,a0
 128:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 12a:	4aa9                	li	s5,10
 12c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 12e:	89a6                	mv	s3,s1
 130:	2485                	addiw	s1,s1,1
 132:	0344d863          	bge	s1,s4,162 <gets+0x56>
    cc = read(0, &c, 1);
 136:	4605                	li	a2,1
 138:	faf40593          	addi	a1,s0,-81
 13c:	4501                	li	a0,0
 13e:	00000097          	auipc	ra,0x0
 142:	19c080e7          	jalr	412(ra) # 2da <read>
    if(cc < 1)
 146:	00a05e63          	blez	a0,162 <gets+0x56>
    buf[i++] = c;
 14a:	faf44783          	lbu	a5,-81(s0)
 14e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 152:	01578763          	beq	a5,s5,160 <gets+0x54>
 156:	0905                	addi	s2,s2,1
 158:	fd679be3          	bne	a5,s6,12e <gets+0x22>
  for(i=0; i+1 < max; ){
 15c:	89a6                	mv	s3,s1
 15e:	a011                	j	162 <gets+0x56>
 160:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 162:	99de                	add	s3,s3,s7
 164:	00098023          	sb	zero,0(s3)
  return buf;
}
 168:	855e                	mv	a0,s7
 16a:	60e6                	ld	ra,88(sp)
 16c:	6446                	ld	s0,80(sp)
 16e:	64a6                	ld	s1,72(sp)
 170:	6906                	ld	s2,64(sp)
 172:	79e2                	ld	s3,56(sp)
 174:	7a42                	ld	s4,48(sp)
 176:	7aa2                	ld	s5,40(sp)
 178:	7b02                	ld	s6,32(sp)
 17a:	6be2                	ld	s7,24(sp)
 17c:	6125                	addi	sp,sp,96
 17e:	8082                	ret

0000000000000180 <stat>:

int
stat(const char *n, struct stat *st)
{
 180:	1101                	addi	sp,sp,-32
 182:	ec06                	sd	ra,24(sp)
 184:	e822                	sd	s0,16(sp)
 186:	e426                	sd	s1,8(sp)
 188:	e04a                	sd	s2,0(sp)
 18a:	1000                	addi	s0,sp,32
 18c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18e:	4581                	li	a1,0
 190:	00000097          	auipc	ra,0x0
 194:	172080e7          	jalr	370(ra) # 302 <open>
  if(fd < 0)
 198:	02054563          	bltz	a0,1c2 <stat+0x42>
 19c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 19e:	85ca                	mv	a1,s2
 1a0:	00000097          	auipc	ra,0x0
 1a4:	17a080e7          	jalr	378(ra) # 31a <fstat>
 1a8:	892a                	mv	s2,a0
  close(fd);
 1aa:	8526                	mv	a0,s1
 1ac:	00000097          	auipc	ra,0x0
 1b0:	13e080e7          	jalr	318(ra) # 2ea <close>
  return r;
}
 1b4:	854a                	mv	a0,s2
 1b6:	60e2                	ld	ra,24(sp)
 1b8:	6442                	ld	s0,16(sp)
 1ba:	64a2                	ld	s1,8(sp)
 1bc:	6902                	ld	s2,0(sp)
 1be:	6105                	addi	sp,sp,32
 1c0:	8082                	ret
    return -1;
 1c2:	597d                	li	s2,-1
 1c4:	bfc5                	j	1b4 <stat+0x34>

00000000000001c6 <atoi>:

int
atoi(const char *s)
{
 1c6:	1141                	addi	sp,sp,-16
 1c8:	e422                	sd	s0,8(sp)
 1ca:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1cc:	00054603          	lbu	a2,0(a0)
 1d0:	fd06079b          	addiw	a5,a2,-48
 1d4:	0ff7f793          	zext.b	a5,a5
 1d8:	4725                	li	a4,9
 1da:	02f76963          	bltu	a4,a5,20c <atoi+0x46>
 1de:	86aa                	mv	a3,a0
  n = 0;
 1e0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1e2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1e4:	0685                	addi	a3,a3,1
 1e6:	0025179b          	slliw	a5,a0,0x2
 1ea:	9fa9                	addw	a5,a5,a0
 1ec:	0017979b          	slliw	a5,a5,0x1
 1f0:	9fb1                	addw	a5,a5,a2
 1f2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f6:	0006c603          	lbu	a2,0(a3)
 1fa:	fd06071b          	addiw	a4,a2,-48
 1fe:	0ff77713          	zext.b	a4,a4
 202:	fee5f1e3          	bgeu	a1,a4,1e4 <atoi+0x1e>
  return n;
}
 206:	6422                	ld	s0,8(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret
  n = 0;
 20c:	4501                	li	a0,0
 20e:	bfe5                	j	206 <atoi+0x40>

0000000000000210 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 210:	1141                	addi	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 216:	02b57463          	bgeu	a0,a1,23e <memmove+0x2e>
    while(n-- > 0)
 21a:	00c05f63          	blez	a2,238 <memmove+0x28>
 21e:	1602                	slli	a2,a2,0x20
 220:	9201                	srli	a2,a2,0x20
 222:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 226:	872a                	mv	a4,a0
      *dst++ = *src++;
 228:	0585                	addi	a1,a1,1
 22a:	0705                	addi	a4,a4,1
 22c:	fff5c683          	lbu	a3,-1(a1)
 230:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 234:	fee79ae3          	bne	a5,a4,228 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	addi	sp,sp,16
 23c:	8082                	ret
    dst += n;
 23e:	00c50733          	add	a4,a0,a2
    src += n;
 242:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 244:	fec05ae3          	blez	a2,238 <memmove+0x28>
 248:	fff6079b          	addiw	a5,a2,-1
 24c:	1782                	slli	a5,a5,0x20
 24e:	9381                	srli	a5,a5,0x20
 250:	fff7c793          	not	a5,a5
 254:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 256:	15fd                	addi	a1,a1,-1
 258:	177d                	addi	a4,a4,-1
 25a:	0005c683          	lbu	a3,0(a1)
 25e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 262:	fee79ae3          	bne	a5,a4,256 <memmove+0x46>
 266:	bfc9                	j	238 <memmove+0x28>

0000000000000268 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 26e:	ca05                	beqz	a2,29e <memcmp+0x36>
 270:	fff6069b          	addiw	a3,a2,-1
 274:	1682                	slli	a3,a3,0x20
 276:	9281                	srli	a3,a3,0x20
 278:	0685                	addi	a3,a3,1
 27a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 27c:	00054783          	lbu	a5,0(a0)
 280:	0005c703          	lbu	a4,0(a1)
 284:	00e79863          	bne	a5,a4,294 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 288:	0505                	addi	a0,a0,1
    p2++;
 28a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 28c:	fed518e3          	bne	a0,a3,27c <memcmp+0x14>
  }
  return 0;
 290:	4501                	li	a0,0
 292:	a019                	j	298 <memcmp+0x30>
      return *p1 - *p2;
 294:	40e7853b          	subw	a0,a5,a4
}
 298:	6422                	ld	s0,8(sp)
 29a:	0141                	addi	sp,sp,16
 29c:	8082                	ret
  return 0;
 29e:	4501                	li	a0,0
 2a0:	bfe5                	j	298 <memcmp+0x30>

00000000000002a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a2:	1141                	addi	sp,sp,-16
 2a4:	e406                	sd	ra,8(sp)
 2a6:	e022                	sd	s0,0(sp)
 2a8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2aa:	00000097          	auipc	ra,0x0
 2ae:	f66080e7          	jalr	-154(ra) # 210 <memmove>
}
 2b2:	60a2                	ld	ra,8(sp)
 2b4:	6402                	ld	s0,0(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2ba:	4885                	li	a7,1
 ecall
 2bc:	00000073          	ecall
 ret
 2c0:	8082                	ret

00000000000002c2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2c2:	4889                	li	a7,2
 ecall
 2c4:	00000073          	ecall
 ret
 2c8:	8082                	ret

00000000000002ca <wait>:
.global wait
wait:
 li a7, SYS_wait
 2ca:	488d                	li	a7,3
 ecall
 2cc:	00000073          	ecall
 ret
 2d0:	8082                	ret

00000000000002d2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2d2:	4891                	li	a7,4
 ecall
 2d4:	00000073          	ecall
 ret
 2d8:	8082                	ret

00000000000002da <read>:
.global read
read:
 li a7, SYS_read
 2da:	4895                	li	a7,5
 ecall
 2dc:	00000073          	ecall
 ret
 2e0:	8082                	ret

00000000000002e2 <write>:
.global write
write:
 li a7, SYS_write
 2e2:	48c1                	li	a7,16
 ecall
 2e4:	00000073          	ecall
 ret
 2e8:	8082                	ret

00000000000002ea <close>:
.global close
close:
 li a7, SYS_close
 2ea:	48d5                	li	a7,21
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2f2:	4899                	li	a7,6
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <exec>:
.global exec
exec:
 li a7, SYS_exec
 2fa:	489d                	li	a7,7
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <open>:
.global open
open:
 li a7, SYS_open
 302:	48bd                	li	a7,15
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 30a:	48c5                	li	a7,17
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 312:	48c9                	li	a7,18
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 31a:	48a1                	li	a7,8
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <link>:
.global link
link:
 li a7, SYS_link
 322:	48cd                	li	a7,19
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 32a:	48d1                	li	a7,20
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 332:	48a5                	li	a7,9
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <dup>:
.global dup
dup:
 li a7, SYS_dup
 33a:	48a9                	li	a7,10
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 342:	48ad                	li	a7,11
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 34a:	48b1                	li	a7,12
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 352:	48b5                	li	a7,13
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 35a:	48b9                	li	a7,14
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 362:	1101                	addi	sp,sp,-32
 364:	ec06                	sd	ra,24(sp)
 366:	e822                	sd	s0,16(sp)
 368:	1000                	addi	s0,sp,32
 36a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 36e:	4605                	li	a2,1
 370:	fef40593          	addi	a1,s0,-17
 374:	00000097          	auipc	ra,0x0
 378:	f6e080e7          	jalr	-146(ra) # 2e2 <write>
}
 37c:	60e2                	ld	ra,24(sp)
 37e:	6442                	ld	s0,16(sp)
 380:	6105                	addi	sp,sp,32
 382:	8082                	ret

0000000000000384 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 384:	7139                	addi	sp,sp,-64
 386:	fc06                	sd	ra,56(sp)
 388:	f822                	sd	s0,48(sp)
 38a:	f426                	sd	s1,40(sp)
 38c:	f04a                	sd	s2,32(sp)
 38e:	ec4e                	sd	s3,24(sp)
 390:	0080                	addi	s0,sp,64
 392:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 394:	c299                	beqz	a3,39a <printint+0x16>
 396:	0805c863          	bltz	a1,426 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 39a:	2581                	sext.w	a1,a1
  neg = 0;
 39c:	4881                	li	a7,0
 39e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3a2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3a4:	2601                	sext.w	a2,a2
 3a6:	00000517          	auipc	a0,0x0
 3aa:	48a50513          	addi	a0,a0,1162 # 830 <digits>
 3ae:	883a                	mv	a6,a4
 3b0:	2705                	addiw	a4,a4,1
 3b2:	02c5f7bb          	remuw	a5,a1,a2
 3b6:	1782                	slli	a5,a5,0x20
 3b8:	9381                	srli	a5,a5,0x20
 3ba:	97aa                	add	a5,a5,a0
 3bc:	0007c783          	lbu	a5,0(a5)
 3c0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3c4:	0005879b          	sext.w	a5,a1
 3c8:	02c5d5bb          	divuw	a1,a1,a2
 3cc:	0685                	addi	a3,a3,1
 3ce:	fec7f0e3          	bgeu	a5,a2,3ae <printint+0x2a>
  if(neg)
 3d2:	00088b63          	beqz	a7,3e8 <printint+0x64>
    buf[i++] = '-';
 3d6:	fd040793          	addi	a5,s0,-48
 3da:	973e                	add	a4,a4,a5
 3dc:	02d00793          	li	a5,45
 3e0:	fef70823          	sb	a5,-16(a4)
 3e4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3e8:	02e05863          	blez	a4,418 <printint+0x94>
 3ec:	fc040793          	addi	a5,s0,-64
 3f0:	00e78933          	add	s2,a5,a4
 3f4:	fff78993          	addi	s3,a5,-1
 3f8:	99ba                	add	s3,s3,a4
 3fa:	377d                	addiw	a4,a4,-1
 3fc:	1702                	slli	a4,a4,0x20
 3fe:	9301                	srli	a4,a4,0x20
 400:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 404:	fff94583          	lbu	a1,-1(s2)
 408:	8526                	mv	a0,s1
 40a:	00000097          	auipc	ra,0x0
 40e:	f58080e7          	jalr	-168(ra) # 362 <putc>
  while(--i >= 0)
 412:	197d                	addi	s2,s2,-1
 414:	ff3918e3          	bne	s2,s3,404 <printint+0x80>
}
 418:	70e2                	ld	ra,56(sp)
 41a:	7442                	ld	s0,48(sp)
 41c:	74a2                	ld	s1,40(sp)
 41e:	7902                	ld	s2,32(sp)
 420:	69e2                	ld	s3,24(sp)
 422:	6121                	addi	sp,sp,64
 424:	8082                	ret
    x = -xx;
 426:	40b005bb          	negw	a1,a1
    neg = 1;
 42a:	4885                	li	a7,1
    x = -xx;
 42c:	bf8d                	j	39e <printint+0x1a>

000000000000042e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 42e:	7119                	addi	sp,sp,-128
 430:	fc86                	sd	ra,120(sp)
 432:	f8a2                	sd	s0,112(sp)
 434:	f4a6                	sd	s1,104(sp)
 436:	f0ca                	sd	s2,96(sp)
 438:	ecce                	sd	s3,88(sp)
 43a:	e8d2                	sd	s4,80(sp)
 43c:	e4d6                	sd	s5,72(sp)
 43e:	e0da                	sd	s6,64(sp)
 440:	fc5e                	sd	s7,56(sp)
 442:	f862                	sd	s8,48(sp)
 444:	f466                	sd	s9,40(sp)
 446:	f06a                	sd	s10,32(sp)
 448:	ec6e                	sd	s11,24(sp)
 44a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 44c:	0005c903          	lbu	s2,0(a1)
 450:	18090f63          	beqz	s2,5ee <vprintf+0x1c0>
 454:	8aaa                	mv	s5,a0
 456:	8b32                	mv	s6,a2
 458:	00158493          	addi	s1,a1,1
  state = 0;
 45c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 45e:	02500a13          	li	s4,37
      if(c == 'd'){
 462:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 466:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 46a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 46e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 472:	00000b97          	auipc	s7,0x0
 476:	3beb8b93          	addi	s7,s7,958 # 830 <digits>
 47a:	a839                	j	498 <vprintf+0x6a>
        putc(fd, c);
 47c:	85ca                	mv	a1,s2
 47e:	8556                	mv	a0,s5
 480:	00000097          	auipc	ra,0x0
 484:	ee2080e7          	jalr	-286(ra) # 362 <putc>
 488:	a019                	j	48e <vprintf+0x60>
    } else if(state == '%'){
 48a:	01498f63          	beq	s3,s4,4a8 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 48e:	0485                	addi	s1,s1,1
 490:	fff4c903          	lbu	s2,-1(s1)
 494:	14090d63          	beqz	s2,5ee <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 498:	0009079b          	sext.w	a5,s2
    if(state == 0){
 49c:	fe0997e3          	bnez	s3,48a <vprintf+0x5c>
      if(c == '%'){
 4a0:	fd479ee3          	bne	a5,s4,47c <vprintf+0x4e>
        state = '%';
 4a4:	89be                	mv	s3,a5
 4a6:	b7e5                	j	48e <vprintf+0x60>
      if(c == 'd'){
 4a8:	05878063          	beq	a5,s8,4e8 <vprintf+0xba>
      } else if(c == 'l') {
 4ac:	05978c63          	beq	a5,s9,504 <vprintf+0xd6>
      } else if(c == 'x') {
 4b0:	07a78863          	beq	a5,s10,520 <vprintf+0xf2>
      } else if(c == 'p') {
 4b4:	09b78463          	beq	a5,s11,53c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 4b8:	07300713          	li	a4,115
 4bc:	0ce78663          	beq	a5,a4,588 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4c0:	06300713          	li	a4,99
 4c4:	0ee78e63          	beq	a5,a4,5c0 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 4c8:	11478863          	beq	a5,s4,5d8 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4cc:	85d2                	mv	a1,s4
 4ce:	8556                	mv	a0,s5
 4d0:	00000097          	auipc	ra,0x0
 4d4:	e92080e7          	jalr	-366(ra) # 362 <putc>
        putc(fd, c);
 4d8:	85ca                	mv	a1,s2
 4da:	8556                	mv	a0,s5
 4dc:	00000097          	auipc	ra,0x0
 4e0:	e86080e7          	jalr	-378(ra) # 362 <putc>
      }
      state = 0;
 4e4:	4981                	li	s3,0
 4e6:	b765                	j	48e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 4e8:	008b0913          	addi	s2,s6,8
 4ec:	4685                	li	a3,1
 4ee:	4629                	li	a2,10
 4f0:	000b2583          	lw	a1,0(s6)
 4f4:	8556                	mv	a0,s5
 4f6:	00000097          	auipc	ra,0x0
 4fa:	e8e080e7          	jalr	-370(ra) # 384 <printint>
 4fe:	8b4a                	mv	s6,s2
      state = 0;
 500:	4981                	li	s3,0
 502:	b771                	j	48e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 504:	008b0913          	addi	s2,s6,8
 508:	4681                	li	a3,0
 50a:	4629                	li	a2,10
 50c:	000b2583          	lw	a1,0(s6)
 510:	8556                	mv	a0,s5
 512:	00000097          	auipc	ra,0x0
 516:	e72080e7          	jalr	-398(ra) # 384 <printint>
 51a:	8b4a                	mv	s6,s2
      state = 0;
 51c:	4981                	li	s3,0
 51e:	bf85                	j	48e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 520:	008b0913          	addi	s2,s6,8
 524:	4681                	li	a3,0
 526:	4641                	li	a2,16
 528:	000b2583          	lw	a1,0(s6)
 52c:	8556                	mv	a0,s5
 52e:	00000097          	auipc	ra,0x0
 532:	e56080e7          	jalr	-426(ra) # 384 <printint>
 536:	8b4a                	mv	s6,s2
      state = 0;
 538:	4981                	li	s3,0
 53a:	bf91                	j	48e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 53c:	008b0793          	addi	a5,s6,8
 540:	f8f43423          	sd	a5,-120(s0)
 544:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 548:	03000593          	li	a1,48
 54c:	8556                	mv	a0,s5
 54e:	00000097          	auipc	ra,0x0
 552:	e14080e7          	jalr	-492(ra) # 362 <putc>
  putc(fd, 'x');
 556:	85ea                	mv	a1,s10
 558:	8556                	mv	a0,s5
 55a:	00000097          	auipc	ra,0x0
 55e:	e08080e7          	jalr	-504(ra) # 362 <putc>
 562:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 564:	03c9d793          	srli	a5,s3,0x3c
 568:	97de                	add	a5,a5,s7
 56a:	0007c583          	lbu	a1,0(a5)
 56e:	8556                	mv	a0,s5
 570:	00000097          	auipc	ra,0x0
 574:	df2080e7          	jalr	-526(ra) # 362 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 578:	0992                	slli	s3,s3,0x4
 57a:	397d                	addiw	s2,s2,-1
 57c:	fe0914e3          	bnez	s2,564 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 580:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 584:	4981                	li	s3,0
 586:	b721                	j	48e <vprintf+0x60>
        s = va_arg(ap, char*);
 588:	008b0993          	addi	s3,s6,8
 58c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 590:	02090163          	beqz	s2,5b2 <vprintf+0x184>
        while(*s != 0){
 594:	00094583          	lbu	a1,0(s2)
 598:	c9a1                	beqz	a1,5e8 <vprintf+0x1ba>
          putc(fd, *s);
 59a:	8556                	mv	a0,s5
 59c:	00000097          	auipc	ra,0x0
 5a0:	dc6080e7          	jalr	-570(ra) # 362 <putc>
          s++;
 5a4:	0905                	addi	s2,s2,1
        while(*s != 0){
 5a6:	00094583          	lbu	a1,0(s2)
 5aa:	f9e5                	bnez	a1,59a <vprintf+0x16c>
        s = va_arg(ap, char*);
 5ac:	8b4e                	mv	s6,s3
      state = 0;
 5ae:	4981                	li	s3,0
 5b0:	bdf9                	j	48e <vprintf+0x60>
          s = "(null)";
 5b2:	00000917          	auipc	s2,0x0
 5b6:	27690913          	addi	s2,s2,630 # 828 <malloc+0x130>
        while(*s != 0){
 5ba:	02800593          	li	a1,40
 5be:	bff1                	j	59a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 5c0:	008b0913          	addi	s2,s6,8
 5c4:	000b4583          	lbu	a1,0(s6)
 5c8:	8556                	mv	a0,s5
 5ca:	00000097          	auipc	ra,0x0
 5ce:	d98080e7          	jalr	-616(ra) # 362 <putc>
 5d2:	8b4a                	mv	s6,s2
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	bd65                	j	48e <vprintf+0x60>
        putc(fd, c);
 5d8:	85d2                	mv	a1,s4
 5da:	8556                	mv	a0,s5
 5dc:	00000097          	auipc	ra,0x0
 5e0:	d86080e7          	jalr	-634(ra) # 362 <putc>
      state = 0;
 5e4:	4981                	li	s3,0
 5e6:	b565                	j	48e <vprintf+0x60>
        s = va_arg(ap, char*);
 5e8:	8b4e                	mv	s6,s3
      state = 0;
 5ea:	4981                	li	s3,0
 5ec:	b54d                	j	48e <vprintf+0x60>
    }
  }
}
 5ee:	70e6                	ld	ra,120(sp)
 5f0:	7446                	ld	s0,112(sp)
 5f2:	74a6                	ld	s1,104(sp)
 5f4:	7906                	ld	s2,96(sp)
 5f6:	69e6                	ld	s3,88(sp)
 5f8:	6a46                	ld	s4,80(sp)
 5fa:	6aa6                	ld	s5,72(sp)
 5fc:	6b06                	ld	s6,64(sp)
 5fe:	7be2                	ld	s7,56(sp)
 600:	7c42                	ld	s8,48(sp)
 602:	7ca2                	ld	s9,40(sp)
 604:	7d02                	ld	s10,32(sp)
 606:	6de2                	ld	s11,24(sp)
 608:	6109                	addi	sp,sp,128
 60a:	8082                	ret

000000000000060c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 60c:	715d                	addi	sp,sp,-80
 60e:	ec06                	sd	ra,24(sp)
 610:	e822                	sd	s0,16(sp)
 612:	1000                	addi	s0,sp,32
 614:	e010                	sd	a2,0(s0)
 616:	e414                	sd	a3,8(s0)
 618:	e818                	sd	a4,16(s0)
 61a:	ec1c                	sd	a5,24(s0)
 61c:	03043023          	sd	a6,32(s0)
 620:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 624:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 628:	8622                	mv	a2,s0
 62a:	00000097          	auipc	ra,0x0
 62e:	e04080e7          	jalr	-508(ra) # 42e <vprintf>
}
 632:	60e2                	ld	ra,24(sp)
 634:	6442                	ld	s0,16(sp)
 636:	6161                	addi	sp,sp,80
 638:	8082                	ret

000000000000063a <printf>:

void
printf(const char *fmt, ...)
{
 63a:	711d                	addi	sp,sp,-96
 63c:	ec06                	sd	ra,24(sp)
 63e:	e822                	sd	s0,16(sp)
 640:	1000                	addi	s0,sp,32
 642:	e40c                	sd	a1,8(s0)
 644:	e810                	sd	a2,16(s0)
 646:	ec14                	sd	a3,24(s0)
 648:	f018                	sd	a4,32(s0)
 64a:	f41c                	sd	a5,40(s0)
 64c:	03043823          	sd	a6,48(s0)
 650:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 654:	00840613          	addi	a2,s0,8
 658:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 65c:	85aa                	mv	a1,a0
 65e:	4505                	li	a0,1
 660:	00000097          	auipc	ra,0x0
 664:	dce080e7          	jalr	-562(ra) # 42e <vprintf>
}
 668:	60e2                	ld	ra,24(sp)
 66a:	6442                	ld	s0,16(sp)
 66c:	6125                	addi	sp,sp,96
 66e:	8082                	ret

0000000000000670 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 670:	1141                	addi	sp,sp,-16
 672:	e422                	sd	s0,8(sp)
 674:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 676:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67a:	00000797          	auipc	a5,0x0
 67e:	1ce7b783          	ld	a5,462(a5) # 848 <freep>
 682:	a805                	j	6b2 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 684:	4618                	lw	a4,8(a2)
 686:	9db9                	addw	a1,a1,a4
 688:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 68c:	6398                	ld	a4,0(a5)
 68e:	6318                	ld	a4,0(a4)
 690:	fee53823          	sd	a4,-16(a0)
 694:	a091                	j	6d8 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 696:	ff852703          	lw	a4,-8(a0)
 69a:	9e39                	addw	a2,a2,a4
 69c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 69e:	ff053703          	ld	a4,-16(a0)
 6a2:	e398                	sd	a4,0(a5)
 6a4:	a099                	j	6ea <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a6:	6398                	ld	a4,0(a5)
 6a8:	00e7e463          	bltu	a5,a4,6b0 <free+0x40>
 6ac:	00e6ea63          	bltu	a3,a4,6c0 <free+0x50>
{
 6b0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b2:	fed7fae3          	bgeu	a5,a3,6a6 <free+0x36>
 6b6:	6398                	ld	a4,0(a5)
 6b8:	00e6e463          	bltu	a3,a4,6c0 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6bc:	fee7eae3          	bltu	a5,a4,6b0 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 6c0:	ff852583          	lw	a1,-8(a0)
 6c4:	6390                	ld	a2,0(a5)
 6c6:	02059813          	slli	a6,a1,0x20
 6ca:	01c85713          	srli	a4,a6,0x1c
 6ce:	9736                	add	a4,a4,a3
 6d0:	fae60ae3          	beq	a2,a4,684 <free+0x14>
    bp->s.ptr = p->s.ptr;
 6d4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6d8:	4790                	lw	a2,8(a5)
 6da:	02061593          	slli	a1,a2,0x20
 6de:	01c5d713          	srli	a4,a1,0x1c
 6e2:	973e                	add	a4,a4,a5
 6e4:	fae689e3          	beq	a3,a4,696 <free+0x26>
  } else
    p->s.ptr = bp;
 6e8:	e394                	sd	a3,0(a5)
  freep = p;
 6ea:	00000717          	auipc	a4,0x0
 6ee:	14f73f23          	sd	a5,350(a4) # 848 <freep>
}
 6f2:	6422                	ld	s0,8(sp)
 6f4:	0141                	addi	sp,sp,16
 6f6:	8082                	ret

00000000000006f8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f8:	7139                	addi	sp,sp,-64
 6fa:	fc06                	sd	ra,56(sp)
 6fc:	f822                	sd	s0,48(sp)
 6fe:	f426                	sd	s1,40(sp)
 700:	f04a                	sd	s2,32(sp)
 702:	ec4e                	sd	s3,24(sp)
 704:	e852                	sd	s4,16(sp)
 706:	e456                	sd	s5,8(sp)
 708:	e05a                	sd	s6,0(sp)
 70a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70c:	02051493          	slli	s1,a0,0x20
 710:	9081                	srli	s1,s1,0x20
 712:	04bd                	addi	s1,s1,15
 714:	8091                	srli	s1,s1,0x4
 716:	0014899b          	addiw	s3,s1,1
 71a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 71c:	00000517          	auipc	a0,0x0
 720:	12c53503          	ld	a0,300(a0) # 848 <freep>
 724:	c515                	beqz	a0,750 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 726:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 728:	4798                	lw	a4,8(a5)
 72a:	02977f63          	bgeu	a4,s1,768 <malloc+0x70>
 72e:	8a4e                	mv	s4,s3
 730:	0009871b          	sext.w	a4,s3
 734:	6685                	lui	a3,0x1
 736:	00d77363          	bgeu	a4,a3,73c <malloc+0x44>
 73a:	6a05                	lui	s4,0x1
 73c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 740:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 744:	00000917          	auipc	s2,0x0
 748:	10490913          	addi	s2,s2,260 # 848 <freep>
  if(p == (char*)-1)
 74c:	5afd                	li	s5,-1
 74e:	a895                	j	7c2 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 750:	00000797          	auipc	a5,0x0
 754:	10078793          	addi	a5,a5,256 # 850 <base>
 758:	00000717          	auipc	a4,0x0
 75c:	0ef73823          	sd	a5,240(a4) # 848 <freep>
 760:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 762:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 766:	b7e1                	j	72e <malloc+0x36>
      if(p->s.size == nunits)
 768:	02e48c63          	beq	s1,a4,7a0 <malloc+0xa8>
        p->s.size -= nunits;
 76c:	4137073b          	subw	a4,a4,s3
 770:	c798                	sw	a4,8(a5)
        p += p->s.size;
 772:	02071693          	slli	a3,a4,0x20
 776:	01c6d713          	srli	a4,a3,0x1c
 77a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 77c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 780:	00000717          	auipc	a4,0x0
 784:	0ca73423          	sd	a0,200(a4) # 848 <freep>
      return (void*)(p + 1);
 788:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 78c:	70e2                	ld	ra,56(sp)
 78e:	7442                	ld	s0,48(sp)
 790:	74a2                	ld	s1,40(sp)
 792:	7902                	ld	s2,32(sp)
 794:	69e2                	ld	s3,24(sp)
 796:	6a42                	ld	s4,16(sp)
 798:	6aa2                	ld	s5,8(sp)
 79a:	6b02                	ld	s6,0(sp)
 79c:	6121                	addi	sp,sp,64
 79e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7a0:	6398                	ld	a4,0(a5)
 7a2:	e118                	sd	a4,0(a0)
 7a4:	bff1                	j	780 <malloc+0x88>
  hp->s.size = nu;
 7a6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7aa:	0541                	addi	a0,a0,16
 7ac:	00000097          	auipc	ra,0x0
 7b0:	ec4080e7          	jalr	-316(ra) # 670 <free>
  return freep;
 7b4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 7b8:	d971                	beqz	a0,78c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ba:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7bc:	4798                	lw	a4,8(a5)
 7be:	fa9775e3          	bgeu	a4,s1,768 <malloc+0x70>
    if(p == freep)
 7c2:	00093703          	ld	a4,0(s2)
 7c6:	853e                	mv	a0,a5
 7c8:	fef719e3          	bne	a4,a5,7ba <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 7cc:	8552                	mv	a0,s4
 7ce:	00000097          	auipc	ra,0x0
 7d2:	b7c080e7          	jalr	-1156(ra) # 34a <sbrk>
  if(p == (char*)-1)
 7d6:	fd5518e3          	bne	a0,s5,7a6 <malloc+0xae>
        return 0;
 7da:	4501                	li	a0,0
 7dc:	bf45                	j	78c <malloc+0x94>
