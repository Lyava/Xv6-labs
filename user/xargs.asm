
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/param.h"

int main(int argc, char*argv[]){
   0:	7109                	addi	sp,sp,-384
   2:	fe86                	sd	ra,376(sp)
   4:	faa2                	sd	s0,368(sp)
   6:	f6a6                	sd	s1,360(sp)
   8:	f2ca                	sd	s2,352(sp)
   a:	eece                	sd	s3,344(sp)
   c:	ead2                	sd	s4,336(sp)
   e:	e6d6                	sd	s5,328(sp)
  10:	e2da                	sd	s6,320(sp)
  12:	fe5e                	sd	s7,312(sp)
  14:	fa62                	sd	s8,304(sp)
  16:	f666                	sd	s9,296(sp)
  18:	f26a                	sd	s10,288(sp)
  1a:	ee6e                	sd	s11,280(sp)
  1c:	0300                	addi	s0,sp,384
    if (argc < 2)
  1e:	4785                	li	a5,1
  20:	02a7da63          	bge	a5,a0,54 <main+0x54>
  24:	8dae                	mv	s11,a1
  26:	ffe50a1b          	addiw	s4,a0,-2
  2a:	020a1793          	slli	a5,s4,0x20
  2e:	01d7da13          	srli	s4,a5,0x1d
  32:	e9840793          	addi	a5,s0,-360
  36:	9a3e                	add	s4,s4,a5
        for(int i = 1; i < argc; i++){
            argv_c[i-1] = argv[i];
        }
        char *temp = (char*)malloc(512);
        int tempc = 0;  //tempc记录temp的尾字符
        int argc_c = argc - 1;
  38:	fff50d1b          	addiw	s10,a0,-1
        if(read(0, &arc, 1) <= 0){   //ctrl+D退出
            exit(0);
        }
        while(arc != '\n'){
  3c:	4c29                	li	s8,10
            printf("%c\n", arc);
  3e:	00001b17          	auipc	s6,0x1
  42:	8bab0b13          	addi	s6,s6,-1862 # 8f8 <malloc+0x102>
            if(arc == ' '){
  46:	02000a93          	li	s5,32
                argv_c[argc_c++] = temp;
                temp = 0;
            }else{
                temp[tempc++] = arc;
                printf("%s",temp);
  4a:	00001c97          	auipc	s9,0x1
  4e:	8b6c8c93          	addi	s9,s9,-1866 # 900 <malloc+0x10a>
  52:	a845                	j	102 <main+0x102>
        fprintf(2, "usage: xargs command\n");
  54:	00001597          	auipc	a1,0x1
  58:	88c58593          	addi	a1,a1,-1908 # 8e0 <malloc+0xea>
  5c:	4509                	li	a0,2
  5e:	00000097          	auipc	ra,0x0
  62:	6ac080e7          	jalr	1708(ra) # 70a <fprintf>
        exit(1);
  66:	4505                	li	a0,1
  68:	00000097          	auipc	ra,0x0
  6c:	358080e7          	jalr	856(ra) # 3c0 <exit>
            exit(0);
  70:	4501                	li	a0,0
  72:	00000097          	auipc	ra,0x0
  76:	34e080e7          	jalr	846(ra) # 3c0 <exit>
                temp[tempc++] = arc;
  7a:	00198b9b          	addiw	s7,s3,1
  7e:	99ca                	add	s3,s3,s2
  80:	00b98023          	sb	a1,0(s3)
                printf("%s",temp);
  84:	85ca                	mv	a1,s2
  86:	8566                	mv	a0,s9
  88:	00000097          	auipc	ra,0x0
  8c:	6b0080e7          	jalr	1712(ra) # 738 <printf>
                read(0, &arc, 1);
  90:	4605                	li	a2,1
  92:	e8f40593          	addi	a1,s0,-369
  96:	4501                	li	a0,0
  98:	00000097          	auipc	ra,0x0
  9c:	340080e7          	jalr	832(ra) # 3d8 <read>
        while(arc != '\n'){
  a0:	e8f44583          	lbu	a1,-369(s0)
  a4:	03858663          	beq	a1,s8,d0 <main+0xd0>
                temp[tempc++] = arc;
  a8:	89de                	mv	s3,s7
            printf("%c\n", arc);
  aa:	855a                	mv	a0,s6
  ac:	00000097          	auipc	ra,0x0
  b0:	68c080e7          	jalr	1676(ra) # 738 <printf>
            if(arc == ' '){
  b4:	e8f44583          	lbu	a1,-369(s0)
  b8:	fd5591e3          	bne	a1,s5,7a <main+0x7a>
                argv_c[argc_c++] = temp;
  bc:	00349793          	slli	a5,s1,0x3
  c0:	f9040713          	addi	a4,s0,-112
  c4:	97ba                	add	a5,a5,a4
  c6:	f127b023          	sd	s2,-256(a5)
  ca:	2485                	addiw	s1,s1,1
                temp = 0;
  cc:	4901                	li	s2,0
  ce:	bff1                	j	aa <main+0xaa>
            }
        }
        argv_c[argc_c++] = temp;
  d0:	00349793          	slli	a5,s1,0x3
  d4:	f9040713          	addi	a4,s0,-112
  d8:	97ba                	add	a5,a5,a4
  da:	f127b023          	sd	s2,-256(a5)
        argv_c[argc_c] = 0;
  de:	2485                	addiw	s1,s1,1
  e0:	048e                	slli	s1,s1,0x3
  e2:	94ba                	add	s1,s1,a4
  e4:	f004b023          	sd	zero,-256(s1)
        //printf("%s", temp);
        if(fork() == 0){
  e8:	00000097          	auipc	ra,0x0
  ec:	2d0080e7          	jalr	720(ra) # 3b8 <fork>
  f0:	e939                	bnez	a0,146 <main+0x146>
            exec(argv_c[0], argv_c);
  f2:	e9040593          	addi	a1,s0,-368
  f6:	e9043503          	ld	a0,-368(s0)
  fa:	00000097          	auipc	ra,0x0
  fe:	2fe080e7          	jalr	766(ra) # 3f8 <exec>
        for(int i = 1; i < argc; i++){
 102:	008d8713          	addi	a4,s11,8
int main(int argc, char*argv[]){
 106:	e9040793          	addi	a5,s0,-368
            argv_c[i-1] = argv[i];
 10a:	6314                	ld	a3,0(a4)
 10c:	e394                	sd	a3,0(a5)
        for(int i = 1; i < argc; i++){
 10e:	0721                	addi	a4,a4,8
 110:	07a1                	addi	a5,a5,8
 112:	ff479ce3          	bne	a5,s4,10a <main+0x10a>
        char *temp = (char*)malloc(512);
 116:	20000513          	li	a0,512
 11a:	00000097          	auipc	ra,0x0
 11e:	6dc080e7          	jalr	1756(ra) # 7f6 <malloc>
 122:	892a                	mv	s2,a0
        int argc_c = argc - 1;
 124:	84ea                	mv	s1,s10
        if(read(0, &arc, 1) <= 0){   //ctrl+D退出
 126:	4605                	li	a2,1
 128:	e8f40593          	addi	a1,s0,-369
 12c:	4501                	li	a0,0
 12e:	00000097          	auipc	ra,0x0
 132:	2aa080e7          	jalr	682(ra) # 3d8 <read>
 136:	f2a05de3          	blez	a0,70 <main+0x70>
        while(arc != '\n'){
 13a:	e8f44583          	lbu	a1,-369(s0)
        int tempc = 0;  //tempc记录temp的尾字符
 13e:	4981                	li	s3,0
        while(arc != '\n'){
 140:	f78595e3          	bne	a1,s8,aa <main+0xaa>
 144:	b771                	j	d0 <main+0xd0>
        }else{
            wait(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	280080e7          	jalr	640(ra) # 3c8 <wait>
 150:	bf4d                	j	102 <main+0x102>

0000000000000152 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 152:	1141                	addi	sp,sp,-16
 154:	e422                	sd	s0,8(sp)
 156:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 158:	87aa                	mv	a5,a0
 15a:	0585                	addi	a1,a1,1
 15c:	0785                	addi	a5,a5,1
 15e:	fff5c703          	lbu	a4,-1(a1)
 162:	fee78fa3          	sb	a4,-1(a5)
 166:	fb75                	bnez	a4,15a <strcpy+0x8>
    ;
  return os;
}
 168:	6422                	ld	s0,8(sp)
 16a:	0141                	addi	sp,sp,16
 16c:	8082                	ret

000000000000016e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 174:	00054783          	lbu	a5,0(a0)
 178:	cb91                	beqz	a5,18c <strcmp+0x1e>
 17a:	0005c703          	lbu	a4,0(a1)
 17e:	00f71763          	bne	a4,a5,18c <strcmp+0x1e>
    p++, q++;
 182:	0505                	addi	a0,a0,1
 184:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 186:	00054783          	lbu	a5,0(a0)
 18a:	fbe5                	bnez	a5,17a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 18c:	0005c503          	lbu	a0,0(a1)
}
 190:	40a7853b          	subw	a0,a5,a0
 194:	6422                	ld	s0,8(sp)
 196:	0141                	addi	sp,sp,16
 198:	8082                	ret

000000000000019a <strlen>:

uint
strlen(const char *s)
{
 19a:	1141                	addi	sp,sp,-16
 19c:	e422                	sd	s0,8(sp)
 19e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1a0:	00054783          	lbu	a5,0(a0)
 1a4:	cf91                	beqz	a5,1c0 <strlen+0x26>
 1a6:	0505                	addi	a0,a0,1
 1a8:	87aa                	mv	a5,a0
 1aa:	4685                	li	a3,1
 1ac:	9e89                	subw	a3,a3,a0
 1ae:	00f6853b          	addw	a0,a3,a5
 1b2:	0785                	addi	a5,a5,1
 1b4:	fff7c703          	lbu	a4,-1(a5)
 1b8:	fb7d                	bnez	a4,1ae <strlen+0x14>
    ;
  return n;
}
 1ba:	6422                	ld	s0,8(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret
  for(n = 0; s[n]; n++)
 1c0:	4501                	li	a0,0
 1c2:	bfe5                	j	1ba <strlen+0x20>

00000000000001c4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c4:	1141                	addi	sp,sp,-16
 1c6:	e422                	sd	s0,8(sp)
 1c8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1ca:	ca19                	beqz	a2,1e0 <memset+0x1c>
 1cc:	87aa                	mv	a5,a0
 1ce:	1602                	slli	a2,a2,0x20
 1d0:	9201                	srli	a2,a2,0x20
 1d2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1d6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1da:	0785                	addi	a5,a5,1
 1dc:	fee79de3          	bne	a5,a4,1d6 <memset+0x12>
  }
  return dst;
}
 1e0:	6422                	ld	s0,8(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret

00000000000001e6 <strchr>:

char*
strchr(const char *s, char c)
{
 1e6:	1141                	addi	sp,sp,-16
 1e8:	e422                	sd	s0,8(sp)
 1ea:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ec:	00054783          	lbu	a5,0(a0)
 1f0:	cb99                	beqz	a5,206 <strchr+0x20>
    if(*s == c)
 1f2:	00f58763          	beq	a1,a5,200 <strchr+0x1a>
  for(; *s; s++)
 1f6:	0505                	addi	a0,a0,1
 1f8:	00054783          	lbu	a5,0(a0)
 1fc:	fbfd                	bnez	a5,1f2 <strchr+0xc>
      return (char*)s;
  return 0;
 1fe:	4501                	li	a0,0
}
 200:	6422                	ld	s0,8(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret
  return 0;
 206:	4501                	li	a0,0
 208:	bfe5                	j	200 <strchr+0x1a>

000000000000020a <gets>:

char*
gets(char *buf, int max)
{
 20a:	711d                	addi	sp,sp,-96
 20c:	ec86                	sd	ra,88(sp)
 20e:	e8a2                	sd	s0,80(sp)
 210:	e4a6                	sd	s1,72(sp)
 212:	e0ca                	sd	s2,64(sp)
 214:	fc4e                	sd	s3,56(sp)
 216:	f852                	sd	s4,48(sp)
 218:	f456                	sd	s5,40(sp)
 21a:	f05a                	sd	s6,32(sp)
 21c:	ec5e                	sd	s7,24(sp)
 21e:	1080                	addi	s0,sp,96
 220:	8baa                	mv	s7,a0
 222:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 224:	892a                	mv	s2,a0
 226:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 228:	4aa9                	li	s5,10
 22a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 22c:	89a6                	mv	s3,s1
 22e:	2485                	addiw	s1,s1,1
 230:	0344d863          	bge	s1,s4,260 <gets+0x56>
    cc = read(0, &c, 1);
 234:	4605                	li	a2,1
 236:	faf40593          	addi	a1,s0,-81
 23a:	4501                	li	a0,0
 23c:	00000097          	auipc	ra,0x0
 240:	19c080e7          	jalr	412(ra) # 3d8 <read>
    if(cc < 1)
 244:	00a05e63          	blez	a0,260 <gets+0x56>
    buf[i++] = c;
 248:	faf44783          	lbu	a5,-81(s0)
 24c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 250:	01578763          	beq	a5,s5,25e <gets+0x54>
 254:	0905                	addi	s2,s2,1
 256:	fd679be3          	bne	a5,s6,22c <gets+0x22>
  for(i=0; i+1 < max; ){
 25a:	89a6                	mv	s3,s1
 25c:	a011                	j	260 <gets+0x56>
 25e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 260:	99de                	add	s3,s3,s7
 262:	00098023          	sb	zero,0(s3)
  return buf;
}
 266:	855e                	mv	a0,s7
 268:	60e6                	ld	ra,88(sp)
 26a:	6446                	ld	s0,80(sp)
 26c:	64a6                	ld	s1,72(sp)
 26e:	6906                	ld	s2,64(sp)
 270:	79e2                	ld	s3,56(sp)
 272:	7a42                	ld	s4,48(sp)
 274:	7aa2                	ld	s5,40(sp)
 276:	7b02                	ld	s6,32(sp)
 278:	6be2                	ld	s7,24(sp)
 27a:	6125                	addi	sp,sp,96
 27c:	8082                	ret

000000000000027e <stat>:

int
stat(const char *n, struct stat *st)
{
 27e:	1101                	addi	sp,sp,-32
 280:	ec06                	sd	ra,24(sp)
 282:	e822                	sd	s0,16(sp)
 284:	e426                	sd	s1,8(sp)
 286:	e04a                	sd	s2,0(sp)
 288:	1000                	addi	s0,sp,32
 28a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28c:	4581                	li	a1,0
 28e:	00000097          	auipc	ra,0x0
 292:	172080e7          	jalr	370(ra) # 400 <open>
  if(fd < 0)
 296:	02054563          	bltz	a0,2c0 <stat+0x42>
 29a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 29c:	85ca                	mv	a1,s2
 29e:	00000097          	auipc	ra,0x0
 2a2:	17a080e7          	jalr	378(ra) # 418 <fstat>
 2a6:	892a                	mv	s2,a0
  close(fd);
 2a8:	8526                	mv	a0,s1
 2aa:	00000097          	auipc	ra,0x0
 2ae:	13e080e7          	jalr	318(ra) # 3e8 <close>
  return r;
}
 2b2:	854a                	mv	a0,s2
 2b4:	60e2                	ld	ra,24(sp)
 2b6:	6442                	ld	s0,16(sp)
 2b8:	64a2                	ld	s1,8(sp)
 2ba:	6902                	ld	s2,0(sp)
 2bc:	6105                	addi	sp,sp,32
 2be:	8082                	ret
    return -1;
 2c0:	597d                	li	s2,-1
 2c2:	bfc5                	j	2b2 <stat+0x34>

00000000000002c4 <atoi>:

int
atoi(const char *s)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e422                	sd	s0,8(sp)
 2c8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ca:	00054603          	lbu	a2,0(a0)
 2ce:	fd06079b          	addiw	a5,a2,-48
 2d2:	0ff7f793          	zext.b	a5,a5
 2d6:	4725                	li	a4,9
 2d8:	02f76963          	bltu	a4,a5,30a <atoi+0x46>
 2dc:	86aa                	mv	a3,a0
  n = 0;
 2de:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2e0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2e2:	0685                	addi	a3,a3,1
 2e4:	0025179b          	slliw	a5,a0,0x2
 2e8:	9fa9                	addw	a5,a5,a0
 2ea:	0017979b          	slliw	a5,a5,0x1
 2ee:	9fb1                	addw	a5,a5,a2
 2f0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2f4:	0006c603          	lbu	a2,0(a3)
 2f8:	fd06071b          	addiw	a4,a2,-48
 2fc:	0ff77713          	zext.b	a4,a4
 300:	fee5f1e3          	bgeu	a1,a4,2e2 <atoi+0x1e>
  return n;
}
 304:	6422                	ld	s0,8(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret
  n = 0;
 30a:	4501                	li	a0,0
 30c:	bfe5                	j	304 <atoi+0x40>

000000000000030e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 30e:	1141                	addi	sp,sp,-16
 310:	e422                	sd	s0,8(sp)
 312:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 314:	02b57463          	bgeu	a0,a1,33c <memmove+0x2e>
    while(n-- > 0)
 318:	00c05f63          	blez	a2,336 <memmove+0x28>
 31c:	1602                	slli	a2,a2,0x20
 31e:	9201                	srli	a2,a2,0x20
 320:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 324:	872a                	mv	a4,a0
      *dst++ = *src++;
 326:	0585                	addi	a1,a1,1
 328:	0705                	addi	a4,a4,1
 32a:	fff5c683          	lbu	a3,-1(a1)
 32e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 332:	fee79ae3          	bne	a5,a4,326 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 336:	6422                	ld	s0,8(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret
    dst += n;
 33c:	00c50733          	add	a4,a0,a2
    src += n;
 340:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 342:	fec05ae3          	blez	a2,336 <memmove+0x28>
 346:	fff6079b          	addiw	a5,a2,-1
 34a:	1782                	slli	a5,a5,0x20
 34c:	9381                	srli	a5,a5,0x20
 34e:	fff7c793          	not	a5,a5
 352:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 354:	15fd                	addi	a1,a1,-1
 356:	177d                	addi	a4,a4,-1
 358:	0005c683          	lbu	a3,0(a1)
 35c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 360:	fee79ae3          	bne	a5,a4,354 <memmove+0x46>
 364:	bfc9                	j	336 <memmove+0x28>

0000000000000366 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 366:	1141                	addi	sp,sp,-16
 368:	e422                	sd	s0,8(sp)
 36a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 36c:	ca05                	beqz	a2,39c <memcmp+0x36>
 36e:	fff6069b          	addiw	a3,a2,-1
 372:	1682                	slli	a3,a3,0x20
 374:	9281                	srli	a3,a3,0x20
 376:	0685                	addi	a3,a3,1
 378:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 37a:	00054783          	lbu	a5,0(a0)
 37e:	0005c703          	lbu	a4,0(a1)
 382:	00e79863          	bne	a5,a4,392 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 386:	0505                	addi	a0,a0,1
    p2++;
 388:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 38a:	fed518e3          	bne	a0,a3,37a <memcmp+0x14>
  }
  return 0;
 38e:	4501                	li	a0,0
 390:	a019                	j	396 <memcmp+0x30>
      return *p1 - *p2;
 392:	40e7853b          	subw	a0,a5,a4
}
 396:	6422                	ld	s0,8(sp)
 398:	0141                	addi	sp,sp,16
 39a:	8082                	ret
  return 0;
 39c:	4501                	li	a0,0
 39e:	bfe5                	j	396 <memcmp+0x30>

00000000000003a0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3a0:	1141                	addi	sp,sp,-16
 3a2:	e406                	sd	ra,8(sp)
 3a4:	e022                	sd	s0,0(sp)
 3a6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3a8:	00000097          	auipc	ra,0x0
 3ac:	f66080e7          	jalr	-154(ra) # 30e <memmove>
}
 3b0:	60a2                	ld	ra,8(sp)
 3b2:	6402                	ld	s0,0(sp)
 3b4:	0141                	addi	sp,sp,16
 3b6:	8082                	ret

00000000000003b8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b8:	4885                	li	a7,1
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3c0:	4889                	li	a7,2
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c8:	488d                	li	a7,3
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3d0:	4891                	li	a7,4
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <read>:
.global read
read:
 li a7, SYS_read
 3d8:	4895                	li	a7,5
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <write>:
.global write
write:
 li a7, SYS_write
 3e0:	48c1                	li	a7,16
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <close>:
.global close
close:
 li a7, SYS_close
 3e8:	48d5                	li	a7,21
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3f0:	4899                	li	a7,6
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f8:	489d                	li	a7,7
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <open>:
.global open
open:
 li a7, SYS_open
 400:	48bd                	li	a7,15
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 408:	48c5                	li	a7,17
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 410:	48c9                	li	a7,18
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 418:	48a1                	li	a7,8
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <link>:
.global link
link:
 li a7, SYS_link
 420:	48cd                	li	a7,19
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 428:	48d1                	li	a7,20
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 430:	48a5                	li	a7,9
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <dup>:
.global dup
dup:
 li a7, SYS_dup
 438:	48a9                	li	a7,10
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 440:	48ad                	li	a7,11
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 448:	48b1                	li	a7,12
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 450:	48b5                	li	a7,13
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 458:	48b9                	li	a7,14
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 460:	1101                	addi	sp,sp,-32
 462:	ec06                	sd	ra,24(sp)
 464:	e822                	sd	s0,16(sp)
 466:	1000                	addi	s0,sp,32
 468:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 46c:	4605                	li	a2,1
 46e:	fef40593          	addi	a1,s0,-17
 472:	00000097          	auipc	ra,0x0
 476:	f6e080e7          	jalr	-146(ra) # 3e0 <write>
}
 47a:	60e2                	ld	ra,24(sp)
 47c:	6442                	ld	s0,16(sp)
 47e:	6105                	addi	sp,sp,32
 480:	8082                	ret

0000000000000482 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 482:	7139                	addi	sp,sp,-64
 484:	fc06                	sd	ra,56(sp)
 486:	f822                	sd	s0,48(sp)
 488:	f426                	sd	s1,40(sp)
 48a:	f04a                	sd	s2,32(sp)
 48c:	ec4e                	sd	s3,24(sp)
 48e:	0080                	addi	s0,sp,64
 490:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 492:	c299                	beqz	a3,498 <printint+0x16>
 494:	0805c863          	bltz	a1,524 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 498:	2581                	sext.w	a1,a1
  neg = 0;
 49a:	4881                	li	a7,0
 49c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4a0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4a2:	2601                	sext.w	a2,a2
 4a4:	00000517          	auipc	a0,0x0
 4a8:	46c50513          	addi	a0,a0,1132 # 910 <digits>
 4ac:	883a                	mv	a6,a4
 4ae:	2705                	addiw	a4,a4,1
 4b0:	02c5f7bb          	remuw	a5,a1,a2
 4b4:	1782                	slli	a5,a5,0x20
 4b6:	9381                	srli	a5,a5,0x20
 4b8:	97aa                	add	a5,a5,a0
 4ba:	0007c783          	lbu	a5,0(a5)
 4be:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4c2:	0005879b          	sext.w	a5,a1
 4c6:	02c5d5bb          	divuw	a1,a1,a2
 4ca:	0685                	addi	a3,a3,1
 4cc:	fec7f0e3          	bgeu	a5,a2,4ac <printint+0x2a>
  if(neg)
 4d0:	00088b63          	beqz	a7,4e6 <printint+0x64>
    buf[i++] = '-';
 4d4:	fd040793          	addi	a5,s0,-48
 4d8:	973e                	add	a4,a4,a5
 4da:	02d00793          	li	a5,45
 4de:	fef70823          	sb	a5,-16(a4)
 4e2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4e6:	02e05863          	blez	a4,516 <printint+0x94>
 4ea:	fc040793          	addi	a5,s0,-64
 4ee:	00e78933          	add	s2,a5,a4
 4f2:	fff78993          	addi	s3,a5,-1
 4f6:	99ba                	add	s3,s3,a4
 4f8:	377d                	addiw	a4,a4,-1
 4fa:	1702                	slli	a4,a4,0x20
 4fc:	9301                	srli	a4,a4,0x20
 4fe:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 502:	fff94583          	lbu	a1,-1(s2)
 506:	8526                	mv	a0,s1
 508:	00000097          	auipc	ra,0x0
 50c:	f58080e7          	jalr	-168(ra) # 460 <putc>
  while(--i >= 0)
 510:	197d                	addi	s2,s2,-1
 512:	ff3918e3          	bne	s2,s3,502 <printint+0x80>
}
 516:	70e2                	ld	ra,56(sp)
 518:	7442                	ld	s0,48(sp)
 51a:	74a2                	ld	s1,40(sp)
 51c:	7902                	ld	s2,32(sp)
 51e:	69e2                	ld	s3,24(sp)
 520:	6121                	addi	sp,sp,64
 522:	8082                	ret
    x = -xx;
 524:	40b005bb          	negw	a1,a1
    neg = 1;
 528:	4885                	li	a7,1
    x = -xx;
 52a:	bf8d                	j	49c <printint+0x1a>

000000000000052c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 52c:	7119                	addi	sp,sp,-128
 52e:	fc86                	sd	ra,120(sp)
 530:	f8a2                	sd	s0,112(sp)
 532:	f4a6                	sd	s1,104(sp)
 534:	f0ca                	sd	s2,96(sp)
 536:	ecce                	sd	s3,88(sp)
 538:	e8d2                	sd	s4,80(sp)
 53a:	e4d6                	sd	s5,72(sp)
 53c:	e0da                	sd	s6,64(sp)
 53e:	fc5e                	sd	s7,56(sp)
 540:	f862                	sd	s8,48(sp)
 542:	f466                	sd	s9,40(sp)
 544:	f06a                	sd	s10,32(sp)
 546:	ec6e                	sd	s11,24(sp)
 548:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 54a:	0005c903          	lbu	s2,0(a1)
 54e:	18090f63          	beqz	s2,6ec <vprintf+0x1c0>
 552:	8aaa                	mv	s5,a0
 554:	8b32                	mv	s6,a2
 556:	00158493          	addi	s1,a1,1
  state = 0;
 55a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 55c:	02500a13          	li	s4,37
      if(c == 'd'){
 560:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 564:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 568:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 56c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 570:	00000b97          	auipc	s7,0x0
 574:	3a0b8b93          	addi	s7,s7,928 # 910 <digits>
 578:	a839                	j	596 <vprintf+0x6a>
        putc(fd, c);
 57a:	85ca                	mv	a1,s2
 57c:	8556                	mv	a0,s5
 57e:	00000097          	auipc	ra,0x0
 582:	ee2080e7          	jalr	-286(ra) # 460 <putc>
 586:	a019                	j	58c <vprintf+0x60>
    } else if(state == '%'){
 588:	01498f63          	beq	s3,s4,5a6 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 58c:	0485                	addi	s1,s1,1
 58e:	fff4c903          	lbu	s2,-1(s1)
 592:	14090d63          	beqz	s2,6ec <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 596:	0009079b          	sext.w	a5,s2
    if(state == 0){
 59a:	fe0997e3          	bnez	s3,588 <vprintf+0x5c>
      if(c == '%'){
 59e:	fd479ee3          	bne	a5,s4,57a <vprintf+0x4e>
        state = '%';
 5a2:	89be                	mv	s3,a5
 5a4:	b7e5                	j	58c <vprintf+0x60>
      if(c == 'd'){
 5a6:	05878063          	beq	a5,s8,5e6 <vprintf+0xba>
      } else if(c == 'l') {
 5aa:	05978c63          	beq	a5,s9,602 <vprintf+0xd6>
      } else if(c == 'x') {
 5ae:	07a78863          	beq	a5,s10,61e <vprintf+0xf2>
      } else if(c == 'p') {
 5b2:	09b78463          	beq	a5,s11,63a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5b6:	07300713          	li	a4,115
 5ba:	0ce78663          	beq	a5,a4,686 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5be:	06300713          	li	a4,99
 5c2:	0ee78e63          	beq	a5,a4,6be <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5c6:	11478863          	beq	a5,s4,6d6 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5ca:	85d2                	mv	a1,s4
 5cc:	8556                	mv	a0,s5
 5ce:	00000097          	auipc	ra,0x0
 5d2:	e92080e7          	jalr	-366(ra) # 460 <putc>
        putc(fd, c);
 5d6:	85ca                	mv	a1,s2
 5d8:	8556                	mv	a0,s5
 5da:	00000097          	auipc	ra,0x0
 5de:	e86080e7          	jalr	-378(ra) # 460 <putc>
      }
      state = 0;
 5e2:	4981                	li	s3,0
 5e4:	b765                	j	58c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5e6:	008b0913          	addi	s2,s6,8
 5ea:	4685                	li	a3,1
 5ec:	4629                	li	a2,10
 5ee:	000b2583          	lw	a1,0(s6)
 5f2:	8556                	mv	a0,s5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	e8e080e7          	jalr	-370(ra) # 482 <printint>
 5fc:	8b4a                	mv	s6,s2
      state = 0;
 5fe:	4981                	li	s3,0
 600:	b771                	j	58c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 602:	008b0913          	addi	s2,s6,8
 606:	4681                	li	a3,0
 608:	4629                	li	a2,10
 60a:	000b2583          	lw	a1,0(s6)
 60e:	8556                	mv	a0,s5
 610:	00000097          	auipc	ra,0x0
 614:	e72080e7          	jalr	-398(ra) # 482 <printint>
 618:	8b4a                	mv	s6,s2
      state = 0;
 61a:	4981                	li	s3,0
 61c:	bf85                	j	58c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 61e:	008b0913          	addi	s2,s6,8
 622:	4681                	li	a3,0
 624:	4641                	li	a2,16
 626:	000b2583          	lw	a1,0(s6)
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e56080e7          	jalr	-426(ra) # 482 <printint>
 634:	8b4a                	mv	s6,s2
      state = 0;
 636:	4981                	li	s3,0
 638:	bf91                	j	58c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 63a:	008b0793          	addi	a5,s6,8
 63e:	f8f43423          	sd	a5,-120(s0)
 642:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 646:	03000593          	li	a1,48
 64a:	8556                	mv	a0,s5
 64c:	00000097          	auipc	ra,0x0
 650:	e14080e7          	jalr	-492(ra) # 460 <putc>
  putc(fd, 'x');
 654:	85ea                	mv	a1,s10
 656:	8556                	mv	a0,s5
 658:	00000097          	auipc	ra,0x0
 65c:	e08080e7          	jalr	-504(ra) # 460 <putc>
 660:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 662:	03c9d793          	srli	a5,s3,0x3c
 666:	97de                	add	a5,a5,s7
 668:	0007c583          	lbu	a1,0(a5)
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	df2080e7          	jalr	-526(ra) # 460 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 676:	0992                	slli	s3,s3,0x4
 678:	397d                	addiw	s2,s2,-1
 67a:	fe0914e3          	bnez	s2,662 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 67e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 682:	4981                	li	s3,0
 684:	b721                	j	58c <vprintf+0x60>
        s = va_arg(ap, char*);
 686:	008b0993          	addi	s3,s6,8
 68a:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 68e:	02090163          	beqz	s2,6b0 <vprintf+0x184>
        while(*s != 0){
 692:	00094583          	lbu	a1,0(s2)
 696:	c9a1                	beqz	a1,6e6 <vprintf+0x1ba>
          putc(fd, *s);
 698:	8556                	mv	a0,s5
 69a:	00000097          	auipc	ra,0x0
 69e:	dc6080e7          	jalr	-570(ra) # 460 <putc>
          s++;
 6a2:	0905                	addi	s2,s2,1
        while(*s != 0){
 6a4:	00094583          	lbu	a1,0(s2)
 6a8:	f9e5                	bnez	a1,698 <vprintf+0x16c>
        s = va_arg(ap, char*);
 6aa:	8b4e                	mv	s6,s3
      state = 0;
 6ac:	4981                	li	s3,0
 6ae:	bdf9                	j	58c <vprintf+0x60>
          s = "(null)";
 6b0:	00000917          	auipc	s2,0x0
 6b4:	25890913          	addi	s2,s2,600 # 908 <malloc+0x112>
        while(*s != 0){
 6b8:	02800593          	li	a1,40
 6bc:	bff1                	j	698 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 6be:	008b0913          	addi	s2,s6,8
 6c2:	000b4583          	lbu	a1,0(s6)
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	d98080e7          	jalr	-616(ra) # 460 <putc>
 6d0:	8b4a                	mv	s6,s2
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	bd65                	j	58c <vprintf+0x60>
        putc(fd, c);
 6d6:	85d2                	mv	a1,s4
 6d8:	8556                	mv	a0,s5
 6da:	00000097          	auipc	ra,0x0
 6de:	d86080e7          	jalr	-634(ra) # 460 <putc>
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	b565                	j	58c <vprintf+0x60>
        s = va_arg(ap, char*);
 6e6:	8b4e                	mv	s6,s3
      state = 0;
 6e8:	4981                	li	s3,0
 6ea:	b54d                	j	58c <vprintf+0x60>
    }
  }
}
 6ec:	70e6                	ld	ra,120(sp)
 6ee:	7446                	ld	s0,112(sp)
 6f0:	74a6                	ld	s1,104(sp)
 6f2:	7906                	ld	s2,96(sp)
 6f4:	69e6                	ld	s3,88(sp)
 6f6:	6a46                	ld	s4,80(sp)
 6f8:	6aa6                	ld	s5,72(sp)
 6fa:	6b06                	ld	s6,64(sp)
 6fc:	7be2                	ld	s7,56(sp)
 6fe:	7c42                	ld	s8,48(sp)
 700:	7ca2                	ld	s9,40(sp)
 702:	7d02                	ld	s10,32(sp)
 704:	6de2                	ld	s11,24(sp)
 706:	6109                	addi	sp,sp,128
 708:	8082                	ret

000000000000070a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 70a:	715d                	addi	sp,sp,-80
 70c:	ec06                	sd	ra,24(sp)
 70e:	e822                	sd	s0,16(sp)
 710:	1000                	addi	s0,sp,32
 712:	e010                	sd	a2,0(s0)
 714:	e414                	sd	a3,8(s0)
 716:	e818                	sd	a4,16(s0)
 718:	ec1c                	sd	a5,24(s0)
 71a:	03043023          	sd	a6,32(s0)
 71e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 722:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 726:	8622                	mv	a2,s0
 728:	00000097          	auipc	ra,0x0
 72c:	e04080e7          	jalr	-508(ra) # 52c <vprintf>
}
 730:	60e2                	ld	ra,24(sp)
 732:	6442                	ld	s0,16(sp)
 734:	6161                	addi	sp,sp,80
 736:	8082                	ret

0000000000000738 <printf>:

void
printf(const char *fmt, ...)
{
 738:	711d                	addi	sp,sp,-96
 73a:	ec06                	sd	ra,24(sp)
 73c:	e822                	sd	s0,16(sp)
 73e:	1000                	addi	s0,sp,32
 740:	e40c                	sd	a1,8(s0)
 742:	e810                	sd	a2,16(s0)
 744:	ec14                	sd	a3,24(s0)
 746:	f018                	sd	a4,32(s0)
 748:	f41c                	sd	a5,40(s0)
 74a:	03043823          	sd	a6,48(s0)
 74e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 752:	00840613          	addi	a2,s0,8
 756:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 75a:	85aa                	mv	a1,a0
 75c:	4505                	li	a0,1
 75e:	00000097          	auipc	ra,0x0
 762:	dce080e7          	jalr	-562(ra) # 52c <vprintf>
}
 766:	60e2                	ld	ra,24(sp)
 768:	6442                	ld	s0,16(sp)
 76a:	6125                	addi	sp,sp,96
 76c:	8082                	ret

000000000000076e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 76e:	1141                	addi	sp,sp,-16
 770:	e422                	sd	s0,8(sp)
 772:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 774:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 778:	00000797          	auipc	a5,0x0
 77c:	1b07b783          	ld	a5,432(a5) # 928 <freep>
 780:	a805                	j	7b0 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 782:	4618                	lw	a4,8(a2)
 784:	9db9                	addw	a1,a1,a4
 786:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 78a:	6398                	ld	a4,0(a5)
 78c:	6318                	ld	a4,0(a4)
 78e:	fee53823          	sd	a4,-16(a0)
 792:	a091                	j	7d6 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 794:	ff852703          	lw	a4,-8(a0)
 798:	9e39                	addw	a2,a2,a4
 79a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 79c:	ff053703          	ld	a4,-16(a0)
 7a0:	e398                	sd	a4,0(a5)
 7a2:	a099                	j	7e8 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a4:	6398                	ld	a4,0(a5)
 7a6:	00e7e463          	bltu	a5,a4,7ae <free+0x40>
 7aa:	00e6ea63          	bltu	a3,a4,7be <free+0x50>
{
 7ae:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b0:	fed7fae3          	bgeu	a5,a3,7a4 <free+0x36>
 7b4:	6398                	ld	a4,0(a5)
 7b6:	00e6e463          	bltu	a3,a4,7be <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ba:	fee7eae3          	bltu	a5,a4,7ae <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 7be:	ff852583          	lw	a1,-8(a0)
 7c2:	6390                	ld	a2,0(a5)
 7c4:	02059813          	slli	a6,a1,0x20
 7c8:	01c85713          	srli	a4,a6,0x1c
 7cc:	9736                	add	a4,a4,a3
 7ce:	fae60ae3          	beq	a2,a4,782 <free+0x14>
    bp->s.ptr = p->s.ptr;
 7d2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7d6:	4790                	lw	a2,8(a5)
 7d8:	02061593          	slli	a1,a2,0x20
 7dc:	01c5d713          	srli	a4,a1,0x1c
 7e0:	973e                	add	a4,a4,a5
 7e2:	fae689e3          	beq	a3,a4,794 <free+0x26>
  } else
    p->s.ptr = bp;
 7e6:	e394                	sd	a3,0(a5)
  freep = p;
 7e8:	00000717          	auipc	a4,0x0
 7ec:	14f73023          	sd	a5,320(a4) # 928 <freep>
}
 7f0:	6422                	ld	s0,8(sp)
 7f2:	0141                	addi	sp,sp,16
 7f4:	8082                	ret

00000000000007f6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f6:	7139                	addi	sp,sp,-64
 7f8:	fc06                	sd	ra,56(sp)
 7fa:	f822                	sd	s0,48(sp)
 7fc:	f426                	sd	s1,40(sp)
 7fe:	f04a                	sd	s2,32(sp)
 800:	ec4e                	sd	s3,24(sp)
 802:	e852                	sd	s4,16(sp)
 804:	e456                	sd	s5,8(sp)
 806:	e05a                	sd	s6,0(sp)
 808:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 80a:	02051493          	slli	s1,a0,0x20
 80e:	9081                	srli	s1,s1,0x20
 810:	04bd                	addi	s1,s1,15
 812:	8091                	srli	s1,s1,0x4
 814:	0014899b          	addiw	s3,s1,1
 818:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 81a:	00000517          	auipc	a0,0x0
 81e:	10e53503          	ld	a0,270(a0) # 928 <freep>
 822:	c515                	beqz	a0,84e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 824:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 826:	4798                	lw	a4,8(a5)
 828:	02977f63          	bgeu	a4,s1,866 <malloc+0x70>
 82c:	8a4e                	mv	s4,s3
 82e:	0009871b          	sext.w	a4,s3
 832:	6685                	lui	a3,0x1
 834:	00d77363          	bgeu	a4,a3,83a <malloc+0x44>
 838:	6a05                	lui	s4,0x1
 83a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 83e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 842:	00000917          	auipc	s2,0x0
 846:	0e690913          	addi	s2,s2,230 # 928 <freep>
  if(p == (char*)-1)
 84a:	5afd                	li	s5,-1
 84c:	a895                	j	8c0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 84e:	00000797          	auipc	a5,0x0
 852:	0e278793          	addi	a5,a5,226 # 930 <base>
 856:	00000717          	auipc	a4,0x0
 85a:	0cf73923          	sd	a5,210(a4) # 928 <freep>
 85e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 860:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 864:	b7e1                	j	82c <malloc+0x36>
      if(p->s.size == nunits)
 866:	02e48c63          	beq	s1,a4,89e <malloc+0xa8>
        p->s.size -= nunits;
 86a:	4137073b          	subw	a4,a4,s3
 86e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 870:	02071693          	slli	a3,a4,0x20
 874:	01c6d713          	srli	a4,a3,0x1c
 878:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 87a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 87e:	00000717          	auipc	a4,0x0
 882:	0aa73523          	sd	a0,170(a4) # 928 <freep>
      return (void*)(p + 1);
 886:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 88a:	70e2                	ld	ra,56(sp)
 88c:	7442                	ld	s0,48(sp)
 88e:	74a2                	ld	s1,40(sp)
 890:	7902                	ld	s2,32(sp)
 892:	69e2                	ld	s3,24(sp)
 894:	6a42                	ld	s4,16(sp)
 896:	6aa2                	ld	s5,8(sp)
 898:	6b02                	ld	s6,0(sp)
 89a:	6121                	addi	sp,sp,64
 89c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 89e:	6398                	ld	a4,0(a5)
 8a0:	e118                	sd	a4,0(a0)
 8a2:	bff1                	j	87e <malloc+0x88>
  hp->s.size = nu;
 8a4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8a8:	0541                	addi	a0,a0,16
 8aa:	00000097          	auipc	ra,0x0
 8ae:	ec4080e7          	jalr	-316(ra) # 76e <free>
  return freep;
 8b2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8b6:	d971                	beqz	a0,88a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ba:	4798                	lw	a4,8(a5)
 8bc:	fa9775e3          	bgeu	a4,s1,866 <malloc+0x70>
    if(p == freep)
 8c0:	00093703          	ld	a4,0(s2)
 8c4:	853e                	mv	a0,a5
 8c6:	fef719e3          	bne	a4,a5,8b8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8ca:	8552                	mv	a0,s4
 8cc:	00000097          	auipc	ra,0x0
 8d0:	b7c080e7          	jalr	-1156(ra) # 448 <sbrk>
  if(p == (char*)-1)
 8d4:	fd5518e3          	bne	a0,s5,8a4 <malloc+0xae>
        return 0;
 8d8:	4501                	li	a0,0
 8da:	bf45                	j	88a <malloc+0x94>
