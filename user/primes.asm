
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find_primes>:
#include "kernel/types.h"
#include "user.h"

void find_primes(int p[]){      //埃拉托斯特尼筛法
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	84aa                	mv	s1,a0
    close(p[1]);
   c:	4148                	lw	a0,4(a0)
   e:	00000097          	auipc	ra,0x0
  12:	3d8080e7          	jalr	984(ra) # 3e6 <close>
    int prime;
    if(read(p[0], &prime, 4) > 0){
  16:	4611                	li	a2,4
  18:	fdc40593          	addi	a1,s0,-36
  1c:	4088                	lw	a0,0(s1)
  1e:	00000097          	auipc	ra,0x0
  22:	3b8080e7          	jalr	952(ra) # 3d6 <read>
  26:	02a04463          	bgtz	a0,4e <find_primes+0x4e>
        fprintf(1, "prime %d\n", prime);    //第一个必为质数
    }

    int p_c[2];
    pipe(p_c);
  2a:	fd040513          	addi	a0,s0,-48
  2e:	00000097          	auipc	ra,0x0
  32:	3a0080e7          	jalr	928(ra) # 3ce <pipe>
    if(fork() == 0){    //子管道筛选下一个质数
  36:	00000097          	auipc	ra,0x0
  3a:	380080e7          	jalr	896(ra) # 3b6 <fork>
  3e:	e505                	bnez	a0,66 <find_primes+0x66>
        find_primes(p_c);
  40:	fd040513          	addi	a0,s0,-48
  44:	00000097          	auipc	ra,0x0
  48:	fbc080e7          	jalr	-68(ra) # 0 <find_primes>
  4c:	a88d                	j	be <find_primes+0xbe>
        fprintf(1, "prime %d\n", prime);    //第一个必为质数
  4e:	fdc42603          	lw	a2,-36(s0)
  52:	00001597          	auipc	a1,0x1
  56:	88e58593          	addi	a1,a1,-1906 # 8e0 <malloc+0xec>
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	6ac080e7          	jalr	1708(ra) # 708 <fprintf>
  64:	b7d9                	j	2a <find_primes+0x2a>
    }else{              //筛选prime倍数以外的数
        int num;
        close(p_c[0]);
  66:	fd042503          	lw	a0,-48(s0)
  6a:	00000097          	auipc	ra,0x0
  6e:	37c080e7          	jalr	892(ra) # 3e6 <close>
        while(read(p[0], &num, 4) > 0){
  72:	4611                	li	a2,4
  74:	fcc40593          	addi	a1,s0,-52
  78:	4088                	lw	a0,0(s1)
  7a:	00000097          	auipc	ra,0x0
  7e:	35c080e7          	jalr	860(ra) # 3d6 <read>
  82:	02a05363          	blez	a0,a8 <find_primes+0xa8>
            if(num % prime != 0){
  86:	fcc42783          	lw	a5,-52(s0)
  8a:	fdc42703          	lw	a4,-36(s0)
  8e:	02e7e7bb          	remw	a5,a5,a4
  92:	d3e5                	beqz	a5,72 <find_primes+0x72>
                write(p_c[1], &num, 4);
  94:	4611                	li	a2,4
  96:	fcc40593          	addi	a1,s0,-52
  9a:	fd442503          	lw	a0,-44(s0)
  9e:	00000097          	auipc	ra,0x0
  a2:	340080e7          	jalr	832(ra) # 3de <write>
  a6:	b7f1                	j	72 <find_primes+0x72>
            }
        }
        close(p_c[1]);
  a8:	fd442503          	lw	a0,-44(s0)
  ac:	00000097          	auipc	ra,0x0
  b0:	33a080e7          	jalr	826(ra) # 3e6 <close>
        wait(0);
  b4:	4501                	li	a0,0
  b6:	00000097          	auipc	ra,0x0
  ba:	310080e7          	jalr	784(ra) # 3c6 <wait>
    }
}
  be:	70e2                	ld	ra,56(sp)
  c0:	7442                	ld	s0,48(sp)
  c2:	74a2                	ld	s1,40(sp)
  c4:	6121                	addi	sp,sp,64
  c6:	8082                	ret

00000000000000c8 <main>:

int main(){
  c8:	7179                	addi	sp,sp,-48
  ca:	f406                	sd	ra,40(sp)
  cc:	f022                	sd	s0,32(sp)
  ce:	ec26                	sd	s1,24(sp)
  d0:	1800                	addi	s0,sp,48
    int p[2];
    pipe(p);
  d2:	fd840513          	addi	a0,s0,-40
  d6:	00000097          	auipc	ra,0x0
  da:	2f8080e7          	jalr	760(ra) # 3ce <pipe>
    if(fork() == 0){    //子进程筛选质数
  de:	00000097          	auipc	ra,0x0
  e2:	2d8080e7          	jalr	728(ra) # 3b6 <fork>
  e6:	ed01                	bnez	a0,fe <main+0x36>
        find_primes(p);
  e8:	fd840513          	addi	a0,s0,-40
  ec:	00000097          	auipc	ra,0x0
  f0:	f14080e7          	jalr	-236(ra) # 0 <find_primes>
            write(p[1], &i , 4);
        }
        close(p[1]);
        wait(0);    //??
    }
    exit(0);
  f4:	4501                	li	a0,0
  f6:	00000097          	auipc	ra,0x0
  fa:	2c8080e7          	jalr	712(ra) # 3be <exit>
        close(p[0]);
  fe:	fd842503          	lw	a0,-40(s0)
 102:	00000097          	auipc	ra,0x0
 106:	2e4080e7          	jalr	740(ra) # 3e6 <close>
        for(int i = 2; i<=35;i++){
 10a:	4789                	li	a5,2
 10c:	fcf42a23          	sw	a5,-44(s0)
 110:	02300493          	li	s1,35
            write(p[1], &i , 4);
 114:	4611                	li	a2,4
 116:	fd440593          	addi	a1,s0,-44
 11a:	fdc42503          	lw	a0,-36(s0)
 11e:	00000097          	auipc	ra,0x0
 122:	2c0080e7          	jalr	704(ra) # 3de <write>
        for(int i = 2; i<=35;i++){
 126:	fd442783          	lw	a5,-44(s0)
 12a:	2785                	addiw	a5,a5,1
 12c:	0007871b          	sext.w	a4,a5
 130:	fcf42a23          	sw	a5,-44(s0)
 134:	fee4d0e3          	bge	s1,a4,114 <main+0x4c>
        close(p[1]);
 138:	fdc42503          	lw	a0,-36(s0)
 13c:	00000097          	auipc	ra,0x0
 140:	2aa080e7          	jalr	682(ra) # 3e6 <close>
        wait(0);    //??
 144:	4501                	li	a0,0
 146:	00000097          	auipc	ra,0x0
 14a:	280080e7          	jalr	640(ra) # 3c6 <wait>
 14e:	b75d                	j	f4 <main+0x2c>

0000000000000150 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 150:	1141                	addi	sp,sp,-16
 152:	e422                	sd	s0,8(sp)
 154:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 156:	87aa                	mv	a5,a0
 158:	0585                	addi	a1,a1,1
 15a:	0785                	addi	a5,a5,1
 15c:	fff5c703          	lbu	a4,-1(a1)
 160:	fee78fa3          	sb	a4,-1(a5)
 164:	fb75                	bnez	a4,158 <strcpy+0x8>
    ;
  return os;
}
 166:	6422                	ld	s0,8(sp)
 168:	0141                	addi	sp,sp,16
 16a:	8082                	ret

000000000000016c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 16c:	1141                	addi	sp,sp,-16
 16e:	e422                	sd	s0,8(sp)
 170:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 172:	00054783          	lbu	a5,0(a0)
 176:	cb91                	beqz	a5,18a <strcmp+0x1e>
 178:	0005c703          	lbu	a4,0(a1)
 17c:	00f71763          	bne	a4,a5,18a <strcmp+0x1e>
    p++, q++;
 180:	0505                	addi	a0,a0,1
 182:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 184:	00054783          	lbu	a5,0(a0)
 188:	fbe5                	bnez	a5,178 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 18a:	0005c503          	lbu	a0,0(a1)
}
 18e:	40a7853b          	subw	a0,a5,a0
 192:	6422                	ld	s0,8(sp)
 194:	0141                	addi	sp,sp,16
 196:	8082                	ret

0000000000000198 <strlen>:

uint
strlen(const char *s)
{
 198:	1141                	addi	sp,sp,-16
 19a:	e422                	sd	s0,8(sp)
 19c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 19e:	00054783          	lbu	a5,0(a0)
 1a2:	cf91                	beqz	a5,1be <strlen+0x26>
 1a4:	0505                	addi	a0,a0,1
 1a6:	87aa                	mv	a5,a0
 1a8:	4685                	li	a3,1
 1aa:	9e89                	subw	a3,a3,a0
 1ac:	00f6853b          	addw	a0,a3,a5
 1b0:	0785                	addi	a5,a5,1
 1b2:	fff7c703          	lbu	a4,-1(a5)
 1b6:	fb7d                	bnez	a4,1ac <strlen+0x14>
    ;
  return n;
}
 1b8:	6422                	ld	s0,8(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret
  for(n = 0; s[n]; n++)
 1be:	4501                	li	a0,0
 1c0:	bfe5                	j	1b8 <strlen+0x20>

00000000000001c2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c2:	1141                	addi	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1c8:	ca19                	beqz	a2,1de <memset+0x1c>
 1ca:	87aa                	mv	a5,a0
 1cc:	1602                	slli	a2,a2,0x20
 1ce:	9201                	srli	a2,a2,0x20
 1d0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1d4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1d8:	0785                	addi	a5,a5,1
 1da:	fee79de3          	bne	a5,a4,1d4 <memset+0x12>
  }
  return dst;
}
 1de:	6422                	ld	s0,8(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret

00000000000001e4 <strchr>:

char*
strchr(const char *s, char c)
{
 1e4:	1141                	addi	sp,sp,-16
 1e6:	e422                	sd	s0,8(sp)
 1e8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ea:	00054783          	lbu	a5,0(a0)
 1ee:	cb99                	beqz	a5,204 <strchr+0x20>
    if(*s == c)
 1f0:	00f58763          	beq	a1,a5,1fe <strchr+0x1a>
  for(; *s; s++)
 1f4:	0505                	addi	a0,a0,1
 1f6:	00054783          	lbu	a5,0(a0)
 1fa:	fbfd                	bnez	a5,1f0 <strchr+0xc>
      return (char*)s;
  return 0;
 1fc:	4501                	li	a0,0
}
 1fe:	6422                	ld	s0,8(sp)
 200:	0141                	addi	sp,sp,16
 202:	8082                	ret
  return 0;
 204:	4501                	li	a0,0
 206:	bfe5                	j	1fe <strchr+0x1a>

0000000000000208 <gets>:

char*
gets(char *buf, int max)
{
 208:	711d                	addi	sp,sp,-96
 20a:	ec86                	sd	ra,88(sp)
 20c:	e8a2                	sd	s0,80(sp)
 20e:	e4a6                	sd	s1,72(sp)
 210:	e0ca                	sd	s2,64(sp)
 212:	fc4e                	sd	s3,56(sp)
 214:	f852                	sd	s4,48(sp)
 216:	f456                	sd	s5,40(sp)
 218:	f05a                	sd	s6,32(sp)
 21a:	ec5e                	sd	s7,24(sp)
 21c:	1080                	addi	s0,sp,96
 21e:	8baa                	mv	s7,a0
 220:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 222:	892a                	mv	s2,a0
 224:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 226:	4aa9                	li	s5,10
 228:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 22a:	89a6                	mv	s3,s1
 22c:	2485                	addiw	s1,s1,1
 22e:	0344d863          	bge	s1,s4,25e <gets+0x56>
    cc = read(0, &c, 1);
 232:	4605                	li	a2,1
 234:	faf40593          	addi	a1,s0,-81
 238:	4501                	li	a0,0
 23a:	00000097          	auipc	ra,0x0
 23e:	19c080e7          	jalr	412(ra) # 3d6 <read>
    if(cc < 1)
 242:	00a05e63          	blez	a0,25e <gets+0x56>
    buf[i++] = c;
 246:	faf44783          	lbu	a5,-81(s0)
 24a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 24e:	01578763          	beq	a5,s5,25c <gets+0x54>
 252:	0905                	addi	s2,s2,1
 254:	fd679be3          	bne	a5,s6,22a <gets+0x22>
  for(i=0; i+1 < max; ){
 258:	89a6                	mv	s3,s1
 25a:	a011                	j	25e <gets+0x56>
 25c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 25e:	99de                	add	s3,s3,s7
 260:	00098023          	sb	zero,0(s3)
  return buf;
}
 264:	855e                	mv	a0,s7
 266:	60e6                	ld	ra,88(sp)
 268:	6446                	ld	s0,80(sp)
 26a:	64a6                	ld	s1,72(sp)
 26c:	6906                	ld	s2,64(sp)
 26e:	79e2                	ld	s3,56(sp)
 270:	7a42                	ld	s4,48(sp)
 272:	7aa2                	ld	s5,40(sp)
 274:	7b02                	ld	s6,32(sp)
 276:	6be2                	ld	s7,24(sp)
 278:	6125                	addi	sp,sp,96
 27a:	8082                	ret

000000000000027c <stat>:

int
stat(const char *n, struct stat *st)
{
 27c:	1101                	addi	sp,sp,-32
 27e:	ec06                	sd	ra,24(sp)
 280:	e822                	sd	s0,16(sp)
 282:	e426                	sd	s1,8(sp)
 284:	e04a                	sd	s2,0(sp)
 286:	1000                	addi	s0,sp,32
 288:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28a:	4581                	li	a1,0
 28c:	00000097          	auipc	ra,0x0
 290:	172080e7          	jalr	370(ra) # 3fe <open>
  if(fd < 0)
 294:	02054563          	bltz	a0,2be <stat+0x42>
 298:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 29a:	85ca                	mv	a1,s2
 29c:	00000097          	auipc	ra,0x0
 2a0:	17a080e7          	jalr	378(ra) # 416 <fstat>
 2a4:	892a                	mv	s2,a0
  close(fd);
 2a6:	8526                	mv	a0,s1
 2a8:	00000097          	auipc	ra,0x0
 2ac:	13e080e7          	jalr	318(ra) # 3e6 <close>
  return r;
}
 2b0:	854a                	mv	a0,s2
 2b2:	60e2                	ld	ra,24(sp)
 2b4:	6442                	ld	s0,16(sp)
 2b6:	64a2                	ld	s1,8(sp)
 2b8:	6902                	ld	s2,0(sp)
 2ba:	6105                	addi	sp,sp,32
 2bc:	8082                	ret
    return -1;
 2be:	597d                	li	s2,-1
 2c0:	bfc5                	j	2b0 <stat+0x34>

00000000000002c2 <atoi>:

int
atoi(const char *s)
{
 2c2:	1141                	addi	sp,sp,-16
 2c4:	e422                	sd	s0,8(sp)
 2c6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c8:	00054603          	lbu	a2,0(a0)
 2cc:	fd06079b          	addiw	a5,a2,-48
 2d0:	0ff7f793          	zext.b	a5,a5
 2d4:	4725                	li	a4,9
 2d6:	02f76963          	bltu	a4,a5,308 <atoi+0x46>
 2da:	86aa                	mv	a3,a0
  n = 0;
 2dc:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2de:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2e0:	0685                	addi	a3,a3,1
 2e2:	0025179b          	slliw	a5,a0,0x2
 2e6:	9fa9                	addw	a5,a5,a0
 2e8:	0017979b          	slliw	a5,a5,0x1
 2ec:	9fb1                	addw	a5,a5,a2
 2ee:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2f2:	0006c603          	lbu	a2,0(a3)
 2f6:	fd06071b          	addiw	a4,a2,-48
 2fa:	0ff77713          	zext.b	a4,a4
 2fe:	fee5f1e3          	bgeu	a1,a4,2e0 <atoi+0x1e>
  return n;
}
 302:	6422                	ld	s0,8(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret
  n = 0;
 308:	4501                	li	a0,0
 30a:	bfe5                	j	302 <atoi+0x40>

000000000000030c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 312:	02b57463          	bgeu	a0,a1,33a <memmove+0x2e>
    while(n-- > 0)
 316:	00c05f63          	blez	a2,334 <memmove+0x28>
 31a:	1602                	slli	a2,a2,0x20
 31c:	9201                	srli	a2,a2,0x20
 31e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 322:	872a                	mv	a4,a0
      *dst++ = *src++;
 324:	0585                	addi	a1,a1,1
 326:	0705                	addi	a4,a4,1
 328:	fff5c683          	lbu	a3,-1(a1)
 32c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 330:	fee79ae3          	bne	a5,a4,324 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 334:	6422                	ld	s0,8(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret
    dst += n;
 33a:	00c50733          	add	a4,a0,a2
    src += n;
 33e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 340:	fec05ae3          	blez	a2,334 <memmove+0x28>
 344:	fff6079b          	addiw	a5,a2,-1
 348:	1782                	slli	a5,a5,0x20
 34a:	9381                	srli	a5,a5,0x20
 34c:	fff7c793          	not	a5,a5
 350:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 352:	15fd                	addi	a1,a1,-1
 354:	177d                	addi	a4,a4,-1
 356:	0005c683          	lbu	a3,0(a1)
 35a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 35e:	fee79ae3          	bne	a5,a4,352 <memmove+0x46>
 362:	bfc9                	j	334 <memmove+0x28>

0000000000000364 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 364:	1141                	addi	sp,sp,-16
 366:	e422                	sd	s0,8(sp)
 368:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 36a:	ca05                	beqz	a2,39a <memcmp+0x36>
 36c:	fff6069b          	addiw	a3,a2,-1
 370:	1682                	slli	a3,a3,0x20
 372:	9281                	srli	a3,a3,0x20
 374:	0685                	addi	a3,a3,1
 376:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 378:	00054783          	lbu	a5,0(a0)
 37c:	0005c703          	lbu	a4,0(a1)
 380:	00e79863          	bne	a5,a4,390 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 384:	0505                	addi	a0,a0,1
    p2++;
 386:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 388:	fed518e3          	bne	a0,a3,378 <memcmp+0x14>
  }
  return 0;
 38c:	4501                	li	a0,0
 38e:	a019                	j	394 <memcmp+0x30>
      return *p1 - *p2;
 390:	40e7853b          	subw	a0,a5,a4
}
 394:	6422                	ld	s0,8(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret
  return 0;
 39a:	4501                	li	a0,0
 39c:	bfe5                	j	394 <memcmp+0x30>

000000000000039e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 39e:	1141                	addi	sp,sp,-16
 3a0:	e406                	sd	ra,8(sp)
 3a2:	e022                	sd	s0,0(sp)
 3a4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3a6:	00000097          	auipc	ra,0x0
 3aa:	f66080e7          	jalr	-154(ra) # 30c <memmove>
}
 3ae:	60a2                	ld	ra,8(sp)
 3b0:	6402                	ld	s0,0(sp)
 3b2:	0141                	addi	sp,sp,16
 3b4:	8082                	ret

00000000000003b6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b6:	4885                	li	a7,1
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <exit>:
.global exit
exit:
 li a7, SYS_exit
 3be:	4889                	li	a7,2
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c6:	488d                	li	a7,3
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ce:	4891                	li	a7,4
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <read>:
.global read
read:
 li a7, SYS_read
 3d6:	4895                	li	a7,5
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <write>:
.global write
write:
 li a7, SYS_write
 3de:	48c1                	li	a7,16
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <close>:
.global close
close:
 li a7, SYS_close
 3e6:	48d5                	li	a7,21
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ee:	4899                	li	a7,6
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f6:	489d                	li	a7,7
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <open>:
.global open
open:
 li a7, SYS_open
 3fe:	48bd                	li	a7,15
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 406:	48c5                	li	a7,17
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 40e:	48c9                	li	a7,18
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 416:	48a1                	li	a7,8
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <link>:
.global link
link:
 li a7, SYS_link
 41e:	48cd                	li	a7,19
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 426:	48d1                	li	a7,20
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 42e:	48a5                	li	a7,9
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <dup>:
.global dup
dup:
 li a7, SYS_dup
 436:	48a9                	li	a7,10
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 43e:	48ad                	li	a7,11
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 446:	48b1                	li	a7,12
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 44e:	48b5                	li	a7,13
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 456:	48b9                	li	a7,14
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 45e:	1101                	addi	sp,sp,-32
 460:	ec06                	sd	ra,24(sp)
 462:	e822                	sd	s0,16(sp)
 464:	1000                	addi	s0,sp,32
 466:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 46a:	4605                	li	a2,1
 46c:	fef40593          	addi	a1,s0,-17
 470:	00000097          	auipc	ra,0x0
 474:	f6e080e7          	jalr	-146(ra) # 3de <write>
}
 478:	60e2                	ld	ra,24(sp)
 47a:	6442                	ld	s0,16(sp)
 47c:	6105                	addi	sp,sp,32
 47e:	8082                	ret

0000000000000480 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	7139                	addi	sp,sp,-64
 482:	fc06                	sd	ra,56(sp)
 484:	f822                	sd	s0,48(sp)
 486:	f426                	sd	s1,40(sp)
 488:	f04a                	sd	s2,32(sp)
 48a:	ec4e                	sd	s3,24(sp)
 48c:	0080                	addi	s0,sp,64
 48e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 490:	c299                	beqz	a3,496 <printint+0x16>
 492:	0805c863          	bltz	a1,522 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 496:	2581                	sext.w	a1,a1
  neg = 0;
 498:	4881                	li	a7,0
 49a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 49e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4a0:	2601                	sext.w	a2,a2
 4a2:	00000517          	auipc	a0,0x0
 4a6:	45650513          	addi	a0,a0,1110 # 8f8 <digits>
 4aa:	883a                	mv	a6,a4
 4ac:	2705                	addiw	a4,a4,1
 4ae:	02c5f7bb          	remuw	a5,a1,a2
 4b2:	1782                	slli	a5,a5,0x20
 4b4:	9381                	srli	a5,a5,0x20
 4b6:	97aa                	add	a5,a5,a0
 4b8:	0007c783          	lbu	a5,0(a5)
 4bc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4c0:	0005879b          	sext.w	a5,a1
 4c4:	02c5d5bb          	divuw	a1,a1,a2
 4c8:	0685                	addi	a3,a3,1
 4ca:	fec7f0e3          	bgeu	a5,a2,4aa <printint+0x2a>
  if(neg)
 4ce:	00088b63          	beqz	a7,4e4 <printint+0x64>
    buf[i++] = '-';
 4d2:	fd040793          	addi	a5,s0,-48
 4d6:	973e                	add	a4,a4,a5
 4d8:	02d00793          	li	a5,45
 4dc:	fef70823          	sb	a5,-16(a4)
 4e0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4e4:	02e05863          	blez	a4,514 <printint+0x94>
 4e8:	fc040793          	addi	a5,s0,-64
 4ec:	00e78933          	add	s2,a5,a4
 4f0:	fff78993          	addi	s3,a5,-1
 4f4:	99ba                	add	s3,s3,a4
 4f6:	377d                	addiw	a4,a4,-1
 4f8:	1702                	slli	a4,a4,0x20
 4fa:	9301                	srli	a4,a4,0x20
 4fc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 500:	fff94583          	lbu	a1,-1(s2)
 504:	8526                	mv	a0,s1
 506:	00000097          	auipc	ra,0x0
 50a:	f58080e7          	jalr	-168(ra) # 45e <putc>
  while(--i >= 0)
 50e:	197d                	addi	s2,s2,-1
 510:	ff3918e3          	bne	s2,s3,500 <printint+0x80>
}
 514:	70e2                	ld	ra,56(sp)
 516:	7442                	ld	s0,48(sp)
 518:	74a2                	ld	s1,40(sp)
 51a:	7902                	ld	s2,32(sp)
 51c:	69e2                	ld	s3,24(sp)
 51e:	6121                	addi	sp,sp,64
 520:	8082                	ret
    x = -xx;
 522:	40b005bb          	negw	a1,a1
    neg = 1;
 526:	4885                	li	a7,1
    x = -xx;
 528:	bf8d                	j	49a <printint+0x1a>

000000000000052a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 52a:	7119                	addi	sp,sp,-128
 52c:	fc86                	sd	ra,120(sp)
 52e:	f8a2                	sd	s0,112(sp)
 530:	f4a6                	sd	s1,104(sp)
 532:	f0ca                	sd	s2,96(sp)
 534:	ecce                	sd	s3,88(sp)
 536:	e8d2                	sd	s4,80(sp)
 538:	e4d6                	sd	s5,72(sp)
 53a:	e0da                	sd	s6,64(sp)
 53c:	fc5e                	sd	s7,56(sp)
 53e:	f862                	sd	s8,48(sp)
 540:	f466                	sd	s9,40(sp)
 542:	f06a                	sd	s10,32(sp)
 544:	ec6e                	sd	s11,24(sp)
 546:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 548:	0005c903          	lbu	s2,0(a1)
 54c:	18090f63          	beqz	s2,6ea <vprintf+0x1c0>
 550:	8aaa                	mv	s5,a0
 552:	8b32                	mv	s6,a2
 554:	00158493          	addi	s1,a1,1
  state = 0;
 558:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 55a:	02500a13          	li	s4,37
      if(c == 'd'){
 55e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 562:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 566:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 56a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 56e:	00000b97          	auipc	s7,0x0
 572:	38ab8b93          	addi	s7,s7,906 # 8f8 <digits>
 576:	a839                	j	594 <vprintf+0x6a>
        putc(fd, c);
 578:	85ca                	mv	a1,s2
 57a:	8556                	mv	a0,s5
 57c:	00000097          	auipc	ra,0x0
 580:	ee2080e7          	jalr	-286(ra) # 45e <putc>
 584:	a019                	j	58a <vprintf+0x60>
    } else if(state == '%'){
 586:	01498f63          	beq	s3,s4,5a4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 58a:	0485                	addi	s1,s1,1
 58c:	fff4c903          	lbu	s2,-1(s1)
 590:	14090d63          	beqz	s2,6ea <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 594:	0009079b          	sext.w	a5,s2
    if(state == 0){
 598:	fe0997e3          	bnez	s3,586 <vprintf+0x5c>
      if(c == '%'){
 59c:	fd479ee3          	bne	a5,s4,578 <vprintf+0x4e>
        state = '%';
 5a0:	89be                	mv	s3,a5
 5a2:	b7e5                	j	58a <vprintf+0x60>
      if(c == 'd'){
 5a4:	05878063          	beq	a5,s8,5e4 <vprintf+0xba>
      } else if(c == 'l') {
 5a8:	05978c63          	beq	a5,s9,600 <vprintf+0xd6>
      } else if(c == 'x') {
 5ac:	07a78863          	beq	a5,s10,61c <vprintf+0xf2>
      } else if(c == 'p') {
 5b0:	09b78463          	beq	a5,s11,638 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5b4:	07300713          	li	a4,115
 5b8:	0ce78663          	beq	a5,a4,684 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5bc:	06300713          	li	a4,99
 5c0:	0ee78e63          	beq	a5,a4,6bc <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5c4:	11478863          	beq	a5,s4,6d4 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5c8:	85d2                	mv	a1,s4
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	e92080e7          	jalr	-366(ra) # 45e <putc>
        putc(fd, c);
 5d4:	85ca                	mv	a1,s2
 5d6:	8556                	mv	a0,s5
 5d8:	00000097          	auipc	ra,0x0
 5dc:	e86080e7          	jalr	-378(ra) # 45e <putc>
      }
      state = 0;
 5e0:	4981                	li	s3,0
 5e2:	b765                	j	58a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5e4:	008b0913          	addi	s2,s6,8
 5e8:	4685                	li	a3,1
 5ea:	4629                	li	a2,10
 5ec:	000b2583          	lw	a1,0(s6)
 5f0:	8556                	mv	a0,s5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	e8e080e7          	jalr	-370(ra) # 480 <printint>
 5fa:	8b4a                	mv	s6,s2
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	b771                	j	58a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 600:	008b0913          	addi	s2,s6,8
 604:	4681                	li	a3,0
 606:	4629                	li	a2,10
 608:	000b2583          	lw	a1,0(s6)
 60c:	8556                	mv	a0,s5
 60e:	00000097          	auipc	ra,0x0
 612:	e72080e7          	jalr	-398(ra) # 480 <printint>
 616:	8b4a                	mv	s6,s2
      state = 0;
 618:	4981                	li	s3,0
 61a:	bf85                	j	58a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 61c:	008b0913          	addi	s2,s6,8
 620:	4681                	li	a3,0
 622:	4641                	li	a2,16
 624:	000b2583          	lw	a1,0(s6)
 628:	8556                	mv	a0,s5
 62a:	00000097          	auipc	ra,0x0
 62e:	e56080e7          	jalr	-426(ra) # 480 <printint>
 632:	8b4a                	mv	s6,s2
      state = 0;
 634:	4981                	li	s3,0
 636:	bf91                	j	58a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 638:	008b0793          	addi	a5,s6,8
 63c:	f8f43423          	sd	a5,-120(s0)
 640:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 644:	03000593          	li	a1,48
 648:	8556                	mv	a0,s5
 64a:	00000097          	auipc	ra,0x0
 64e:	e14080e7          	jalr	-492(ra) # 45e <putc>
  putc(fd, 'x');
 652:	85ea                	mv	a1,s10
 654:	8556                	mv	a0,s5
 656:	00000097          	auipc	ra,0x0
 65a:	e08080e7          	jalr	-504(ra) # 45e <putc>
 65e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 660:	03c9d793          	srli	a5,s3,0x3c
 664:	97de                	add	a5,a5,s7
 666:	0007c583          	lbu	a1,0(a5)
 66a:	8556                	mv	a0,s5
 66c:	00000097          	auipc	ra,0x0
 670:	df2080e7          	jalr	-526(ra) # 45e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 674:	0992                	slli	s3,s3,0x4
 676:	397d                	addiw	s2,s2,-1
 678:	fe0914e3          	bnez	s2,660 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 67c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 680:	4981                	li	s3,0
 682:	b721                	j	58a <vprintf+0x60>
        s = va_arg(ap, char*);
 684:	008b0993          	addi	s3,s6,8
 688:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 68c:	02090163          	beqz	s2,6ae <vprintf+0x184>
        while(*s != 0){
 690:	00094583          	lbu	a1,0(s2)
 694:	c9a1                	beqz	a1,6e4 <vprintf+0x1ba>
          putc(fd, *s);
 696:	8556                	mv	a0,s5
 698:	00000097          	auipc	ra,0x0
 69c:	dc6080e7          	jalr	-570(ra) # 45e <putc>
          s++;
 6a0:	0905                	addi	s2,s2,1
        while(*s != 0){
 6a2:	00094583          	lbu	a1,0(s2)
 6a6:	f9e5                	bnez	a1,696 <vprintf+0x16c>
        s = va_arg(ap, char*);
 6a8:	8b4e                	mv	s6,s3
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	bdf9                	j	58a <vprintf+0x60>
          s = "(null)";
 6ae:	00000917          	auipc	s2,0x0
 6b2:	24290913          	addi	s2,s2,578 # 8f0 <malloc+0xfc>
        while(*s != 0){
 6b6:	02800593          	li	a1,40
 6ba:	bff1                	j	696 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 6bc:	008b0913          	addi	s2,s6,8
 6c0:	000b4583          	lbu	a1,0(s6)
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	d98080e7          	jalr	-616(ra) # 45e <putc>
 6ce:	8b4a                	mv	s6,s2
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	bd65                	j	58a <vprintf+0x60>
        putc(fd, c);
 6d4:	85d2                	mv	a1,s4
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	d86080e7          	jalr	-634(ra) # 45e <putc>
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b565                	j	58a <vprintf+0x60>
        s = va_arg(ap, char*);
 6e4:	8b4e                	mv	s6,s3
      state = 0;
 6e6:	4981                	li	s3,0
 6e8:	b54d                	j	58a <vprintf+0x60>
    }
  }
}
 6ea:	70e6                	ld	ra,120(sp)
 6ec:	7446                	ld	s0,112(sp)
 6ee:	74a6                	ld	s1,104(sp)
 6f0:	7906                	ld	s2,96(sp)
 6f2:	69e6                	ld	s3,88(sp)
 6f4:	6a46                	ld	s4,80(sp)
 6f6:	6aa6                	ld	s5,72(sp)
 6f8:	6b06                	ld	s6,64(sp)
 6fa:	7be2                	ld	s7,56(sp)
 6fc:	7c42                	ld	s8,48(sp)
 6fe:	7ca2                	ld	s9,40(sp)
 700:	7d02                	ld	s10,32(sp)
 702:	6de2                	ld	s11,24(sp)
 704:	6109                	addi	sp,sp,128
 706:	8082                	ret

0000000000000708 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 708:	715d                	addi	sp,sp,-80
 70a:	ec06                	sd	ra,24(sp)
 70c:	e822                	sd	s0,16(sp)
 70e:	1000                	addi	s0,sp,32
 710:	e010                	sd	a2,0(s0)
 712:	e414                	sd	a3,8(s0)
 714:	e818                	sd	a4,16(s0)
 716:	ec1c                	sd	a5,24(s0)
 718:	03043023          	sd	a6,32(s0)
 71c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 720:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 724:	8622                	mv	a2,s0
 726:	00000097          	auipc	ra,0x0
 72a:	e04080e7          	jalr	-508(ra) # 52a <vprintf>
}
 72e:	60e2                	ld	ra,24(sp)
 730:	6442                	ld	s0,16(sp)
 732:	6161                	addi	sp,sp,80
 734:	8082                	ret

0000000000000736 <printf>:

void
printf(const char *fmt, ...)
{
 736:	711d                	addi	sp,sp,-96
 738:	ec06                	sd	ra,24(sp)
 73a:	e822                	sd	s0,16(sp)
 73c:	1000                	addi	s0,sp,32
 73e:	e40c                	sd	a1,8(s0)
 740:	e810                	sd	a2,16(s0)
 742:	ec14                	sd	a3,24(s0)
 744:	f018                	sd	a4,32(s0)
 746:	f41c                	sd	a5,40(s0)
 748:	03043823          	sd	a6,48(s0)
 74c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 750:	00840613          	addi	a2,s0,8
 754:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 758:	85aa                	mv	a1,a0
 75a:	4505                	li	a0,1
 75c:	00000097          	auipc	ra,0x0
 760:	dce080e7          	jalr	-562(ra) # 52a <vprintf>
}
 764:	60e2                	ld	ra,24(sp)
 766:	6442                	ld	s0,16(sp)
 768:	6125                	addi	sp,sp,96
 76a:	8082                	ret

000000000000076c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 76c:	1141                	addi	sp,sp,-16
 76e:	e422                	sd	s0,8(sp)
 770:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 772:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 776:	00000797          	auipc	a5,0x0
 77a:	19a7b783          	ld	a5,410(a5) # 910 <freep>
 77e:	a805                	j	7ae <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 780:	4618                	lw	a4,8(a2)
 782:	9db9                	addw	a1,a1,a4
 784:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 788:	6398                	ld	a4,0(a5)
 78a:	6318                	ld	a4,0(a4)
 78c:	fee53823          	sd	a4,-16(a0)
 790:	a091                	j	7d4 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 792:	ff852703          	lw	a4,-8(a0)
 796:	9e39                	addw	a2,a2,a4
 798:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 79a:	ff053703          	ld	a4,-16(a0)
 79e:	e398                	sd	a4,0(a5)
 7a0:	a099                	j	7e6 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a2:	6398                	ld	a4,0(a5)
 7a4:	00e7e463          	bltu	a5,a4,7ac <free+0x40>
 7a8:	00e6ea63          	bltu	a3,a4,7bc <free+0x50>
{
 7ac:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ae:	fed7fae3          	bgeu	a5,a3,7a2 <free+0x36>
 7b2:	6398                	ld	a4,0(a5)
 7b4:	00e6e463          	bltu	a3,a4,7bc <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b8:	fee7eae3          	bltu	a5,a4,7ac <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 7bc:	ff852583          	lw	a1,-8(a0)
 7c0:	6390                	ld	a2,0(a5)
 7c2:	02059813          	slli	a6,a1,0x20
 7c6:	01c85713          	srli	a4,a6,0x1c
 7ca:	9736                	add	a4,a4,a3
 7cc:	fae60ae3          	beq	a2,a4,780 <free+0x14>
    bp->s.ptr = p->s.ptr;
 7d0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7d4:	4790                	lw	a2,8(a5)
 7d6:	02061593          	slli	a1,a2,0x20
 7da:	01c5d713          	srli	a4,a1,0x1c
 7de:	973e                	add	a4,a4,a5
 7e0:	fae689e3          	beq	a3,a4,792 <free+0x26>
  } else
    p->s.ptr = bp;
 7e4:	e394                	sd	a3,0(a5)
  freep = p;
 7e6:	00000717          	auipc	a4,0x0
 7ea:	12f73523          	sd	a5,298(a4) # 910 <freep>
}
 7ee:	6422                	ld	s0,8(sp)
 7f0:	0141                	addi	sp,sp,16
 7f2:	8082                	ret

00000000000007f4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f4:	7139                	addi	sp,sp,-64
 7f6:	fc06                	sd	ra,56(sp)
 7f8:	f822                	sd	s0,48(sp)
 7fa:	f426                	sd	s1,40(sp)
 7fc:	f04a                	sd	s2,32(sp)
 7fe:	ec4e                	sd	s3,24(sp)
 800:	e852                	sd	s4,16(sp)
 802:	e456                	sd	s5,8(sp)
 804:	e05a                	sd	s6,0(sp)
 806:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 808:	02051493          	slli	s1,a0,0x20
 80c:	9081                	srli	s1,s1,0x20
 80e:	04bd                	addi	s1,s1,15
 810:	8091                	srli	s1,s1,0x4
 812:	0014899b          	addiw	s3,s1,1
 816:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 818:	00000517          	auipc	a0,0x0
 81c:	0f853503          	ld	a0,248(a0) # 910 <freep>
 820:	c515                	beqz	a0,84c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 822:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 824:	4798                	lw	a4,8(a5)
 826:	02977f63          	bgeu	a4,s1,864 <malloc+0x70>
 82a:	8a4e                	mv	s4,s3
 82c:	0009871b          	sext.w	a4,s3
 830:	6685                	lui	a3,0x1
 832:	00d77363          	bgeu	a4,a3,838 <malloc+0x44>
 836:	6a05                	lui	s4,0x1
 838:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 83c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 840:	00000917          	auipc	s2,0x0
 844:	0d090913          	addi	s2,s2,208 # 910 <freep>
  if(p == (char*)-1)
 848:	5afd                	li	s5,-1
 84a:	a895                	j	8be <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 84c:	00000797          	auipc	a5,0x0
 850:	0cc78793          	addi	a5,a5,204 # 918 <base>
 854:	00000717          	auipc	a4,0x0
 858:	0af73e23          	sd	a5,188(a4) # 910 <freep>
 85c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 85e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 862:	b7e1                	j	82a <malloc+0x36>
      if(p->s.size == nunits)
 864:	02e48c63          	beq	s1,a4,89c <malloc+0xa8>
        p->s.size -= nunits;
 868:	4137073b          	subw	a4,a4,s3
 86c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 86e:	02071693          	slli	a3,a4,0x20
 872:	01c6d713          	srli	a4,a3,0x1c
 876:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 878:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 87c:	00000717          	auipc	a4,0x0
 880:	08a73a23          	sd	a0,148(a4) # 910 <freep>
      return (void*)(p + 1);
 884:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 888:	70e2                	ld	ra,56(sp)
 88a:	7442                	ld	s0,48(sp)
 88c:	74a2                	ld	s1,40(sp)
 88e:	7902                	ld	s2,32(sp)
 890:	69e2                	ld	s3,24(sp)
 892:	6a42                	ld	s4,16(sp)
 894:	6aa2                	ld	s5,8(sp)
 896:	6b02                	ld	s6,0(sp)
 898:	6121                	addi	sp,sp,64
 89a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 89c:	6398                	ld	a4,0(a5)
 89e:	e118                	sd	a4,0(a0)
 8a0:	bff1                	j	87c <malloc+0x88>
  hp->s.size = nu;
 8a2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8a6:	0541                	addi	a0,a0,16
 8a8:	00000097          	auipc	ra,0x0
 8ac:	ec4080e7          	jalr	-316(ra) # 76c <free>
  return freep;
 8b0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8b4:	d971                	beqz	a0,888 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8b8:	4798                	lw	a4,8(a5)
 8ba:	fa9775e3          	bgeu	a4,s1,864 <malloc+0x70>
    if(p == freep)
 8be:	00093703          	ld	a4,0(s2)
 8c2:	853e                	mv	a0,a5
 8c4:	fef719e3          	bne	a4,a5,8b6 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8c8:	8552                	mv	a0,s4
 8ca:	00000097          	auipc	ra,0x0
 8ce:	b7c080e7          	jalr	-1156(ra) # 446 <sbrk>
  if(p == (char*)-1)
 8d2:	fd5518e3          	bne	a0,s5,8a2 <malloc+0xae>
        return 0;
 8d6:	4501                	li	a0,0
 8d8:	bf45                	j	888 <malloc+0x94>
