
user/_pingpong:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

#define BUFSIZE 2
int main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
    int p1[2];
    int p2[2];
    char buf[BUFSIZE];
    pipe(p1);
   8:	fe840513          	addi	a0,s0,-24
   c:	00000097          	auipc	ra,0x0
  10:	392080e7          	jalr	914(ra) # 39e <pipe>
    pipe(p2);
  14:	fe040513          	addi	a0,s0,-32
  18:	00000097          	auipc	ra,0x0
  1c:	386080e7          	jalr	902(ra) # 39e <pipe>
    int pid = fork();
  20:	00000097          	auipc	ra,0x0
  24:	366080e7          	jalr	870(ra) # 386 <fork>
    if (pid < 0)
  28:	06054663          	bltz	a0,94 <main+0x94>
    {
        fprintf(2, "fork() error");
        exit(1);
    }
    if (pid == 0)
  2c:	e151                	bnez	a0,b0 <main+0xb0>
    {
        close(p1[1]);
  2e:	fec42503          	lw	a0,-20(s0)
  32:	00000097          	auipc	ra,0x0
  36:	384080e7          	jalr	900(ra) # 3b6 <close>
        close(p2[0]);
  3a:	fe042503          	lw	a0,-32(s0)
  3e:	00000097          	auipc	ra,0x0
  42:	378080e7          	jalr	888(ra) # 3b6 <close>
        read(p1[0], buf, BUFSIZE);
  46:	4609                	li	a2,2
  48:	fd840593          	addi	a1,s0,-40
  4c:	fe842503          	lw	a0,-24(s0)
  50:	00000097          	auipc	ra,0x0
  54:	356080e7          	jalr	854(ra) # 3a6 <read>
        fprintf(1, "<%d>: reveived ping\n", getpid());
  58:	00000097          	auipc	ra,0x0
  5c:	3b6080e7          	jalr	950(ra) # 40e <getpid>
  60:	862a                	mv	a2,a0
  62:	00001597          	auipc	a1,0x1
  66:	85658593          	addi	a1,a1,-1962 # 8b8 <malloc+0xf4>
  6a:	4505                	li	a0,1
  6c:	00000097          	auipc	ra,0x0
  70:	66c080e7          	jalr	1644(ra) # 6d8 <fprintf>
        write(p2[1], "1", 1);
  74:	4605                	li	a2,1
  76:	00001597          	auipc	a1,0x1
  7a:	85a58593          	addi	a1,a1,-1958 # 8d0 <malloc+0x10c>
  7e:	fe442503          	lw	a0,-28(s0)
  82:	00000097          	auipc	ra,0x0
  86:	32c080e7          	jalr	812(ra) # 3ae <write>
        write(p1[1], "1", 1);
        read(p2[0], buf, BUFSIZE);
        fprintf(1, "<%d>: received pong\n", getpid());
        wait((int *)0);
    }
    exit(0);
  8a:	4501                	li	a0,0
  8c:	00000097          	auipc	ra,0x0
  90:	302080e7          	jalr	770(ra) # 38e <exit>
        fprintf(2, "fork() error");
  94:	00001597          	auipc	a1,0x1
  98:	81458593          	addi	a1,a1,-2028 # 8a8 <malloc+0xe4>
  9c:	4509                	li	a0,2
  9e:	00000097          	auipc	ra,0x0
  a2:	63a080e7          	jalr	1594(ra) # 6d8 <fprintf>
        exit(1);
  a6:	4505                	li	a0,1
  a8:	00000097          	auipc	ra,0x0
  ac:	2e6080e7          	jalr	742(ra) # 38e <exit>
        close(p1[0]);
  b0:	fe842503          	lw	a0,-24(s0)
  b4:	00000097          	auipc	ra,0x0
  b8:	302080e7          	jalr	770(ra) # 3b6 <close>
        close(p2[1]);
  bc:	fe442503          	lw	a0,-28(s0)
  c0:	00000097          	auipc	ra,0x0
  c4:	2f6080e7          	jalr	758(ra) # 3b6 <close>
        write(p1[1], "1", 1);
  c8:	4605                	li	a2,1
  ca:	00001597          	auipc	a1,0x1
  ce:	80658593          	addi	a1,a1,-2042 # 8d0 <malloc+0x10c>
  d2:	fec42503          	lw	a0,-20(s0)
  d6:	00000097          	auipc	ra,0x0
  da:	2d8080e7          	jalr	728(ra) # 3ae <write>
        read(p2[0], buf, BUFSIZE);
  de:	4609                	li	a2,2
  e0:	fd840593          	addi	a1,s0,-40
  e4:	fe042503          	lw	a0,-32(s0)
  e8:	00000097          	auipc	ra,0x0
  ec:	2be080e7          	jalr	702(ra) # 3a6 <read>
        fprintf(1, "<%d>: received pong\n", getpid());
  f0:	00000097          	auipc	ra,0x0
  f4:	31e080e7          	jalr	798(ra) # 40e <getpid>
  f8:	862a                	mv	a2,a0
  fa:	00000597          	auipc	a1,0x0
  fe:	7de58593          	addi	a1,a1,2014 # 8d8 <malloc+0x114>
 102:	4505                	li	a0,1
 104:	00000097          	auipc	ra,0x0
 108:	5d4080e7          	jalr	1492(ra) # 6d8 <fprintf>
        wait((int *)0);
 10c:	4501                	li	a0,0
 10e:	00000097          	auipc	ra,0x0
 112:	288080e7          	jalr	648(ra) # 396 <wait>
 116:	bf95                	j	8a <main+0x8a>

0000000000000118 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 118:	1141                	addi	sp,sp,-16
 11a:	e422                	sd	s0,8(sp)
 11c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11e:	87aa                	mv	a5,a0
 120:	0585                	addi	a1,a1,1
 122:	0785                	addi	a5,a5,1
 124:	fff5c703          	lbu	a4,-1(a1)
 128:	fee78fa3          	sb	a4,-1(a5)
 12c:	fb75                	bnez	a4,120 <strcpy+0x8>
    ;
  return os;
}
 12e:	6422                	ld	s0,8(sp)
 130:	0141                	addi	sp,sp,16
 132:	8082                	ret

0000000000000134 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 134:	1141                	addi	sp,sp,-16
 136:	e422                	sd	s0,8(sp)
 138:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 13a:	00054783          	lbu	a5,0(a0)
 13e:	cb91                	beqz	a5,152 <strcmp+0x1e>
 140:	0005c703          	lbu	a4,0(a1)
 144:	00f71763          	bne	a4,a5,152 <strcmp+0x1e>
    p++, q++;
 148:	0505                	addi	a0,a0,1
 14a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 14c:	00054783          	lbu	a5,0(a0)
 150:	fbe5                	bnez	a5,140 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 152:	0005c503          	lbu	a0,0(a1)
}
 156:	40a7853b          	subw	a0,a5,a0
 15a:	6422                	ld	s0,8(sp)
 15c:	0141                	addi	sp,sp,16
 15e:	8082                	ret

0000000000000160 <strlen>:

uint
strlen(const char *s)
{
 160:	1141                	addi	sp,sp,-16
 162:	e422                	sd	s0,8(sp)
 164:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 166:	00054783          	lbu	a5,0(a0)
 16a:	cf91                	beqz	a5,186 <strlen+0x26>
 16c:	0505                	addi	a0,a0,1
 16e:	87aa                	mv	a5,a0
 170:	4685                	li	a3,1
 172:	9e89                	subw	a3,a3,a0
 174:	00f6853b          	addw	a0,a3,a5
 178:	0785                	addi	a5,a5,1
 17a:	fff7c703          	lbu	a4,-1(a5)
 17e:	fb7d                	bnez	a4,174 <strlen+0x14>
    ;
  return n;
}
 180:	6422                	ld	s0,8(sp)
 182:	0141                	addi	sp,sp,16
 184:	8082                	ret
  for(n = 0; s[n]; n++)
 186:	4501                	li	a0,0
 188:	bfe5                	j	180 <strlen+0x20>

000000000000018a <memset>:

void*
memset(void *dst, int c, uint n)
{
 18a:	1141                	addi	sp,sp,-16
 18c:	e422                	sd	s0,8(sp)
 18e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 190:	ce09                	beqz	a2,1aa <memset+0x20>
 192:	87aa                	mv	a5,a0
 194:	fff6071b          	addiw	a4,a2,-1
 198:	1702                	slli	a4,a4,0x20
 19a:	9301                	srli	a4,a4,0x20
 19c:	0705                	addi	a4,a4,1
 19e:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1a0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1a4:	0785                	addi	a5,a5,1
 1a6:	fee79de3          	bne	a5,a4,1a0 <memset+0x16>
  }
  return dst;
}
 1aa:	6422                	ld	s0,8(sp)
 1ac:	0141                	addi	sp,sp,16
 1ae:	8082                	ret

00000000000001b0 <strchr>:

char*
strchr(const char *s, char c)
{
 1b0:	1141                	addi	sp,sp,-16
 1b2:	e422                	sd	s0,8(sp)
 1b4:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1b6:	00054783          	lbu	a5,0(a0)
 1ba:	cb99                	beqz	a5,1d0 <strchr+0x20>
    if(*s == c)
 1bc:	00f58763          	beq	a1,a5,1ca <strchr+0x1a>
  for(; *s; s++)
 1c0:	0505                	addi	a0,a0,1
 1c2:	00054783          	lbu	a5,0(a0)
 1c6:	fbfd                	bnez	a5,1bc <strchr+0xc>
      return (char*)s;
  return 0;
 1c8:	4501                	li	a0,0
}
 1ca:	6422                	ld	s0,8(sp)
 1cc:	0141                	addi	sp,sp,16
 1ce:	8082                	ret
  return 0;
 1d0:	4501                	li	a0,0
 1d2:	bfe5                	j	1ca <strchr+0x1a>

00000000000001d4 <gets>:

char*
gets(char *buf, int max)
{
 1d4:	711d                	addi	sp,sp,-96
 1d6:	ec86                	sd	ra,88(sp)
 1d8:	e8a2                	sd	s0,80(sp)
 1da:	e4a6                	sd	s1,72(sp)
 1dc:	e0ca                	sd	s2,64(sp)
 1de:	fc4e                	sd	s3,56(sp)
 1e0:	f852                	sd	s4,48(sp)
 1e2:	f456                	sd	s5,40(sp)
 1e4:	f05a                	sd	s6,32(sp)
 1e6:	ec5e                	sd	s7,24(sp)
 1e8:	1080                	addi	s0,sp,96
 1ea:	8baa                	mv	s7,a0
 1ec:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ee:	892a                	mv	s2,a0
 1f0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1f2:	4aa9                	li	s5,10
 1f4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1f6:	89a6                	mv	s3,s1
 1f8:	2485                	addiw	s1,s1,1
 1fa:	0344d863          	bge	s1,s4,22a <gets+0x56>
    cc = read(0, &c, 1);
 1fe:	4605                	li	a2,1
 200:	faf40593          	addi	a1,s0,-81
 204:	4501                	li	a0,0
 206:	00000097          	auipc	ra,0x0
 20a:	1a0080e7          	jalr	416(ra) # 3a6 <read>
    if(cc < 1)
 20e:	00a05e63          	blez	a0,22a <gets+0x56>
    buf[i++] = c;
 212:	faf44783          	lbu	a5,-81(s0)
 216:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 21a:	01578763          	beq	a5,s5,228 <gets+0x54>
 21e:	0905                	addi	s2,s2,1
 220:	fd679be3          	bne	a5,s6,1f6 <gets+0x22>
  for(i=0; i+1 < max; ){
 224:	89a6                	mv	s3,s1
 226:	a011                	j	22a <gets+0x56>
 228:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 22a:	99de                	add	s3,s3,s7
 22c:	00098023          	sb	zero,0(s3)
  return buf;
}
 230:	855e                	mv	a0,s7
 232:	60e6                	ld	ra,88(sp)
 234:	6446                	ld	s0,80(sp)
 236:	64a6                	ld	s1,72(sp)
 238:	6906                	ld	s2,64(sp)
 23a:	79e2                	ld	s3,56(sp)
 23c:	7a42                	ld	s4,48(sp)
 23e:	7aa2                	ld	s5,40(sp)
 240:	7b02                	ld	s6,32(sp)
 242:	6be2                	ld	s7,24(sp)
 244:	6125                	addi	sp,sp,96
 246:	8082                	ret

0000000000000248 <stat>:

int
stat(const char *n, struct stat *st)
{
 248:	1101                	addi	sp,sp,-32
 24a:	ec06                	sd	ra,24(sp)
 24c:	e822                	sd	s0,16(sp)
 24e:	e426                	sd	s1,8(sp)
 250:	e04a                	sd	s2,0(sp)
 252:	1000                	addi	s0,sp,32
 254:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 256:	4581                	li	a1,0
 258:	00000097          	auipc	ra,0x0
 25c:	176080e7          	jalr	374(ra) # 3ce <open>
  if(fd < 0)
 260:	02054563          	bltz	a0,28a <stat+0x42>
 264:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 266:	85ca                	mv	a1,s2
 268:	00000097          	auipc	ra,0x0
 26c:	17e080e7          	jalr	382(ra) # 3e6 <fstat>
 270:	892a                	mv	s2,a0
  close(fd);
 272:	8526                	mv	a0,s1
 274:	00000097          	auipc	ra,0x0
 278:	142080e7          	jalr	322(ra) # 3b6 <close>
  return r;
}
 27c:	854a                	mv	a0,s2
 27e:	60e2                	ld	ra,24(sp)
 280:	6442                	ld	s0,16(sp)
 282:	64a2                	ld	s1,8(sp)
 284:	6902                	ld	s2,0(sp)
 286:	6105                	addi	sp,sp,32
 288:	8082                	ret
    return -1;
 28a:	597d                	li	s2,-1
 28c:	bfc5                	j	27c <stat+0x34>

000000000000028e <atoi>:

int
atoi(const char *s)
{
 28e:	1141                	addi	sp,sp,-16
 290:	e422                	sd	s0,8(sp)
 292:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 294:	00054603          	lbu	a2,0(a0)
 298:	fd06079b          	addiw	a5,a2,-48
 29c:	0ff7f793          	andi	a5,a5,255
 2a0:	4725                	li	a4,9
 2a2:	02f76963          	bltu	a4,a5,2d4 <atoi+0x46>
 2a6:	86aa                	mv	a3,a0
  n = 0;
 2a8:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2aa:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2ac:	0685                	addi	a3,a3,1
 2ae:	0025179b          	slliw	a5,a0,0x2
 2b2:	9fa9                	addw	a5,a5,a0
 2b4:	0017979b          	slliw	a5,a5,0x1
 2b8:	9fb1                	addw	a5,a5,a2
 2ba:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2be:	0006c603          	lbu	a2,0(a3)
 2c2:	fd06071b          	addiw	a4,a2,-48
 2c6:	0ff77713          	andi	a4,a4,255
 2ca:	fee5f1e3          	bgeu	a1,a4,2ac <atoi+0x1e>
  return n;
}
 2ce:	6422                	ld	s0,8(sp)
 2d0:	0141                	addi	sp,sp,16
 2d2:	8082                	ret
  n = 0;
 2d4:	4501                	li	a0,0
 2d6:	bfe5                	j	2ce <atoi+0x40>

00000000000002d8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2d8:	1141                	addi	sp,sp,-16
 2da:	e422                	sd	s0,8(sp)
 2dc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2de:	02b57663          	bgeu	a0,a1,30a <memmove+0x32>
    while(n-- > 0)
 2e2:	02c05163          	blez	a2,304 <memmove+0x2c>
 2e6:	fff6079b          	addiw	a5,a2,-1
 2ea:	1782                	slli	a5,a5,0x20
 2ec:	9381                	srli	a5,a5,0x20
 2ee:	0785                	addi	a5,a5,1
 2f0:	97aa                	add	a5,a5,a0
  dst = vdst;
 2f2:	872a                	mv	a4,a0
      *dst++ = *src++;
 2f4:	0585                	addi	a1,a1,1
 2f6:	0705                	addi	a4,a4,1
 2f8:	fff5c683          	lbu	a3,-1(a1)
 2fc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 300:	fee79ae3          	bne	a5,a4,2f4 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 304:	6422                	ld	s0,8(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret
    dst += n;
 30a:	00c50733          	add	a4,a0,a2
    src += n;
 30e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 310:	fec05ae3          	blez	a2,304 <memmove+0x2c>
 314:	fff6079b          	addiw	a5,a2,-1
 318:	1782                	slli	a5,a5,0x20
 31a:	9381                	srli	a5,a5,0x20
 31c:	fff7c793          	not	a5,a5
 320:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 322:	15fd                	addi	a1,a1,-1
 324:	177d                	addi	a4,a4,-1
 326:	0005c683          	lbu	a3,0(a1)
 32a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 32e:	fee79ae3          	bne	a5,a4,322 <memmove+0x4a>
 332:	bfc9                	j	304 <memmove+0x2c>

0000000000000334 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 334:	1141                	addi	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 33a:	ca05                	beqz	a2,36a <memcmp+0x36>
 33c:	fff6069b          	addiw	a3,a2,-1
 340:	1682                	slli	a3,a3,0x20
 342:	9281                	srli	a3,a3,0x20
 344:	0685                	addi	a3,a3,1
 346:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 348:	00054783          	lbu	a5,0(a0)
 34c:	0005c703          	lbu	a4,0(a1)
 350:	00e79863          	bne	a5,a4,360 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 354:	0505                	addi	a0,a0,1
    p2++;
 356:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 358:	fed518e3          	bne	a0,a3,348 <memcmp+0x14>
  }
  return 0;
 35c:	4501                	li	a0,0
 35e:	a019                	j	364 <memcmp+0x30>
      return *p1 - *p2;
 360:	40e7853b          	subw	a0,a5,a4
}
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret
  return 0;
 36a:	4501                	li	a0,0
 36c:	bfe5                	j	364 <memcmp+0x30>

000000000000036e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 36e:	1141                	addi	sp,sp,-16
 370:	e406                	sd	ra,8(sp)
 372:	e022                	sd	s0,0(sp)
 374:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 376:	00000097          	auipc	ra,0x0
 37a:	f62080e7          	jalr	-158(ra) # 2d8 <memmove>
}
 37e:	60a2                	ld	ra,8(sp)
 380:	6402                	ld	s0,0(sp)
 382:	0141                	addi	sp,sp,16
 384:	8082                	ret

0000000000000386 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 386:	4885                	li	a7,1
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <exit>:
.global exit
exit:
 li a7, SYS_exit
 38e:	4889                	li	a7,2
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <wait>:
.global wait
wait:
 li a7, SYS_wait
 396:	488d                	li	a7,3
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 39e:	4891                	li	a7,4
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <read>:
.global read
read:
 li a7, SYS_read
 3a6:	4895                	li	a7,5
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <write>:
.global write
write:
 li a7, SYS_write
 3ae:	48c1                	li	a7,16
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <close>:
.global close
close:
 li a7, SYS_close
 3b6:	48d5                	li	a7,21
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <kill>:
.global kill
kill:
 li a7, SYS_kill
 3be:	4899                	li	a7,6
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3c6:	489d                	li	a7,7
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <open>:
.global open
open:
 li a7, SYS_open
 3ce:	48bd                	li	a7,15
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3d6:	48c5                	li	a7,17
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3de:	48c9                	li	a7,18
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3e6:	48a1                	li	a7,8
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <link>:
.global link
link:
 li a7, SYS_link
 3ee:	48cd                	li	a7,19
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3f6:	48d1                	li	a7,20
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3fe:	48a5                	li	a7,9
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <dup>:
.global dup
dup:
 li a7, SYS_dup
 406:	48a9                	li	a7,10
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 40e:	48ad                	li	a7,11
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 416:	48b1                	li	a7,12
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 41e:	48b5                	li	a7,13
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 426:	48b9                	li	a7,14
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 42e:	1101                	addi	sp,sp,-32
 430:	ec06                	sd	ra,24(sp)
 432:	e822                	sd	s0,16(sp)
 434:	1000                	addi	s0,sp,32
 436:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 43a:	4605                	li	a2,1
 43c:	fef40593          	addi	a1,s0,-17
 440:	00000097          	auipc	ra,0x0
 444:	f6e080e7          	jalr	-146(ra) # 3ae <write>
}
 448:	60e2                	ld	ra,24(sp)
 44a:	6442                	ld	s0,16(sp)
 44c:	6105                	addi	sp,sp,32
 44e:	8082                	ret

0000000000000450 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 450:	7139                	addi	sp,sp,-64
 452:	fc06                	sd	ra,56(sp)
 454:	f822                	sd	s0,48(sp)
 456:	f426                	sd	s1,40(sp)
 458:	f04a                	sd	s2,32(sp)
 45a:	ec4e                	sd	s3,24(sp)
 45c:	0080                	addi	s0,sp,64
 45e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 460:	c299                	beqz	a3,466 <printint+0x16>
 462:	0805c863          	bltz	a1,4f2 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 466:	2581                	sext.w	a1,a1
  neg = 0;
 468:	4881                	li	a7,0
 46a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 46e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 470:	2601                	sext.w	a2,a2
 472:	00000517          	auipc	a0,0x0
 476:	48650513          	addi	a0,a0,1158 # 8f8 <digits>
 47a:	883a                	mv	a6,a4
 47c:	2705                	addiw	a4,a4,1
 47e:	02c5f7bb          	remuw	a5,a1,a2
 482:	1782                	slli	a5,a5,0x20
 484:	9381                	srli	a5,a5,0x20
 486:	97aa                	add	a5,a5,a0
 488:	0007c783          	lbu	a5,0(a5)
 48c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 490:	0005879b          	sext.w	a5,a1
 494:	02c5d5bb          	divuw	a1,a1,a2
 498:	0685                	addi	a3,a3,1
 49a:	fec7f0e3          	bgeu	a5,a2,47a <printint+0x2a>
  if(neg)
 49e:	00088b63          	beqz	a7,4b4 <printint+0x64>
    buf[i++] = '-';
 4a2:	fd040793          	addi	a5,s0,-48
 4a6:	973e                	add	a4,a4,a5
 4a8:	02d00793          	li	a5,45
 4ac:	fef70823          	sb	a5,-16(a4)
 4b0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4b4:	02e05863          	blez	a4,4e4 <printint+0x94>
 4b8:	fc040793          	addi	a5,s0,-64
 4bc:	00e78933          	add	s2,a5,a4
 4c0:	fff78993          	addi	s3,a5,-1
 4c4:	99ba                	add	s3,s3,a4
 4c6:	377d                	addiw	a4,a4,-1
 4c8:	1702                	slli	a4,a4,0x20
 4ca:	9301                	srli	a4,a4,0x20
 4cc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4d0:	fff94583          	lbu	a1,-1(s2)
 4d4:	8526                	mv	a0,s1
 4d6:	00000097          	auipc	ra,0x0
 4da:	f58080e7          	jalr	-168(ra) # 42e <putc>
  while(--i >= 0)
 4de:	197d                	addi	s2,s2,-1
 4e0:	ff3918e3          	bne	s2,s3,4d0 <printint+0x80>
}
 4e4:	70e2                	ld	ra,56(sp)
 4e6:	7442                	ld	s0,48(sp)
 4e8:	74a2                	ld	s1,40(sp)
 4ea:	7902                	ld	s2,32(sp)
 4ec:	69e2                	ld	s3,24(sp)
 4ee:	6121                	addi	sp,sp,64
 4f0:	8082                	ret
    x = -xx;
 4f2:	40b005bb          	negw	a1,a1
    neg = 1;
 4f6:	4885                	li	a7,1
    x = -xx;
 4f8:	bf8d                	j	46a <printint+0x1a>

00000000000004fa <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4fa:	7119                	addi	sp,sp,-128
 4fc:	fc86                	sd	ra,120(sp)
 4fe:	f8a2                	sd	s0,112(sp)
 500:	f4a6                	sd	s1,104(sp)
 502:	f0ca                	sd	s2,96(sp)
 504:	ecce                	sd	s3,88(sp)
 506:	e8d2                	sd	s4,80(sp)
 508:	e4d6                	sd	s5,72(sp)
 50a:	e0da                	sd	s6,64(sp)
 50c:	fc5e                	sd	s7,56(sp)
 50e:	f862                	sd	s8,48(sp)
 510:	f466                	sd	s9,40(sp)
 512:	f06a                	sd	s10,32(sp)
 514:	ec6e                	sd	s11,24(sp)
 516:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 518:	0005c903          	lbu	s2,0(a1)
 51c:	18090f63          	beqz	s2,6ba <vprintf+0x1c0>
 520:	8aaa                	mv	s5,a0
 522:	8b32                	mv	s6,a2
 524:	00158493          	addi	s1,a1,1
  state = 0;
 528:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 52a:	02500a13          	li	s4,37
      if(c == 'd'){
 52e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 532:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 536:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 53a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 53e:	00000b97          	auipc	s7,0x0
 542:	3bab8b93          	addi	s7,s7,954 # 8f8 <digits>
 546:	a839                	j	564 <vprintf+0x6a>
        putc(fd, c);
 548:	85ca                	mv	a1,s2
 54a:	8556                	mv	a0,s5
 54c:	00000097          	auipc	ra,0x0
 550:	ee2080e7          	jalr	-286(ra) # 42e <putc>
 554:	a019                	j	55a <vprintf+0x60>
    } else if(state == '%'){
 556:	01498f63          	beq	s3,s4,574 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 55a:	0485                	addi	s1,s1,1
 55c:	fff4c903          	lbu	s2,-1(s1)
 560:	14090d63          	beqz	s2,6ba <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 564:	0009079b          	sext.w	a5,s2
    if(state == 0){
 568:	fe0997e3          	bnez	s3,556 <vprintf+0x5c>
      if(c == '%'){
 56c:	fd479ee3          	bne	a5,s4,548 <vprintf+0x4e>
        state = '%';
 570:	89be                	mv	s3,a5
 572:	b7e5                	j	55a <vprintf+0x60>
      if(c == 'd'){
 574:	05878063          	beq	a5,s8,5b4 <vprintf+0xba>
      } else if(c == 'l') {
 578:	05978c63          	beq	a5,s9,5d0 <vprintf+0xd6>
      } else if(c == 'x') {
 57c:	07a78863          	beq	a5,s10,5ec <vprintf+0xf2>
      } else if(c == 'p') {
 580:	09b78463          	beq	a5,s11,608 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 584:	07300713          	li	a4,115
 588:	0ce78663          	beq	a5,a4,654 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 58c:	06300713          	li	a4,99
 590:	0ee78e63          	beq	a5,a4,68c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 594:	11478863          	beq	a5,s4,6a4 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 598:	85d2                	mv	a1,s4
 59a:	8556                	mv	a0,s5
 59c:	00000097          	auipc	ra,0x0
 5a0:	e92080e7          	jalr	-366(ra) # 42e <putc>
        putc(fd, c);
 5a4:	85ca                	mv	a1,s2
 5a6:	8556                	mv	a0,s5
 5a8:	00000097          	auipc	ra,0x0
 5ac:	e86080e7          	jalr	-378(ra) # 42e <putc>
      }
      state = 0;
 5b0:	4981                	li	s3,0
 5b2:	b765                	j	55a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5b4:	008b0913          	addi	s2,s6,8
 5b8:	4685                	li	a3,1
 5ba:	4629                	li	a2,10
 5bc:	000b2583          	lw	a1,0(s6)
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	e8e080e7          	jalr	-370(ra) # 450 <printint>
 5ca:	8b4a                	mv	s6,s2
      state = 0;
 5cc:	4981                	li	s3,0
 5ce:	b771                	j	55a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d0:	008b0913          	addi	s2,s6,8
 5d4:	4681                	li	a3,0
 5d6:	4629                	li	a2,10
 5d8:	000b2583          	lw	a1,0(s6)
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	e72080e7          	jalr	-398(ra) # 450 <printint>
 5e6:	8b4a                	mv	s6,s2
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	bf85                	j	55a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5ec:	008b0913          	addi	s2,s6,8
 5f0:	4681                	li	a3,0
 5f2:	4641                	li	a2,16
 5f4:	000b2583          	lw	a1,0(s6)
 5f8:	8556                	mv	a0,s5
 5fa:	00000097          	auipc	ra,0x0
 5fe:	e56080e7          	jalr	-426(ra) # 450 <printint>
 602:	8b4a                	mv	s6,s2
      state = 0;
 604:	4981                	li	s3,0
 606:	bf91                	j	55a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 608:	008b0793          	addi	a5,s6,8
 60c:	f8f43423          	sd	a5,-120(s0)
 610:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 614:	03000593          	li	a1,48
 618:	8556                	mv	a0,s5
 61a:	00000097          	auipc	ra,0x0
 61e:	e14080e7          	jalr	-492(ra) # 42e <putc>
  putc(fd, 'x');
 622:	85ea                	mv	a1,s10
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	e08080e7          	jalr	-504(ra) # 42e <putc>
 62e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 630:	03c9d793          	srli	a5,s3,0x3c
 634:	97de                	add	a5,a5,s7
 636:	0007c583          	lbu	a1,0(a5)
 63a:	8556                	mv	a0,s5
 63c:	00000097          	auipc	ra,0x0
 640:	df2080e7          	jalr	-526(ra) # 42e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 644:	0992                	slli	s3,s3,0x4
 646:	397d                	addiw	s2,s2,-1
 648:	fe0914e3          	bnez	s2,630 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 64c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 650:	4981                	li	s3,0
 652:	b721                	j	55a <vprintf+0x60>
        s = va_arg(ap, char*);
 654:	008b0993          	addi	s3,s6,8
 658:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 65c:	02090163          	beqz	s2,67e <vprintf+0x184>
        while(*s != 0){
 660:	00094583          	lbu	a1,0(s2)
 664:	c9a1                	beqz	a1,6b4 <vprintf+0x1ba>
          putc(fd, *s);
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	dc6080e7          	jalr	-570(ra) # 42e <putc>
          s++;
 670:	0905                	addi	s2,s2,1
        while(*s != 0){
 672:	00094583          	lbu	a1,0(s2)
 676:	f9e5                	bnez	a1,666 <vprintf+0x16c>
        s = va_arg(ap, char*);
 678:	8b4e                	mv	s6,s3
      state = 0;
 67a:	4981                	li	s3,0
 67c:	bdf9                	j	55a <vprintf+0x60>
          s = "(null)";
 67e:	00000917          	auipc	s2,0x0
 682:	27290913          	addi	s2,s2,626 # 8f0 <malloc+0x12c>
        while(*s != 0){
 686:	02800593          	li	a1,40
 68a:	bff1                	j	666 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 68c:	008b0913          	addi	s2,s6,8
 690:	000b4583          	lbu	a1,0(s6)
 694:	8556                	mv	a0,s5
 696:	00000097          	auipc	ra,0x0
 69a:	d98080e7          	jalr	-616(ra) # 42e <putc>
 69e:	8b4a                	mv	s6,s2
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	bd65                	j	55a <vprintf+0x60>
        putc(fd, c);
 6a4:	85d2                	mv	a1,s4
 6a6:	8556                	mv	a0,s5
 6a8:	00000097          	auipc	ra,0x0
 6ac:	d86080e7          	jalr	-634(ra) # 42e <putc>
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	b565                	j	55a <vprintf+0x60>
        s = va_arg(ap, char*);
 6b4:	8b4e                	mv	s6,s3
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b54d                	j	55a <vprintf+0x60>
    }
  }
}
 6ba:	70e6                	ld	ra,120(sp)
 6bc:	7446                	ld	s0,112(sp)
 6be:	74a6                	ld	s1,104(sp)
 6c0:	7906                	ld	s2,96(sp)
 6c2:	69e6                	ld	s3,88(sp)
 6c4:	6a46                	ld	s4,80(sp)
 6c6:	6aa6                	ld	s5,72(sp)
 6c8:	6b06                	ld	s6,64(sp)
 6ca:	7be2                	ld	s7,56(sp)
 6cc:	7c42                	ld	s8,48(sp)
 6ce:	7ca2                	ld	s9,40(sp)
 6d0:	7d02                	ld	s10,32(sp)
 6d2:	6de2                	ld	s11,24(sp)
 6d4:	6109                	addi	sp,sp,128
 6d6:	8082                	ret

00000000000006d8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6d8:	715d                	addi	sp,sp,-80
 6da:	ec06                	sd	ra,24(sp)
 6dc:	e822                	sd	s0,16(sp)
 6de:	1000                	addi	s0,sp,32
 6e0:	e010                	sd	a2,0(s0)
 6e2:	e414                	sd	a3,8(s0)
 6e4:	e818                	sd	a4,16(s0)
 6e6:	ec1c                	sd	a5,24(s0)
 6e8:	03043023          	sd	a6,32(s0)
 6ec:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6f0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6f4:	8622                	mv	a2,s0
 6f6:	00000097          	auipc	ra,0x0
 6fa:	e04080e7          	jalr	-508(ra) # 4fa <vprintf>
}
 6fe:	60e2                	ld	ra,24(sp)
 700:	6442                	ld	s0,16(sp)
 702:	6161                	addi	sp,sp,80
 704:	8082                	ret

0000000000000706 <printf>:

void
printf(const char *fmt, ...)
{
 706:	711d                	addi	sp,sp,-96
 708:	ec06                	sd	ra,24(sp)
 70a:	e822                	sd	s0,16(sp)
 70c:	1000                	addi	s0,sp,32
 70e:	e40c                	sd	a1,8(s0)
 710:	e810                	sd	a2,16(s0)
 712:	ec14                	sd	a3,24(s0)
 714:	f018                	sd	a4,32(s0)
 716:	f41c                	sd	a5,40(s0)
 718:	03043823          	sd	a6,48(s0)
 71c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 720:	00840613          	addi	a2,s0,8
 724:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 728:	85aa                	mv	a1,a0
 72a:	4505                	li	a0,1
 72c:	00000097          	auipc	ra,0x0
 730:	dce080e7          	jalr	-562(ra) # 4fa <vprintf>
}
 734:	60e2                	ld	ra,24(sp)
 736:	6442                	ld	s0,16(sp)
 738:	6125                	addi	sp,sp,96
 73a:	8082                	ret

000000000000073c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 73c:	1141                	addi	sp,sp,-16
 73e:	e422                	sd	s0,8(sp)
 740:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 742:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 746:	00000797          	auipc	a5,0x0
 74a:	1ca7b783          	ld	a5,458(a5) # 910 <freep>
 74e:	a805                	j	77e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 750:	4618                	lw	a4,8(a2)
 752:	9db9                	addw	a1,a1,a4
 754:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 758:	6398                	ld	a4,0(a5)
 75a:	6318                	ld	a4,0(a4)
 75c:	fee53823          	sd	a4,-16(a0)
 760:	a091                	j	7a4 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 762:	ff852703          	lw	a4,-8(a0)
 766:	9e39                	addw	a2,a2,a4
 768:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 76a:	ff053703          	ld	a4,-16(a0)
 76e:	e398                	sd	a4,0(a5)
 770:	a099                	j	7b6 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 772:	6398                	ld	a4,0(a5)
 774:	00e7e463          	bltu	a5,a4,77c <free+0x40>
 778:	00e6ea63          	bltu	a3,a4,78c <free+0x50>
{
 77c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77e:	fed7fae3          	bgeu	a5,a3,772 <free+0x36>
 782:	6398                	ld	a4,0(a5)
 784:	00e6e463          	bltu	a3,a4,78c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 788:	fee7eae3          	bltu	a5,a4,77c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 78c:	ff852583          	lw	a1,-8(a0)
 790:	6390                	ld	a2,0(a5)
 792:	02059713          	slli	a4,a1,0x20
 796:	9301                	srli	a4,a4,0x20
 798:	0712                	slli	a4,a4,0x4
 79a:	9736                	add	a4,a4,a3
 79c:	fae60ae3          	beq	a2,a4,750 <free+0x14>
    bp->s.ptr = p->s.ptr;
 7a0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7a4:	4790                	lw	a2,8(a5)
 7a6:	02061713          	slli	a4,a2,0x20
 7aa:	9301                	srli	a4,a4,0x20
 7ac:	0712                	slli	a4,a4,0x4
 7ae:	973e                	add	a4,a4,a5
 7b0:	fae689e3          	beq	a3,a4,762 <free+0x26>
  } else
    p->s.ptr = bp;
 7b4:	e394                	sd	a3,0(a5)
  freep = p;
 7b6:	00000717          	auipc	a4,0x0
 7ba:	14f73d23          	sd	a5,346(a4) # 910 <freep>
}
 7be:	6422                	ld	s0,8(sp)
 7c0:	0141                	addi	sp,sp,16
 7c2:	8082                	ret

00000000000007c4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c4:	7139                	addi	sp,sp,-64
 7c6:	fc06                	sd	ra,56(sp)
 7c8:	f822                	sd	s0,48(sp)
 7ca:	f426                	sd	s1,40(sp)
 7cc:	f04a                	sd	s2,32(sp)
 7ce:	ec4e                	sd	s3,24(sp)
 7d0:	e852                	sd	s4,16(sp)
 7d2:	e456                	sd	s5,8(sp)
 7d4:	e05a                	sd	s6,0(sp)
 7d6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d8:	02051493          	slli	s1,a0,0x20
 7dc:	9081                	srli	s1,s1,0x20
 7de:	04bd                	addi	s1,s1,15
 7e0:	8091                	srli	s1,s1,0x4
 7e2:	0014899b          	addiw	s3,s1,1
 7e6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7e8:	00000517          	auipc	a0,0x0
 7ec:	12853503          	ld	a0,296(a0) # 910 <freep>
 7f0:	c515                	beqz	a0,81c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7f4:	4798                	lw	a4,8(a5)
 7f6:	02977f63          	bgeu	a4,s1,834 <malloc+0x70>
 7fa:	8a4e                	mv	s4,s3
 7fc:	0009871b          	sext.w	a4,s3
 800:	6685                	lui	a3,0x1
 802:	00d77363          	bgeu	a4,a3,808 <malloc+0x44>
 806:	6a05                	lui	s4,0x1
 808:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 80c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 810:	00000917          	auipc	s2,0x0
 814:	10090913          	addi	s2,s2,256 # 910 <freep>
  if(p == (char*)-1)
 818:	5afd                	li	s5,-1
 81a:	a88d                	j	88c <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 81c:	00000797          	auipc	a5,0x0
 820:	0fc78793          	addi	a5,a5,252 # 918 <base>
 824:	00000717          	auipc	a4,0x0
 828:	0ef73623          	sd	a5,236(a4) # 910 <freep>
 82c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 82e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 832:	b7e1                	j	7fa <malloc+0x36>
      if(p->s.size == nunits)
 834:	02e48b63          	beq	s1,a4,86a <malloc+0xa6>
        p->s.size -= nunits;
 838:	4137073b          	subw	a4,a4,s3
 83c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 83e:	1702                	slli	a4,a4,0x20
 840:	9301                	srli	a4,a4,0x20
 842:	0712                	slli	a4,a4,0x4
 844:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 846:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 84a:	00000717          	auipc	a4,0x0
 84e:	0ca73323          	sd	a0,198(a4) # 910 <freep>
      return (void*)(p + 1);
 852:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 856:	70e2                	ld	ra,56(sp)
 858:	7442                	ld	s0,48(sp)
 85a:	74a2                	ld	s1,40(sp)
 85c:	7902                	ld	s2,32(sp)
 85e:	69e2                	ld	s3,24(sp)
 860:	6a42                	ld	s4,16(sp)
 862:	6aa2                	ld	s5,8(sp)
 864:	6b02                	ld	s6,0(sp)
 866:	6121                	addi	sp,sp,64
 868:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 86a:	6398                	ld	a4,0(a5)
 86c:	e118                	sd	a4,0(a0)
 86e:	bff1                	j	84a <malloc+0x86>
  hp->s.size = nu;
 870:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 874:	0541                	addi	a0,a0,16
 876:	00000097          	auipc	ra,0x0
 87a:	ec6080e7          	jalr	-314(ra) # 73c <free>
  return freep;
 87e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 882:	d971                	beqz	a0,856 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 884:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 886:	4798                	lw	a4,8(a5)
 888:	fa9776e3          	bgeu	a4,s1,834 <malloc+0x70>
    if(p == freep)
 88c:	00093703          	ld	a4,0(s2)
 890:	853e                	mv	a0,a5
 892:	fef719e3          	bne	a4,a5,884 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 896:	8552                	mv	a0,s4
 898:	00000097          	auipc	ra,0x0
 89c:	b7e080e7          	jalr	-1154(ra) # 416 <sbrk>
  if(p == (char*)-1)
 8a0:	fd5518e3          	bne	a0,s5,870 <malloc+0xac>
        return 0;
 8a4:	4501                	li	a0,0
 8a6:	bf45                	j	856 <malloc+0x92>
