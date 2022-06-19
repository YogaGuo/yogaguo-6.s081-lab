
user/_primer:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <help>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void help(int left_pipe[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	0080                	addi	s0,sp,64
   c:	84aa                	mv	s1,a0
    int num;
    read(left_pipe[0], &num, sizeof(num));
   e:	4611                	li	a2,4
  10:	fdc40593          	addi	a1,s0,-36
  14:	4108                	lw	a0,0(a0)
  16:	00000097          	auipc	ra,0x0
  1a:	454080e7          	jalr	1108(ra) # 46a <read>
    if (num == -1)
  1e:	fdc42703          	lw	a4,-36(s0)
  22:	57fd                	li	a5,-1
  24:	06f70063          	beq	a4,a5,84 <help+0x84>
        exit(0);
    printf("<pid: %d> primer: %d\n", getpid(), num);
  28:	00000097          	auipc	ra,0x0
  2c:	4aa080e7          	jalr	1194(ra) # 4d2 <getpid>
  30:	85aa                	mv	a1,a0
  32:	fdc42603          	lw	a2,-36(s0)
  36:	00001517          	auipc	a0,0x1
  3a:	93a50513          	addi	a0,a0,-1734 # 970 <malloc+0xe8>
  3e:	00000097          	auipc	ra,0x0
  42:	78c080e7          	jalr	1932(ra) # 7ca <printf>

    int right_pipe[2];
    pipe(right_pipe);
  46:	fd040513          	addi	a0,s0,-48
  4a:	00000097          	auipc	ra,0x0
  4e:	418080e7          	jalr	1048(ra) # 462 <pipe>
    int pid = fork();
  52:	00000097          	auipc	ra,0x0
  56:	3f8080e7          	jalr	1016(ra) # 44a <fork>
    if (pid < 0)
  5a:	02054a63          	bltz	a0,8e <help+0x8e>
    {
        fprintf(2, "fork() error!\n");
        exit(1);
    }
    else if (pid == 0)
  5e:	e531                	bnez	a0,aa <help+0xaa>
    {
        close(right_pipe[1]);
  60:	fd442503          	lw	a0,-44(s0)
  64:	00000097          	auipc	ra,0x0
  68:	416080e7          	jalr	1046(ra) # 47a <close>
        help(right_pipe);
  6c:	fd040513          	addi	a0,s0,-48
  70:	00000097          	auipc	ra,0x0
  74:	f90080e7          	jalr	-112(ra) # 0 <help>
        buf = -1;
        write(right_pipe[1], &buf, sizeof(buf));
        wait((int *)0);
        exit(0);
    }
}
  78:	70e2                	ld	ra,56(sp)
  7a:	7442                	ld	s0,48(sp)
  7c:	74a2                	ld	s1,40(sp)
  7e:	7902                	ld	s2,32(sp)
  80:	6121                	addi	sp,sp,64
  82:	8082                	ret
        exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	3cc080e7          	jalr	972(ra) # 452 <exit>
        fprintf(2, "fork() error!\n");
  8e:	00001597          	auipc	a1,0x1
  92:	8fa58593          	addi	a1,a1,-1798 # 988 <malloc+0x100>
  96:	4509                	li	a0,2
  98:	00000097          	auipc	ra,0x0
  9c:	704080e7          	jalr	1796(ra) # 79c <fprintf>
        exit(1);
  a0:	4505                	li	a0,1
  a2:	00000097          	auipc	ra,0x0
  a6:	3b0080e7          	jalr	944(ra) # 452 <exit>
        close(right_pipe[0]);
  aa:	fd042503          	lw	a0,-48(s0)
  ae:	00000097          	auipc	ra,0x0
  b2:	3cc080e7          	jalr	972(ra) # 47a <close>
        while (read(left_pipe[0], &buf, sizeof(buf)) != 0 && buf != -1)
  b6:	597d                	li	s2,-1
  b8:	4611                	li	a2,4
  ba:	fcc40593          	addi	a1,s0,-52
  be:	4088                	lw	a0,0(s1)
  c0:	00000097          	auipc	ra,0x0
  c4:	3aa080e7          	jalr	938(ra) # 46a <read>
  c8:	c505                	beqz	a0,f0 <help+0xf0>
  ca:	fcc42783          	lw	a5,-52(s0)
  ce:	03278163          	beq	a5,s2,f0 <help+0xf0>
            if (buf % num != 0)
  d2:	fdc42703          	lw	a4,-36(s0)
  d6:	02e7e7bb          	remw	a5,a5,a4
  da:	dff9                	beqz	a5,b8 <help+0xb8>
                write(right_pipe[1], &buf, sizeof(buf));
  dc:	4611                	li	a2,4
  de:	fcc40593          	addi	a1,s0,-52
  e2:	fd442503          	lw	a0,-44(s0)
  e6:	00000097          	auipc	ra,0x0
  ea:	38c080e7          	jalr	908(ra) # 472 <write>
  ee:	b7e9                	j	b8 <help+0xb8>
        buf = -1;
  f0:	57fd                	li	a5,-1
  f2:	fcf42623          	sw	a5,-52(s0)
        write(right_pipe[1], &buf, sizeof(buf));
  f6:	4611                	li	a2,4
  f8:	fcc40593          	addi	a1,s0,-52
  fc:	fd442503          	lw	a0,-44(s0)
 100:	00000097          	auipc	ra,0x0
 104:	372080e7          	jalr	882(ra) # 472 <write>
        wait((int *)0);
 108:	4501                	li	a0,0
 10a:	00000097          	auipc	ra,0x0
 10e:	350080e7          	jalr	848(ra) # 45a <wait>
        exit(0);
 112:	4501                	li	a0,0
 114:	00000097          	auipc	ra,0x0
 118:	33e080e7          	jalr	830(ra) # 452 <exit>

000000000000011c <main>:
int main(int argc, char *argv[])
{
 11c:	7179                	addi	sp,sp,-48
 11e:	f406                	sd	ra,40(sp)
 120:	f022                	sd	s0,32(sp)
 122:	ec26                	sd	s1,24(sp)
 124:	1800                	addi	s0,sp,48

    int left_pipe[2];

    pipe(left_pipe);
 126:	fd840513          	addi	a0,s0,-40
 12a:	00000097          	auipc	ra,0x0
 12e:	338080e7          	jalr	824(ra) # 462 <pipe>

    int pid = fork();
 132:	00000097          	auipc	ra,0x0
 136:	318080e7          	jalr	792(ra) # 44a <fork>
    if (pid < 0)
 13a:	02054063          	bltz	a0,15a <main+0x3e>
    {
        fprintf(2, "fork() error!\n");
        exit(1);
    }
    else if (pid == 0)
 13e:	ed05                	bnez	a0,176 <main+0x5a>
    {
        close(left_pipe[1]);
 140:	fdc42503          	lw	a0,-36(s0)
 144:	00000097          	auipc	ra,0x0
 148:	336080e7          	jalr	822(ra) # 47a <close>
        help(left_pipe);
 14c:	fd840513          	addi	a0,s0,-40
 150:	00000097          	auipc	ra,0x0
 154:	eb0080e7          	jalr	-336(ra) # 0 <help>
 158:	a8ad                	j	1d2 <main+0xb6>
        fprintf(2, "fork() error!\n");
 15a:	00001597          	auipc	a1,0x1
 15e:	82e58593          	addi	a1,a1,-2002 # 988 <malloc+0x100>
 162:	4509                	li	a0,2
 164:	00000097          	auipc	ra,0x0
 168:	638080e7          	jalr	1592(ra) # 79c <fprintf>
        exit(1);
 16c:	4505                	li	a0,1
 16e:	00000097          	auipc	ra,0x0
 172:	2e4080e7          	jalr	740(ra) # 452 <exit>
    }
    else
    {
        close(left_pipe[0]);
 176:	fd842503          	lw	a0,-40(s0)
 17a:	00000097          	auipc	ra,0x0
 17e:	300080e7          	jalr	768(ra) # 47a <close>
        for (int i = 2; i <= 35; i++)
 182:	4789                	li	a5,2
 184:	fcf42a23          	sw	a5,-44(s0)
 188:	02300493          	li	s1,35
        {
            write(left_pipe[1], &i, sizeof(i));
 18c:	4611                	li	a2,4
 18e:	fd440593          	addi	a1,s0,-44
 192:	fdc42503          	lw	a0,-36(s0)
 196:	00000097          	auipc	ra,0x0
 19a:	2dc080e7          	jalr	732(ra) # 472 <write>
        for (int i = 2; i <= 35; i++)
 19e:	fd442783          	lw	a5,-44(s0)
 1a2:	2785                	addiw	a5,a5,1
 1a4:	0007871b          	sext.w	a4,a5
 1a8:	fcf42a23          	sw	a5,-44(s0)
 1ac:	fee4d0e3          	bge	s1,a4,18c <main+0x70>
        }
        int flag = -1;
 1b0:	57fd                	li	a5,-1
 1b2:	fcf42a23          	sw	a5,-44(s0)
        write(left_pipe[1], &flag, sizeof(flag));
 1b6:	4611                	li	a2,4
 1b8:	fd440593          	addi	a1,s0,-44
 1bc:	fdc42503          	lw	a0,-36(s0)
 1c0:	00000097          	auipc	ra,0x0
 1c4:	2b2080e7          	jalr	690(ra) # 472 <write>
        wait((int *)0);
 1c8:	4501                	li	a0,0
 1ca:	00000097          	auipc	ra,0x0
 1ce:	290080e7          	jalr	656(ra) # 45a <wait>
    }
    exit(0);
 1d2:	4501                	li	a0,0
 1d4:	00000097          	auipc	ra,0x0
 1d8:	27e080e7          	jalr	638(ra) # 452 <exit>

00000000000001dc <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1dc:	1141                	addi	sp,sp,-16
 1de:	e422                	sd	s0,8(sp)
 1e0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1e2:	87aa                	mv	a5,a0
 1e4:	0585                	addi	a1,a1,1
 1e6:	0785                	addi	a5,a5,1
 1e8:	fff5c703          	lbu	a4,-1(a1)
 1ec:	fee78fa3          	sb	a4,-1(a5)
 1f0:	fb75                	bnez	a4,1e4 <strcpy+0x8>
    ;
  return os;
}
 1f2:	6422                	ld	s0,8(sp)
 1f4:	0141                	addi	sp,sp,16
 1f6:	8082                	ret

00000000000001f8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f8:	1141                	addi	sp,sp,-16
 1fa:	e422                	sd	s0,8(sp)
 1fc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1fe:	00054783          	lbu	a5,0(a0)
 202:	cb91                	beqz	a5,216 <strcmp+0x1e>
 204:	0005c703          	lbu	a4,0(a1)
 208:	00f71763          	bne	a4,a5,216 <strcmp+0x1e>
    p++, q++;
 20c:	0505                	addi	a0,a0,1
 20e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 210:	00054783          	lbu	a5,0(a0)
 214:	fbe5                	bnez	a5,204 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 216:	0005c503          	lbu	a0,0(a1)
}
 21a:	40a7853b          	subw	a0,a5,a0
 21e:	6422                	ld	s0,8(sp)
 220:	0141                	addi	sp,sp,16
 222:	8082                	ret

0000000000000224 <strlen>:

uint
strlen(const char *s)
{
 224:	1141                	addi	sp,sp,-16
 226:	e422                	sd	s0,8(sp)
 228:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 22a:	00054783          	lbu	a5,0(a0)
 22e:	cf91                	beqz	a5,24a <strlen+0x26>
 230:	0505                	addi	a0,a0,1
 232:	87aa                	mv	a5,a0
 234:	4685                	li	a3,1
 236:	9e89                	subw	a3,a3,a0
 238:	00f6853b          	addw	a0,a3,a5
 23c:	0785                	addi	a5,a5,1
 23e:	fff7c703          	lbu	a4,-1(a5)
 242:	fb7d                	bnez	a4,238 <strlen+0x14>
    ;
  return n;
}
 244:	6422                	ld	s0,8(sp)
 246:	0141                	addi	sp,sp,16
 248:	8082                	ret
  for(n = 0; s[n]; n++)
 24a:	4501                	li	a0,0
 24c:	bfe5                	j	244 <strlen+0x20>

000000000000024e <memset>:

void*
memset(void *dst, int c, uint n)
{
 24e:	1141                	addi	sp,sp,-16
 250:	e422                	sd	s0,8(sp)
 252:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 254:	ce09                	beqz	a2,26e <memset+0x20>
 256:	87aa                	mv	a5,a0
 258:	fff6071b          	addiw	a4,a2,-1
 25c:	1702                	slli	a4,a4,0x20
 25e:	9301                	srli	a4,a4,0x20
 260:	0705                	addi	a4,a4,1
 262:	972a                	add	a4,a4,a0
    cdst[i] = c;
 264:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 268:	0785                	addi	a5,a5,1
 26a:	fee79de3          	bne	a5,a4,264 <memset+0x16>
  }
  return dst;
}
 26e:	6422                	ld	s0,8(sp)
 270:	0141                	addi	sp,sp,16
 272:	8082                	ret

0000000000000274 <strchr>:

char*
strchr(const char *s, char c)
{
 274:	1141                	addi	sp,sp,-16
 276:	e422                	sd	s0,8(sp)
 278:	0800                	addi	s0,sp,16
  for(; *s; s++)
 27a:	00054783          	lbu	a5,0(a0)
 27e:	cb99                	beqz	a5,294 <strchr+0x20>
    if(*s == c)
 280:	00f58763          	beq	a1,a5,28e <strchr+0x1a>
  for(; *s; s++)
 284:	0505                	addi	a0,a0,1
 286:	00054783          	lbu	a5,0(a0)
 28a:	fbfd                	bnez	a5,280 <strchr+0xc>
      return (char*)s;
  return 0;
 28c:	4501                	li	a0,0
}
 28e:	6422                	ld	s0,8(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret
  return 0;
 294:	4501                	li	a0,0
 296:	bfe5                	j	28e <strchr+0x1a>

0000000000000298 <gets>:

char*
gets(char *buf, int max)
{
 298:	711d                	addi	sp,sp,-96
 29a:	ec86                	sd	ra,88(sp)
 29c:	e8a2                	sd	s0,80(sp)
 29e:	e4a6                	sd	s1,72(sp)
 2a0:	e0ca                	sd	s2,64(sp)
 2a2:	fc4e                	sd	s3,56(sp)
 2a4:	f852                	sd	s4,48(sp)
 2a6:	f456                	sd	s5,40(sp)
 2a8:	f05a                	sd	s6,32(sp)
 2aa:	ec5e                	sd	s7,24(sp)
 2ac:	1080                	addi	s0,sp,96
 2ae:	8baa                	mv	s7,a0
 2b0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b2:	892a                	mv	s2,a0
 2b4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2b6:	4aa9                	li	s5,10
 2b8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2ba:	89a6                	mv	s3,s1
 2bc:	2485                	addiw	s1,s1,1
 2be:	0344d863          	bge	s1,s4,2ee <gets+0x56>
    cc = read(0, &c, 1);
 2c2:	4605                	li	a2,1
 2c4:	faf40593          	addi	a1,s0,-81
 2c8:	4501                	li	a0,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	1a0080e7          	jalr	416(ra) # 46a <read>
    if(cc < 1)
 2d2:	00a05e63          	blez	a0,2ee <gets+0x56>
    buf[i++] = c;
 2d6:	faf44783          	lbu	a5,-81(s0)
 2da:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2de:	01578763          	beq	a5,s5,2ec <gets+0x54>
 2e2:	0905                	addi	s2,s2,1
 2e4:	fd679be3          	bne	a5,s6,2ba <gets+0x22>
  for(i=0; i+1 < max; ){
 2e8:	89a6                	mv	s3,s1
 2ea:	a011                	j	2ee <gets+0x56>
 2ec:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2ee:	99de                	add	s3,s3,s7
 2f0:	00098023          	sb	zero,0(s3)
  return buf;
}
 2f4:	855e                	mv	a0,s7
 2f6:	60e6                	ld	ra,88(sp)
 2f8:	6446                	ld	s0,80(sp)
 2fa:	64a6                	ld	s1,72(sp)
 2fc:	6906                	ld	s2,64(sp)
 2fe:	79e2                	ld	s3,56(sp)
 300:	7a42                	ld	s4,48(sp)
 302:	7aa2                	ld	s5,40(sp)
 304:	7b02                	ld	s6,32(sp)
 306:	6be2                	ld	s7,24(sp)
 308:	6125                	addi	sp,sp,96
 30a:	8082                	ret

000000000000030c <stat>:

int
stat(const char *n, struct stat *st)
{
 30c:	1101                	addi	sp,sp,-32
 30e:	ec06                	sd	ra,24(sp)
 310:	e822                	sd	s0,16(sp)
 312:	e426                	sd	s1,8(sp)
 314:	e04a                	sd	s2,0(sp)
 316:	1000                	addi	s0,sp,32
 318:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 31a:	4581                	li	a1,0
 31c:	00000097          	auipc	ra,0x0
 320:	176080e7          	jalr	374(ra) # 492 <open>
  if(fd < 0)
 324:	02054563          	bltz	a0,34e <stat+0x42>
 328:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 32a:	85ca                	mv	a1,s2
 32c:	00000097          	auipc	ra,0x0
 330:	17e080e7          	jalr	382(ra) # 4aa <fstat>
 334:	892a                	mv	s2,a0
  close(fd);
 336:	8526                	mv	a0,s1
 338:	00000097          	auipc	ra,0x0
 33c:	142080e7          	jalr	322(ra) # 47a <close>
  return r;
}
 340:	854a                	mv	a0,s2
 342:	60e2                	ld	ra,24(sp)
 344:	6442                	ld	s0,16(sp)
 346:	64a2                	ld	s1,8(sp)
 348:	6902                	ld	s2,0(sp)
 34a:	6105                	addi	sp,sp,32
 34c:	8082                	ret
    return -1;
 34e:	597d                	li	s2,-1
 350:	bfc5                	j	340 <stat+0x34>

0000000000000352 <atoi>:

int
atoi(const char *s)
{
 352:	1141                	addi	sp,sp,-16
 354:	e422                	sd	s0,8(sp)
 356:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 358:	00054603          	lbu	a2,0(a0)
 35c:	fd06079b          	addiw	a5,a2,-48
 360:	0ff7f793          	andi	a5,a5,255
 364:	4725                	li	a4,9
 366:	02f76963          	bltu	a4,a5,398 <atoi+0x46>
 36a:	86aa                	mv	a3,a0
  n = 0;
 36c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 36e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 370:	0685                	addi	a3,a3,1
 372:	0025179b          	slliw	a5,a0,0x2
 376:	9fa9                	addw	a5,a5,a0
 378:	0017979b          	slliw	a5,a5,0x1
 37c:	9fb1                	addw	a5,a5,a2
 37e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 382:	0006c603          	lbu	a2,0(a3)
 386:	fd06071b          	addiw	a4,a2,-48
 38a:	0ff77713          	andi	a4,a4,255
 38e:	fee5f1e3          	bgeu	a1,a4,370 <atoi+0x1e>
  return n;
}
 392:	6422                	ld	s0,8(sp)
 394:	0141                	addi	sp,sp,16
 396:	8082                	ret
  n = 0;
 398:	4501                	li	a0,0
 39a:	bfe5                	j	392 <atoi+0x40>

000000000000039c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 39c:	1141                	addi	sp,sp,-16
 39e:	e422                	sd	s0,8(sp)
 3a0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3a2:	02b57663          	bgeu	a0,a1,3ce <memmove+0x32>
    while(n-- > 0)
 3a6:	02c05163          	blez	a2,3c8 <memmove+0x2c>
 3aa:	fff6079b          	addiw	a5,a2,-1
 3ae:	1782                	slli	a5,a5,0x20
 3b0:	9381                	srli	a5,a5,0x20
 3b2:	0785                	addi	a5,a5,1
 3b4:	97aa                	add	a5,a5,a0
  dst = vdst;
 3b6:	872a                	mv	a4,a0
      *dst++ = *src++;
 3b8:	0585                	addi	a1,a1,1
 3ba:	0705                	addi	a4,a4,1
 3bc:	fff5c683          	lbu	a3,-1(a1)
 3c0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3c4:	fee79ae3          	bne	a5,a4,3b8 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3c8:	6422                	ld	s0,8(sp)
 3ca:	0141                	addi	sp,sp,16
 3cc:	8082                	ret
    dst += n;
 3ce:	00c50733          	add	a4,a0,a2
    src += n;
 3d2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3d4:	fec05ae3          	blez	a2,3c8 <memmove+0x2c>
 3d8:	fff6079b          	addiw	a5,a2,-1
 3dc:	1782                	slli	a5,a5,0x20
 3de:	9381                	srli	a5,a5,0x20
 3e0:	fff7c793          	not	a5,a5
 3e4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3e6:	15fd                	addi	a1,a1,-1
 3e8:	177d                	addi	a4,a4,-1
 3ea:	0005c683          	lbu	a3,0(a1)
 3ee:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3f2:	fee79ae3          	bne	a5,a4,3e6 <memmove+0x4a>
 3f6:	bfc9                	j	3c8 <memmove+0x2c>

00000000000003f8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3f8:	1141                	addi	sp,sp,-16
 3fa:	e422                	sd	s0,8(sp)
 3fc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3fe:	ca05                	beqz	a2,42e <memcmp+0x36>
 400:	fff6069b          	addiw	a3,a2,-1
 404:	1682                	slli	a3,a3,0x20
 406:	9281                	srli	a3,a3,0x20
 408:	0685                	addi	a3,a3,1
 40a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 40c:	00054783          	lbu	a5,0(a0)
 410:	0005c703          	lbu	a4,0(a1)
 414:	00e79863          	bne	a5,a4,424 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 418:	0505                	addi	a0,a0,1
    p2++;
 41a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 41c:	fed518e3          	bne	a0,a3,40c <memcmp+0x14>
  }
  return 0;
 420:	4501                	li	a0,0
 422:	a019                	j	428 <memcmp+0x30>
      return *p1 - *p2;
 424:	40e7853b          	subw	a0,a5,a4
}
 428:	6422                	ld	s0,8(sp)
 42a:	0141                	addi	sp,sp,16
 42c:	8082                	ret
  return 0;
 42e:	4501                	li	a0,0
 430:	bfe5                	j	428 <memcmp+0x30>

0000000000000432 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 432:	1141                	addi	sp,sp,-16
 434:	e406                	sd	ra,8(sp)
 436:	e022                	sd	s0,0(sp)
 438:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 43a:	00000097          	auipc	ra,0x0
 43e:	f62080e7          	jalr	-158(ra) # 39c <memmove>
}
 442:	60a2                	ld	ra,8(sp)
 444:	6402                	ld	s0,0(sp)
 446:	0141                	addi	sp,sp,16
 448:	8082                	ret

000000000000044a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 44a:	4885                	li	a7,1
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <exit>:
.global exit
exit:
 li a7, SYS_exit
 452:	4889                	li	a7,2
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <wait>:
.global wait
wait:
 li a7, SYS_wait
 45a:	488d                	li	a7,3
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 462:	4891                	li	a7,4
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <read>:
.global read
read:
 li a7, SYS_read
 46a:	4895                	li	a7,5
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <write>:
.global write
write:
 li a7, SYS_write
 472:	48c1                	li	a7,16
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <close>:
.global close
close:
 li a7, SYS_close
 47a:	48d5                	li	a7,21
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <kill>:
.global kill
kill:
 li a7, SYS_kill
 482:	4899                	li	a7,6
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <exec>:
.global exec
exec:
 li a7, SYS_exec
 48a:	489d                	li	a7,7
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <open>:
.global open
open:
 li a7, SYS_open
 492:	48bd                	li	a7,15
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 49a:	48c5                	li	a7,17
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4a2:	48c9                	li	a7,18
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4aa:	48a1                	li	a7,8
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <link>:
.global link
link:
 li a7, SYS_link
 4b2:	48cd                	li	a7,19
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ba:	48d1                	li	a7,20
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4c2:	48a5                	li	a7,9
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ca:	48a9                	li	a7,10
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4d2:	48ad                	li	a7,11
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4da:	48b1                	li	a7,12
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4e2:	48b5                	li	a7,13
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4ea:	48b9                	li	a7,14
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4f2:	1101                	addi	sp,sp,-32
 4f4:	ec06                	sd	ra,24(sp)
 4f6:	e822                	sd	s0,16(sp)
 4f8:	1000                	addi	s0,sp,32
 4fa:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4fe:	4605                	li	a2,1
 500:	fef40593          	addi	a1,s0,-17
 504:	00000097          	auipc	ra,0x0
 508:	f6e080e7          	jalr	-146(ra) # 472 <write>
}
 50c:	60e2                	ld	ra,24(sp)
 50e:	6442                	ld	s0,16(sp)
 510:	6105                	addi	sp,sp,32
 512:	8082                	ret

0000000000000514 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 514:	7139                	addi	sp,sp,-64
 516:	fc06                	sd	ra,56(sp)
 518:	f822                	sd	s0,48(sp)
 51a:	f426                	sd	s1,40(sp)
 51c:	f04a                	sd	s2,32(sp)
 51e:	ec4e                	sd	s3,24(sp)
 520:	0080                	addi	s0,sp,64
 522:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 524:	c299                	beqz	a3,52a <printint+0x16>
 526:	0805c863          	bltz	a1,5b6 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 52a:	2581                	sext.w	a1,a1
  neg = 0;
 52c:	4881                	li	a7,0
 52e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 532:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 534:	2601                	sext.w	a2,a2
 536:	00000517          	auipc	a0,0x0
 53a:	46a50513          	addi	a0,a0,1130 # 9a0 <digits>
 53e:	883a                	mv	a6,a4
 540:	2705                	addiw	a4,a4,1
 542:	02c5f7bb          	remuw	a5,a1,a2
 546:	1782                	slli	a5,a5,0x20
 548:	9381                	srli	a5,a5,0x20
 54a:	97aa                	add	a5,a5,a0
 54c:	0007c783          	lbu	a5,0(a5)
 550:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 554:	0005879b          	sext.w	a5,a1
 558:	02c5d5bb          	divuw	a1,a1,a2
 55c:	0685                	addi	a3,a3,1
 55e:	fec7f0e3          	bgeu	a5,a2,53e <printint+0x2a>
  if(neg)
 562:	00088b63          	beqz	a7,578 <printint+0x64>
    buf[i++] = '-';
 566:	fd040793          	addi	a5,s0,-48
 56a:	973e                	add	a4,a4,a5
 56c:	02d00793          	li	a5,45
 570:	fef70823          	sb	a5,-16(a4)
 574:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 578:	02e05863          	blez	a4,5a8 <printint+0x94>
 57c:	fc040793          	addi	a5,s0,-64
 580:	00e78933          	add	s2,a5,a4
 584:	fff78993          	addi	s3,a5,-1
 588:	99ba                	add	s3,s3,a4
 58a:	377d                	addiw	a4,a4,-1
 58c:	1702                	slli	a4,a4,0x20
 58e:	9301                	srli	a4,a4,0x20
 590:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 594:	fff94583          	lbu	a1,-1(s2)
 598:	8526                	mv	a0,s1
 59a:	00000097          	auipc	ra,0x0
 59e:	f58080e7          	jalr	-168(ra) # 4f2 <putc>
  while(--i >= 0)
 5a2:	197d                	addi	s2,s2,-1
 5a4:	ff3918e3          	bne	s2,s3,594 <printint+0x80>
}
 5a8:	70e2                	ld	ra,56(sp)
 5aa:	7442                	ld	s0,48(sp)
 5ac:	74a2                	ld	s1,40(sp)
 5ae:	7902                	ld	s2,32(sp)
 5b0:	69e2                	ld	s3,24(sp)
 5b2:	6121                	addi	sp,sp,64
 5b4:	8082                	ret
    x = -xx;
 5b6:	40b005bb          	negw	a1,a1
    neg = 1;
 5ba:	4885                	li	a7,1
    x = -xx;
 5bc:	bf8d                	j	52e <printint+0x1a>

00000000000005be <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5be:	7119                	addi	sp,sp,-128
 5c0:	fc86                	sd	ra,120(sp)
 5c2:	f8a2                	sd	s0,112(sp)
 5c4:	f4a6                	sd	s1,104(sp)
 5c6:	f0ca                	sd	s2,96(sp)
 5c8:	ecce                	sd	s3,88(sp)
 5ca:	e8d2                	sd	s4,80(sp)
 5cc:	e4d6                	sd	s5,72(sp)
 5ce:	e0da                	sd	s6,64(sp)
 5d0:	fc5e                	sd	s7,56(sp)
 5d2:	f862                	sd	s8,48(sp)
 5d4:	f466                	sd	s9,40(sp)
 5d6:	f06a                	sd	s10,32(sp)
 5d8:	ec6e                	sd	s11,24(sp)
 5da:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5dc:	0005c903          	lbu	s2,0(a1)
 5e0:	18090f63          	beqz	s2,77e <vprintf+0x1c0>
 5e4:	8aaa                	mv	s5,a0
 5e6:	8b32                	mv	s6,a2
 5e8:	00158493          	addi	s1,a1,1
  state = 0;
 5ec:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ee:	02500a13          	li	s4,37
      if(c == 'd'){
 5f2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5f6:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5fa:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5fe:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 602:	00000b97          	auipc	s7,0x0
 606:	39eb8b93          	addi	s7,s7,926 # 9a0 <digits>
 60a:	a839                	j	628 <vprintf+0x6a>
        putc(fd, c);
 60c:	85ca                	mv	a1,s2
 60e:	8556                	mv	a0,s5
 610:	00000097          	auipc	ra,0x0
 614:	ee2080e7          	jalr	-286(ra) # 4f2 <putc>
 618:	a019                	j	61e <vprintf+0x60>
    } else if(state == '%'){
 61a:	01498f63          	beq	s3,s4,638 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 61e:	0485                	addi	s1,s1,1
 620:	fff4c903          	lbu	s2,-1(s1)
 624:	14090d63          	beqz	s2,77e <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 628:	0009079b          	sext.w	a5,s2
    if(state == 0){
 62c:	fe0997e3          	bnez	s3,61a <vprintf+0x5c>
      if(c == '%'){
 630:	fd479ee3          	bne	a5,s4,60c <vprintf+0x4e>
        state = '%';
 634:	89be                	mv	s3,a5
 636:	b7e5                	j	61e <vprintf+0x60>
      if(c == 'd'){
 638:	05878063          	beq	a5,s8,678 <vprintf+0xba>
      } else if(c == 'l') {
 63c:	05978c63          	beq	a5,s9,694 <vprintf+0xd6>
      } else if(c == 'x') {
 640:	07a78863          	beq	a5,s10,6b0 <vprintf+0xf2>
      } else if(c == 'p') {
 644:	09b78463          	beq	a5,s11,6cc <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 648:	07300713          	li	a4,115
 64c:	0ce78663          	beq	a5,a4,718 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 650:	06300713          	li	a4,99
 654:	0ee78e63          	beq	a5,a4,750 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 658:	11478863          	beq	a5,s4,768 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 65c:	85d2                	mv	a1,s4
 65e:	8556                	mv	a0,s5
 660:	00000097          	auipc	ra,0x0
 664:	e92080e7          	jalr	-366(ra) # 4f2 <putc>
        putc(fd, c);
 668:	85ca                	mv	a1,s2
 66a:	8556                	mv	a0,s5
 66c:	00000097          	auipc	ra,0x0
 670:	e86080e7          	jalr	-378(ra) # 4f2 <putc>
      }
      state = 0;
 674:	4981                	li	s3,0
 676:	b765                	j	61e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 678:	008b0913          	addi	s2,s6,8
 67c:	4685                	li	a3,1
 67e:	4629                	li	a2,10
 680:	000b2583          	lw	a1,0(s6)
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	e8e080e7          	jalr	-370(ra) # 514 <printint>
 68e:	8b4a                	mv	s6,s2
      state = 0;
 690:	4981                	li	s3,0
 692:	b771                	j	61e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 694:	008b0913          	addi	s2,s6,8
 698:	4681                	li	a3,0
 69a:	4629                	li	a2,10
 69c:	000b2583          	lw	a1,0(s6)
 6a0:	8556                	mv	a0,s5
 6a2:	00000097          	auipc	ra,0x0
 6a6:	e72080e7          	jalr	-398(ra) # 514 <printint>
 6aa:	8b4a                	mv	s6,s2
      state = 0;
 6ac:	4981                	li	s3,0
 6ae:	bf85                	j	61e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6b0:	008b0913          	addi	s2,s6,8
 6b4:	4681                	li	a3,0
 6b6:	4641                	li	a2,16
 6b8:	000b2583          	lw	a1,0(s6)
 6bc:	8556                	mv	a0,s5
 6be:	00000097          	auipc	ra,0x0
 6c2:	e56080e7          	jalr	-426(ra) # 514 <printint>
 6c6:	8b4a                	mv	s6,s2
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	bf91                	j	61e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6cc:	008b0793          	addi	a5,s6,8
 6d0:	f8f43423          	sd	a5,-120(s0)
 6d4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6d8:	03000593          	li	a1,48
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	e14080e7          	jalr	-492(ra) # 4f2 <putc>
  putc(fd, 'x');
 6e6:	85ea                	mv	a1,s10
 6e8:	8556                	mv	a0,s5
 6ea:	00000097          	auipc	ra,0x0
 6ee:	e08080e7          	jalr	-504(ra) # 4f2 <putc>
 6f2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6f4:	03c9d793          	srli	a5,s3,0x3c
 6f8:	97de                	add	a5,a5,s7
 6fa:	0007c583          	lbu	a1,0(a5)
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	df2080e7          	jalr	-526(ra) # 4f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 708:	0992                	slli	s3,s3,0x4
 70a:	397d                	addiw	s2,s2,-1
 70c:	fe0914e3          	bnez	s2,6f4 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 710:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 714:	4981                	li	s3,0
 716:	b721                	j	61e <vprintf+0x60>
        s = va_arg(ap, char*);
 718:	008b0993          	addi	s3,s6,8
 71c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 720:	02090163          	beqz	s2,742 <vprintf+0x184>
        while(*s != 0){
 724:	00094583          	lbu	a1,0(s2)
 728:	c9a1                	beqz	a1,778 <vprintf+0x1ba>
          putc(fd, *s);
 72a:	8556                	mv	a0,s5
 72c:	00000097          	auipc	ra,0x0
 730:	dc6080e7          	jalr	-570(ra) # 4f2 <putc>
          s++;
 734:	0905                	addi	s2,s2,1
        while(*s != 0){
 736:	00094583          	lbu	a1,0(s2)
 73a:	f9e5                	bnez	a1,72a <vprintf+0x16c>
        s = va_arg(ap, char*);
 73c:	8b4e                	mv	s6,s3
      state = 0;
 73e:	4981                	li	s3,0
 740:	bdf9                	j	61e <vprintf+0x60>
          s = "(null)";
 742:	00000917          	auipc	s2,0x0
 746:	25690913          	addi	s2,s2,598 # 998 <malloc+0x110>
        while(*s != 0){
 74a:	02800593          	li	a1,40
 74e:	bff1                	j	72a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 750:	008b0913          	addi	s2,s6,8
 754:	000b4583          	lbu	a1,0(s6)
 758:	8556                	mv	a0,s5
 75a:	00000097          	auipc	ra,0x0
 75e:	d98080e7          	jalr	-616(ra) # 4f2 <putc>
 762:	8b4a                	mv	s6,s2
      state = 0;
 764:	4981                	li	s3,0
 766:	bd65                	j	61e <vprintf+0x60>
        putc(fd, c);
 768:	85d2                	mv	a1,s4
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	d86080e7          	jalr	-634(ra) # 4f2 <putc>
      state = 0;
 774:	4981                	li	s3,0
 776:	b565                	j	61e <vprintf+0x60>
        s = va_arg(ap, char*);
 778:	8b4e                	mv	s6,s3
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b54d                	j	61e <vprintf+0x60>
    }
  }
}
 77e:	70e6                	ld	ra,120(sp)
 780:	7446                	ld	s0,112(sp)
 782:	74a6                	ld	s1,104(sp)
 784:	7906                	ld	s2,96(sp)
 786:	69e6                	ld	s3,88(sp)
 788:	6a46                	ld	s4,80(sp)
 78a:	6aa6                	ld	s5,72(sp)
 78c:	6b06                	ld	s6,64(sp)
 78e:	7be2                	ld	s7,56(sp)
 790:	7c42                	ld	s8,48(sp)
 792:	7ca2                	ld	s9,40(sp)
 794:	7d02                	ld	s10,32(sp)
 796:	6de2                	ld	s11,24(sp)
 798:	6109                	addi	sp,sp,128
 79a:	8082                	ret

000000000000079c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 79c:	715d                	addi	sp,sp,-80
 79e:	ec06                	sd	ra,24(sp)
 7a0:	e822                	sd	s0,16(sp)
 7a2:	1000                	addi	s0,sp,32
 7a4:	e010                	sd	a2,0(s0)
 7a6:	e414                	sd	a3,8(s0)
 7a8:	e818                	sd	a4,16(s0)
 7aa:	ec1c                	sd	a5,24(s0)
 7ac:	03043023          	sd	a6,32(s0)
 7b0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7b4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7b8:	8622                	mv	a2,s0
 7ba:	00000097          	auipc	ra,0x0
 7be:	e04080e7          	jalr	-508(ra) # 5be <vprintf>
}
 7c2:	60e2                	ld	ra,24(sp)
 7c4:	6442                	ld	s0,16(sp)
 7c6:	6161                	addi	sp,sp,80
 7c8:	8082                	ret

00000000000007ca <printf>:

void
printf(const char *fmt, ...)
{
 7ca:	711d                	addi	sp,sp,-96
 7cc:	ec06                	sd	ra,24(sp)
 7ce:	e822                	sd	s0,16(sp)
 7d0:	1000                	addi	s0,sp,32
 7d2:	e40c                	sd	a1,8(s0)
 7d4:	e810                	sd	a2,16(s0)
 7d6:	ec14                	sd	a3,24(s0)
 7d8:	f018                	sd	a4,32(s0)
 7da:	f41c                	sd	a5,40(s0)
 7dc:	03043823          	sd	a6,48(s0)
 7e0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7e4:	00840613          	addi	a2,s0,8
 7e8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7ec:	85aa                	mv	a1,a0
 7ee:	4505                	li	a0,1
 7f0:	00000097          	auipc	ra,0x0
 7f4:	dce080e7          	jalr	-562(ra) # 5be <vprintf>
}
 7f8:	60e2                	ld	ra,24(sp)
 7fa:	6442                	ld	s0,16(sp)
 7fc:	6125                	addi	sp,sp,96
 7fe:	8082                	ret

0000000000000800 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 800:	1141                	addi	sp,sp,-16
 802:	e422                	sd	s0,8(sp)
 804:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 806:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 80a:	00000797          	auipc	a5,0x0
 80e:	1ae7b783          	ld	a5,430(a5) # 9b8 <freep>
 812:	a805                	j	842 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 814:	4618                	lw	a4,8(a2)
 816:	9db9                	addw	a1,a1,a4
 818:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 81c:	6398                	ld	a4,0(a5)
 81e:	6318                	ld	a4,0(a4)
 820:	fee53823          	sd	a4,-16(a0)
 824:	a091                	j	868 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 826:	ff852703          	lw	a4,-8(a0)
 82a:	9e39                	addw	a2,a2,a4
 82c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 82e:	ff053703          	ld	a4,-16(a0)
 832:	e398                	sd	a4,0(a5)
 834:	a099                	j	87a <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 836:	6398                	ld	a4,0(a5)
 838:	00e7e463          	bltu	a5,a4,840 <free+0x40>
 83c:	00e6ea63          	bltu	a3,a4,850 <free+0x50>
{
 840:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 842:	fed7fae3          	bgeu	a5,a3,836 <free+0x36>
 846:	6398                	ld	a4,0(a5)
 848:	00e6e463          	bltu	a3,a4,850 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84c:	fee7eae3          	bltu	a5,a4,840 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 850:	ff852583          	lw	a1,-8(a0)
 854:	6390                	ld	a2,0(a5)
 856:	02059713          	slli	a4,a1,0x20
 85a:	9301                	srli	a4,a4,0x20
 85c:	0712                	slli	a4,a4,0x4
 85e:	9736                	add	a4,a4,a3
 860:	fae60ae3          	beq	a2,a4,814 <free+0x14>
    bp->s.ptr = p->s.ptr;
 864:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 868:	4790                	lw	a2,8(a5)
 86a:	02061713          	slli	a4,a2,0x20
 86e:	9301                	srli	a4,a4,0x20
 870:	0712                	slli	a4,a4,0x4
 872:	973e                	add	a4,a4,a5
 874:	fae689e3          	beq	a3,a4,826 <free+0x26>
  } else
    p->s.ptr = bp;
 878:	e394                	sd	a3,0(a5)
  freep = p;
 87a:	00000717          	auipc	a4,0x0
 87e:	12f73f23          	sd	a5,318(a4) # 9b8 <freep>
}
 882:	6422                	ld	s0,8(sp)
 884:	0141                	addi	sp,sp,16
 886:	8082                	ret

0000000000000888 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 888:	7139                	addi	sp,sp,-64
 88a:	fc06                	sd	ra,56(sp)
 88c:	f822                	sd	s0,48(sp)
 88e:	f426                	sd	s1,40(sp)
 890:	f04a                	sd	s2,32(sp)
 892:	ec4e                	sd	s3,24(sp)
 894:	e852                	sd	s4,16(sp)
 896:	e456                	sd	s5,8(sp)
 898:	e05a                	sd	s6,0(sp)
 89a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 89c:	02051493          	slli	s1,a0,0x20
 8a0:	9081                	srli	s1,s1,0x20
 8a2:	04bd                	addi	s1,s1,15
 8a4:	8091                	srli	s1,s1,0x4
 8a6:	0014899b          	addiw	s3,s1,1
 8aa:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8ac:	00000517          	auipc	a0,0x0
 8b0:	10c53503          	ld	a0,268(a0) # 9b8 <freep>
 8b4:	c515                	beqz	a0,8e0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8b8:	4798                	lw	a4,8(a5)
 8ba:	02977f63          	bgeu	a4,s1,8f8 <malloc+0x70>
 8be:	8a4e                	mv	s4,s3
 8c0:	0009871b          	sext.w	a4,s3
 8c4:	6685                	lui	a3,0x1
 8c6:	00d77363          	bgeu	a4,a3,8cc <malloc+0x44>
 8ca:	6a05                	lui	s4,0x1
 8cc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8d0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8d4:	00000917          	auipc	s2,0x0
 8d8:	0e490913          	addi	s2,s2,228 # 9b8 <freep>
  if(p == (char*)-1)
 8dc:	5afd                	li	s5,-1
 8de:	a88d                	j	950 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 8e0:	00000797          	auipc	a5,0x0
 8e4:	0e078793          	addi	a5,a5,224 # 9c0 <base>
 8e8:	00000717          	auipc	a4,0x0
 8ec:	0cf73823          	sd	a5,208(a4) # 9b8 <freep>
 8f0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8f2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8f6:	b7e1                	j	8be <malloc+0x36>
      if(p->s.size == nunits)
 8f8:	02e48b63          	beq	s1,a4,92e <malloc+0xa6>
        p->s.size -= nunits;
 8fc:	4137073b          	subw	a4,a4,s3
 900:	c798                	sw	a4,8(a5)
        p += p->s.size;
 902:	1702                	slli	a4,a4,0x20
 904:	9301                	srli	a4,a4,0x20
 906:	0712                	slli	a4,a4,0x4
 908:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 90a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 90e:	00000717          	auipc	a4,0x0
 912:	0aa73523          	sd	a0,170(a4) # 9b8 <freep>
      return (void*)(p + 1);
 916:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 91a:	70e2                	ld	ra,56(sp)
 91c:	7442                	ld	s0,48(sp)
 91e:	74a2                	ld	s1,40(sp)
 920:	7902                	ld	s2,32(sp)
 922:	69e2                	ld	s3,24(sp)
 924:	6a42                	ld	s4,16(sp)
 926:	6aa2                	ld	s5,8(sp)
 928:	6b02                	ld	s6,0(sp)
 92a:	6121                	addi	sp,sp,64
 92c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 92e:	6398                	ld	a4,0(a5)
 930:	e118                	sd	a4,0(a0)
 932:	bff1                	j	90e <malloc+0x86>
  hp->s.size = nu;
 934:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 938:	0541                	addi	a0,a0,16
 93a:	00000097          	auipc	ra,0x0
 93e:	ec6080e7          	jalr	-314(ra) # 800 <free>
  return freep;
 942:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 946:	d971                	beqz	a0,91a <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 948:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 94a:	4798                	lw	a4,8(a5)
 94c:	fa9776e3          	bgeu	a4,s1,8f8 <malloc+0x70>
    if(p == freep)
 950:	00093703          	ld	a4,0(s2)
 954:	853e                	mv	a0,a5
 956:	fef719e3          	bne	a4,a5,948 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 95a:	8552                	mv	a0,s4
 95c:	00000097          	auipc	ra,0x0
 960:	b7e080e7          	jalr	-1154(ra) # 4da <sbrk>
  if(p == (char*)-1)
 964:	fd5518e3          	bne	a0,s5,934 <malloc+0xac>
        return 0;
 968:	4501                	li	a0,0
 96a:	bf45                	j	91a <malloc+0x92>
