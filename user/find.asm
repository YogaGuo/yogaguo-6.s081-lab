
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
char *fmtname(char *path)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0

    char *p;
    // Find first character after last slash.
    for (p = path + strlen(path); p >= path && *p != '/'; p--)
   c:	00000097          	auipc	ra,0x0
  10:	27a080e7          	jalr	634(ra) # 286 <strlen>
  14:	1502                	slli	a0,a0,0x20
  16:	9101                	srli	a0,a0,0x20
  18:	9526                	add	a0,a0,s1
  1a:	02f00713          	li	a4,47
  1e:	00956963          	bltu	a0,s1,30 <fmtname+0x30>
  22:	00054783          	lbu	a5,0(a0)
  26:	00e78563          	beq	a5,a4,30 <fmtname+0x30>
  2a:	157d                	addi	a0,a0,-1
  2c:	fe957be3          	bgeu	a0,s1,22 <fmtname+0x22>
        ;
    p++;
    return p;
}
  30:	0505                	addi	a0,a0,1
  32:	60e2                	ld	ra,24(sp)
  34:	6442                	ld	s0,16(sp)
  36:	64a2                	ld	s1,8(sp)
  38:	6105                	addi	sp,sp,32
  3a:	8082                	ret

000000000000003c <find>:

void find(char *path, char *filename)
{
  3c:	d8010113          	addi	sp,sp,-640
  40:	26113c23          	sd	ra,632(sp)
  44:	26813823          	sd	s0,624(sp)
  48:	26913423          	sd	s1,616(sp)
  4c:	27213023          	sd	s2,608(sp)
  50:	25313c23          	sd	s3,600(sp)
  54:	25413823          	sd	s4,592(sp)
  58:	25513423          	sd	s5,584(sp)
  5c:	25613023          	sd	s6,576(sp)
  60:	23713c23          	sd	s7,568(sp)
  64:	0500                	addi	s0,sp,640
  66:	892a                	mv	s2,a0
  68:	89ae                	mv	s3,a1
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;
    if ((fd = open(path, 0)) < 0)
  6a:	4581                	li	a1,0
  6c:	00000097          	auipc	ra,0x0
  70:	488080e7          	jalr	1160(ra) # 4f4 <open>
  74:	06054a63          	bltz	a0,e8 <find+0xac>
  78:	84aa                	mv	s1,a0
    {
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if (fstat(fd, &st) < 0)
  7a:	d8840593          	addi	a1,s0,-632
  7e:	00000097          	auipc	ra,0x0
  82:	48e080e7          	jalr	1166(ra) # 50c <fstat>
  86:	06054c63          	bltz	a0,fe <find+0xc2>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }

    switch (st.type)
  8a:	d9041783          	lh	a5,-624(s0)
  8e:	0007869b          	sext.w	a3,a5
  92:	4705                	li	a4,1
  94:	08e68f63          	beq	a3,a4,132 <find+0xf6>
  98:	4709                	li	a4,2
  9a:	00e69d63          	bne	a3,a4,b4 <find+0x78>
    {
    case T_FILE:
        // target file found
        if (strcmp(fmtname(path), filename) == 0)
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	f60080e7          	jalr	-160(ra) # 0 <fmtname>
  a8:	85ce                	mv	a1,s3
  aa:	00000097          	auipc	ra,0x0
  ae:	1b0080e7          	jalr	432(ra) # 25a <strcmp>
  b2:	c535                	beqz	a0,11e <find+0xe2>
            // recursively call find to search the entry
            find(buf, filename);
        }
        break;
    }
    close(fd);
  b4:	8526                	mv	a0,s1
  b6:	00000097          	auipc	ra,0x0
  ba:	426080e7          	jalr	1062(ra) # 4dc <close>
}
  be:	27813083          	ld	ra,632(sp)
  c2:	27013403          	ld	s0,624(sp)
  c6:	26813483          	ld	s1,616(sp)
  ca:	26013903          	ld	s2,608(sp)
  ce:	25813983          	ld	s3,600(sp)
  d2:	25013a03          	ld	s4,592(sp)
  d6:	24813a83          	ld	s5,584(sp)
  da:	24013b03          	ld	s6,576(sp)
  de:	23813b83          	ld	s7,568(sp)
  e2:	28010113          	addi	sp,sp,640
  e6:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
  e8:	864a                	mv	a2,s2
  ea:	00001597          	auipc	a1,0x1
  ee:	8e658593          	addi	a1,a1,-1818 # 9d0 <malloc+0xe6>
  f2:	4509                	li	a0,2
  f4:	00000097          	auipc	ra,0x0
  f8:	70a080e7          	jalr	1802(ra) # 7fe <fprintf>
        return;
  fc:	b7c9                	j	be <find+0x82>
        fprintf(2, "find: cannot stat %s\n", path);
  fe:	864a                	mv	a2,s2
 100:	00001597          	auipc	a1,0x1
 104:	8e858593          	addi	a1,a1,-1816 # 9e8 <malloc+0xfe>
 108:	4509                	li	a0,2
 10a:	00000097          	auipc	ra,0x0
 10e:	6f4080e7          	jalr	1780(ra) # 7fe <fprintf>
        close(fd);
 112:	8526                	mv	a0,s1
 114:	00000097          	auipc	ra,0x0
 118:	3c8080e7          	jalr	968(ra) # 4dc <close>
        return;
 11c:	b74d                	j	be <find+0x82>
            printf("%s\n", path);
 11e:	85ca                	mv	a1,s2
 120:	00001517          	auipc	a0,0x1
 124:	8e050513          	addi	a0,a0,-1824 # a00 <malloc+0x116>
 128:	00000097          	auipc	ra,0x0
 12c:	704080e7          	jalr	1796(ra) # 82c <printf>
 130:	b751                	j	b4 <find+0x78>
        if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf)
 132:	854a                	mv	a0,s2
 134:	00000097          	auipc	ra,0x0
 138:	152080e7          	jalr	338(ra) # 286 <strlen>
 13c:	2541                	addiw	a0,a0,16
 13e:	20000793          	li	a5,512
 142:	00a7fb63          	bgeu	a5,a0,158 <find+0x11c>
            printf("ls: path too long\n");
 146:	00001517          	auipc	a0,0x1
 14a:	8c250513          	addi	a0,a0,-1854 # a08 <malloc+0x11e>
 14e:	00000097          	auipc	ra,0x0
 152:	6de080e7          	jalr	1758(ra) # 82c <printf>
            break;
 156:	bfb9                	j	b4 <find+0x78>
        strcpy(buf, path);
 158:	85ca                	mv	a1,s2
 15a:	db040513          	addi	a0,s0,-592
 15e:	00000097          	auipc	ra,0x0
 162:	0e0080e7          	jalr	224(ra) # 23e <strcpy>
        p = buf + strlen(buf);
 166:	db040513          	addi	a0,s0,-592
 16a:	00000097          	auipc	ra,0x0
 16e:	11c080e7          	jalr	284(ra) # 286 <strlen>
 172:	02051913          	slli	s2,a0,0x20
 176:	02095913          	srli	s2,s2,0x20
 17a:	db040793          	addi	a5,s0,-592
 17e:	993e                	add	s2,s2,a5
        *p++ = '/';
 180:	00190b13          	addi	s6,s2,1
 184:	02f00793          	li	a5,47
 188:	00f90023          	sb	a5,0(s2)
            if (de.inum == 0 || strcmp(de.name, "..") == 0 || strcmp(de.name, ".") == 0)
 18c:	00001a97          	auipc	s5,0x1
 190:	894a8a93          	addi	s5,s5,-1900 # a20 <malloc+0x136>
 194:	00001b97          	auipc	s7,0x1
 198:	894b8b93          	addi	s7,s7,-1900 # a28 <malloc+0x13e>
 19c:	da240a13          	addi	s4,s0,-606
        while (read(fd, &de, sizeof(de)) == sizeof(de))
 1a0:	4641                	li	a2,16
 1a2:	da040593          	addi	a1,s0,-608
 1a6:	8526                	mv	a0,s1
 1a8:	00000097          	auipc	ra,0x0
 1ac:	324080e7          	jalr	804(ra) # 4cc <read>
 1b0:	47c1                	li	a5,16
 1b2:	f0f511e3          	bne	a0,a5,b4 <find+0x78>
            if (de.inum == 0 || strcmp(de.name, "..") == 0 || strcmp(de.name, ".") == 0)
 1b6:	da045783          	lhu	a5,-608(s0)
 1ba:	d3fd                	beqz	a5,1a0 <find+0x164>
 1bc:	85d6                	mv	a1,s5
 1be:	8552                	mv	a0,s4
 1c0:	00000097          	auipc	ra,0x0
 1c4:	09a080e7          	jalr	154(ra) # 25a <strcmp>
 1c8:	dd61                	beqz	a0,1a0 <find+0x164>
 1ca:	85de                	mv	a1,s7
 1cc:	8552                	mv	a0,s4
 1ce:	00000097          	auipc	ra,0x0
 1d2:	08c080e7          	jalr	140(ra) # 25a <strcmp>
 1d6:	d569                	beqz	a0,1a0 <find+0x164>
            memmove(p, de.name, DIRSIZ);
 1d8:	4639                	li	a2,14
 1da:	da240593          	addi	a1,s0,-606
 1de:	855a                	mv	a0,s6
 1e0:	00000097          	auipc	ra,0x0
 1e4:	21e080e7          	jalr	542(ra) # 3fe <memmove>
            p[DIRSIZ] = 0;
 1e8:	000907a3          	sb	zero,15(s2)
            find(buf, filename);
 1ec:	85ce                	mv	a1,s3
 1ee:	db040513          	addi	a0,s0,-592
 1f2:	00000097          	auipc	ra,0x0
 1f6:	e4a080e7          	jalr	-438(ra) # 3c <find>
 1fa:	b75d                	j	1a0 <find+0x164>

00000000000001fc <main>:

int main(int argc, char *argv[])
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e406                	sd	ra,8(sp)
 200:	e022                	sd	s0,0(sp)
 202:	0800                	addi	s0,sp,16
    if (argc < 3)
 204:	4709                	li	a4,2
 206:	02a74063          	blt	a4,a0,226 <main+0x2a>
    {
        fprintf(2, "usage: find directory filename\n");
 20a:	00001597          	auipc	a1,0x1
 20e:	82658593          	addi	a1,a1,-2010 # a30 <malloc+0x146>
 212:	4509                	li	a0,2
 214:	00000097          	auipc	ra,0x0
 218:	5ea080e7          	jalr	1514(ra) # 7fe <fprintf>
        exit(1);
 21c:	4505                	li	a0,1
 21e:	00000097          	auipc	ra,0x0
 222:	296080e7          	jalr	662(ra) # 4b4 <exit>
 226:	87ae                	mv	a5,a1
    }
    find(argv[1], argv[2]);
 228:	698c                	ld	a1,16(a1)
 22a:	6788                	ld	a0,8(a5)
 22c:	00000097          	auipc	ra,0x0
 230:	e10080e7          	jalr	-496(ra) # 3c <find>
    exit(0);
 234:	4501                	li	a0,0
 236:	00000097          	auipc	ra,0x0
 23a:	27e080e7          	jalr	638(ra) # 4b4 <exit>

000000000000023e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 23e:	1141                	addi	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 244:	87aa                	mv	a5,a0
 246:	0585                	addi	a1,a1,1
 248:	0785                	addi	a5,a5,1
 24a:	fff5c703          	lbu	a4,-1(a1)
 24e:	fee78fa3          	sb	a4,-1(a5)
 252:	fb75                	bnez	a4,246 <strcpy+0x8>
    ;
  return os;
}
 254:	6422                	ld	s0,8(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret

000000000000025a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e422                	sd	s0,8(sp)
 25e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 260:	00054783          	lbu	a5,0(a0)
 264:	cb91                	beqz	a5,278 <strcmp+0x1e>
 266:	0005c703          	lbu	a4,0(a1)
 26a:	00f71763          	bne	a4,a5,278 <strcmp+0x1e>
    p++, q++;
 26e:	0505                	addi	a0,a0,1
 270:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 272:	00054783          	lbu	a5,0(a0)
 276:	fbe5                	bnez	a5,266 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 278:	0005c503          	lbu	a0,0(a1)
}
 27c:	40a7853b          	subw	a0,a5,a0
 280:	6422                	ld	s0,8(sp)
 282:	0141                	addi	sp,sp,16
 284:	8082                	ret

0000000000000286 <strlen>:

uint
strlen(const char *s)
{
 286:	1141                	addi	sp,sp,-16
 288:	e422                	sd	s0,8(sp)
 28a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 28c:	00054783          	lbu	a5,0(a0)
 290:	cf91                	beqz	a5,2ac <strlen+0x26>
 292:	0505                	addi	a0,a0,1
 294:	87aa                	mv	a5,a0
 296:	4685                	li	a3,1
 298:	9e89                	subw	a3,a3,a0
 29a:	00f6853b          	addw	a0,a3,a5
 29e:	0785                	addi	a5,a5,1
 2a0:	fff7c703          	lbu	a4,-1(a5)
 2a4:	fb7d                	bnez	a4,29a <strlen+0x14>
    ;
  return n;
}
 2a6:	6422                	ld	s0,8(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret
  for(n = 0; s[n]; n++)
 2ac:	4501                	li	a0,0
 2ae:	bfe5                	j	2a6 <strlen+0x20>

00000000000002b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2b0:	1141                	addi	sp,sp,-16
 2b2:	e422                	sd	s0,8(sp)
 2b4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2b6:	ce09                	beqz	a2,2d0 <memset+0x20>
 2b8:	87aa                	mv	a5,a0
 2ba:	fff6071b          	addiw	a4,a2,-1
 2be:	1702                	slli	a4,a4,0x20
 2c0:	9301                	srli	a4,a4,0x20
 2c2:	0705                	addi	a4,a4,1
 2c4:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2c6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2ca:	0785                	addi	a5,a5,1
 2cc:	fee79de3          	bne	a5,a4,2c6 <memset+0x16>
  }
  return dst;
}
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	addi	sp,sp,16
 2d4:	8082                	ret

00000000000002d6 <strchr>:

char*
strchr(const char *s, char c)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e422                	sd	s0,8(sp)
 2da:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2dc:	00054783          	lbu	a5,0(a0)
 2e0:	cb99                	beqz	a5,2f6 <strchr+0x20>
    if(*s == c)
 2e2:	00f58763          	beq	a1,a5,2f0 <strchr+0x1a>
  for(; *s; s++)
 2e6:	0505                	addi	a0,a0,1
 2e8:	00054783          	lbu	a5,0(a0)
 2ec:	fbfd                	bnez	a5,2e2 <strchr+0xc>
      return (char*)s;
  return 0;
 2ee:	4501                	li	a0,0
}
 2f0:	6422                	ld	s0,8(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret
  return 0;
 2f6:	4501                	li	a0,0
 2f8:	bfe5                	j	2f0 <strchr+0x1a>

00000000000002fa <gets>:

char*
gets(char *buf, int max)
{
 2fa:	711d                	addi	sp,sp,-96
 2fc:	ec86                	sd	ra,88(sp)
 2fe:	e8a2                	sd	s0,80(sp)
 300:	e4a6                	sd	s1,72(sp)
 302:	e0ca                	sd	s2,64(sp)
 304:	fc4e                	sd	s3,56(sp)
 306:	f852                	sd	s4,48(sp)
 308:	f456                	sd	s5,40(sp)
 30a:	f05a                	sd	s6,32(sp)
 30c:	ec5e                	sd	s7,24(sp)
 30e:	1080                	addi	s0,sp,96
 310:	8baa                	mv	s7,a0
 312:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 314:	892a                	mv	s2,a0
 316:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 318:	4aa9                	li	s5,10
 31a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 31c:	89a6                	mv	s3,s1
 31e:	2485                	addiw	s1,s1,1
 320:	0344d863          	bge	s1,s4,350 <gets+0x56>
    cc = read(0, &c, 1);
 324:	4605                	li	a2,1
 326:	faf40593          	addi	a1,s0,-81
 32a:	4501                	li	a0,0
 32c:	00000097          	auipc	ra,0x0
 330:	1a0080e7          	jalr	416(ra) # 4cc <read>
    if(cc < 1)
 334:	00a05e63          	blez	a0,350 <gets+0x56>
    buf[i++] = c;
 338:	faf44783          	lbu	a5,-81(s0)
 33c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 340:	01578763          	beq	a5,s5,34e <gets+0x54>
 344:	0905                	addi	s2,s2,1
 346:	fd679be3          	bne	a5,s6,31c <gets+0x22>
  for(i=0; i+1 < max; ){
 34a:	89a6                	mv	s3,s1
 34c:	a011                	j	350 <gets+0x56>
 34e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 350:	99de                	add	s3,s3,s7
 352:	00098023          	sb	zero,0(s3)
  return buf;
}
 356:	855e                	mv	a0,s7
 358:	60e6                	ld	ra,88(sp)
 35a:	6446                	ld	s0,80(sp)
 35c:	64a6                	ld	s1,72(sp)
 35e:	6906                	ld	s2,64(sp)
 360:	79e2                	ld	s3,56(sp)
 362:	7a42                	ld	s4,48(sp)
 364:	7aa2                	ld	s5,40(sp)
 366:	7b02                	ld	s6,32(sp)
 368:	6be2                	ld	s7,24(sp)
 36a:	6125                	addi	sp,sp,96
 36c:	8082                	ret

000000000000036e <stat>:

int
stat(const char *n, struct stat *st)
{
 36e:	1101                	addi	sp,sp,-32
 370:	ec06                	sd	ra,24(sp)
 372:	e822                	sd	s0,16(sp)
 374:	e426                	sd	s1,8(sp)
 376:	e04a                	sd	s2,0(sp)
 378:	1000                	addi	s0,sp,32
 37a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 37c:	4581                	li	a1,0
 37e:	00000097          	auipc	ra,0x0
 382:	176080e7          	jalr	374(ra) # 4f4 <open>
  if(fd < 0)
 386:	02054563          	bltz	a0,3b0 <stat+0x42>
 38a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 38c:	85ca                	mv	a1,s2
 38e:	00000097          	auipc	ra,0x0
 392:	17e080e7          	jalr	382(ra) # 50c <fstat>
 396:	892a                	mv	s2,a0
  close(fd);
 398:	8526                	mv	a0,s1
 39a:	00000097          	auipc	ra,0x0
 39e:	142080e7          	jalr	322(ra) # 4dc <close>
  return r;
}
 3a2:	854a                	mv	a0,s2
 3a4:	60e2                	ld	ra,24(sp)
 3a6:	6442                	ld	s0,16(sp)
 3a8:	64a2                	ld	s1,8(sp)
 3aa:	6902                	ld	s2,0(sp)
 3ac:	6105                	addi	sp,sp,32
 3ae:	8082                	ret
    return -1;
 3b0:	597d                	li	s2,-1
 3b2:	bfc5                	j	3a2 <stat+0x34>

00000000000003b4 <atoi>:

int
atoi(const char *s)
{
 3b4:	1141                	addi	sp,sp,-16
 3b6:	e422                	sd	s0,8(sp)
 3b8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3ba:	00054603          	lbu	a2,0(a0)
 3be:	fd06079b          	addiw	a5,a2,-48
 3c2:	0ff7f793          	andi	a5,a5,255
 3c6:	4725                	li	a4,9
 3c8:	02f76963          	bltu	a4,a5,3fa <atoi+0x46>
 3cc:	86aa                	mv	a3,a0
  n = 0;
 3ce:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3d0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3d2:	0685                	addi	a3,a3,1
 3d4:	0025179b          	slliw	a5,a0,0x2
 3d8:	9fa9                	addw	a5,a5,a0
 3da:	0017979b          	slliw	a5,a5,0x1
 3de:	9fb1                	addw	a5,a5,a2
 3e0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3e4:	0006c603          	lbu	a2,0(a3)
 3e8:	fd06071b          	addiw	a4,a2,-48
 3ec:	0ff77713          	andi	a4,a4,255
 3f0:	fee5f1e3          	bgeu	a1,a4,3d2 <atoi+0x1e>
  return n;
}
 3f4:	6422                	ld	s0,8(sp)
 3f6:	0141                	addi	sp,sp,16
 3f8:	8082                	ret
  n = 0;
 3fa:	4501                	li	a0,0
 3fc:	bfe5                	j	3f4 <atoi+0x40>

00000000000003fe <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3fe:	1141                	addi	sp,sp,-16
 400:	e422                	sd	s0,8(sp)
 402:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 404:	02b57663          	bgeu	a0,a1,430 <memmove+0x32>
    while(n-- > 0)
 408:	02c05163          	blez	a2,42a <memmove+0x2c>
 40c:	fff6079b          	addiw	a5,a2,-1
 410:	1782                	slli	a5,a5,0x20
 412:	9381                	srli	a5,a5,0x20
 414:	0785                	addi	a5,a5,1
 416:	97aa                	add	a5,a5,a0
  dst = vdst;
 418:	872a                	mv	a4,a0
      *dst++ = *src++;
 41a:	0585                	addi	a1,a1,1
 41c:	0705                	addi	a4,a4,1
 41e:	fff5c683          	lbu	a3,-1(a1)
 422:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 426:	fee79ae3          	bne	a5,a4,41a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 42a:	6422                	ld	s0,8(sp)
 42c:	0141                	addi	sp,sp,16
 42e:	8082                	ret
    dst += n;
 430:	00c50733          	add	a4,a0,a2
    src += n;
 434:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 436:	fec05ae3          	blez	a2,42a <memmove+0x2c>
 43a:	fff6079b          	addiw	a5,a2,-1
 43e:	1782                	slli	a5,a5,0x20
 440:	9381                	srli	a5,a5,0x20
 442:	fff7c793          	not	a5,a5
 446:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 448:	15fd                	addi	a1,a1,-1
 44a:	177d                	addi	a4,a4,-1
 44c:	0005c683          	lbu	a3,0(a1)
 450:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 454:	fee79ae3          	bne	a5,a4,448 <memmove+0x4a>
 458:	bfc9                	j	42a <memmove+0x2c>

000000000000045a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 45a:	1141                	addi	sp,sp,-16
 45c:	e422                	sd	s0,8(sp)
 45e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 460:	ca05                	beqz	a2,490 <memcmp+0x36>
 462:	fff6069b          	addiw	a3,a2,-1
 466:	1682                	slli	a3,a3,0x20
 468:	9281                	srli	a3,a3,0x20
 46a:	0685                	addi	a3,a3,1
 46c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 46e:	00054783          	lbu	a5,0(a0)
 472:	0005c703          	lbu	a4,0(a1)
 476:	00e79863          	bne	a5,a4,486 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 47a:	0505                	addi	a0,a0,1
    p2++;
 47c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 47e:	fed518e3          	bne	a0,a3,46e <memcmp+0x14>
  }
  return 0;
 482:	4501                	li	a0,0
 484:	a019                	j	48a <memcmp+0x30>
      return *p1 - *p2;
 486:	40e7853b          	subw	a0,a5,a4
}
 48a:	6422                	ld	s0,8(sp)
 48c:	0141                	addi	sp,sp,16
 48e:	8082                	ret
  return 0;
 490:	4501                	li	a0,0
 492:	bfe5                	j	48a <memcmp+0x30>

0000000000000494 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 494:	1141                	addi	sp,sp,-16
 496:	e406                	sd	ra,8(sp)
 498:	e022                	sd	s0,0(sp)
 49a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 49c:	00000097          	auipc	ra,0x0
 4a0:	f62080e7          	jalr	-158(ra) # 3fe <memmove>
}
 4a4:	60a2                	ld	ra,8(sp)
 4a6:	6402                	ld	s0,0(sp)
 4a8:	0141                	addi	sp,sp,16
 4aa:	8082                	ret

00000000000004ac <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4ac:	4885                	li	a7,1
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4b4:	4889                	li	a7,2
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <wait>:
.global wait
wait:
 li a7, SYS_wait
 4bc:	488d                	li	a7,3
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4c4:	4891                	li	a7,4
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <read>:
.global read
read:
 li a7, SYS_read
 4cc:	4895                	li	a7,5
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <write>:
.global write
write:
 li a7, SYS_write
 4d4:	48c1                	li	a7,16
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <close>:
.global close
close:
 li a7, SYS_close
 4dc:	48d5                	li	a7,21
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4e4:	4899                	li	a7,6
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <exec>:
.global exec
exec:
 li a7, SYS_exec
 4ec:	489d                	li	a7,7
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <open>:
.global open
open:
 li a7, SYS_open
 4f4:	48bd                	li	a7,15
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4fc:	48c5                	li	a7,17
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 504:	48c9                	li	a7,18
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 50c:	48a1                	li	a7,8
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <link>:
.global link
link:
 li a7, SYS_link
 514:	48cd                	li	a7,19
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 51c:	48d1                	li	a7,20
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 524:	48a5                	li	a7,9
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <dup>:
.global dup
dup:
 li a7, SYS_dup
 52c:	48a9                	li	a7,10
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 534:	48ad                	li	a7,11
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 53c:	48b1                	li	a7,12
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 544:	48b5                	li	a7,13
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 54c:	48b9                	li	a7,14
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 554:	1101                	addi	sp,sp,-32
 556:	ec06                	sd	ra,24(sp)
 558:	e822                	sd	s0,16(sp)
 55a:	1000                	addi	s0,sp,32
 55c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 560:	4605                	li	a2,1
 562:	fef40593          	addi	a1,s0,-17
 566:	00000097          	auipc	ra,0x0
 56a:	f6e080e7          	jalr	-146(ra) # 4d4 <write>
}
 56e:	60e2                	ld	ra,24(sp)
 570:	6442                	ld	s0,16(sp)
 572:	6105                	addi	sp,sp,32
 574:	8082                	ret

0000000000000576 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 576:	7139                	addi	sp,sp,-64
 578:	fc06                	sd	ra,56(sp)
 57a:	f822                	sd	s0,48(sp)
 57c:	f426                	sd	s1,40(sp)
 57e:	f04a                	sd	s2,32(sp)
 580:	ec4e                	sd	s3,24(sp)
 582:	0080                	addi	s0,sp,64
 584:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 586:	c299                	beqz	a3,58c <printint+0x16>
 588:	0805c863          	bltz	a1,618 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 58c:	2581                	sext.w	a1,a1
  neg = 0;
 58e:	4881                	li	a7,0
 590:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 594:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 596:	2601                	sext.w	a2,a2
 598:	00000517          	auipc	a0,0x0
 59c:	4c050513          	addi	a0,a0,1216 # a58 <digits>
 5a0:	883a                	mv	a6,a4
 5a2:	2705                	addiw	a4,a4,1
 5a4:	02c5f7bb          	remuw	a5,a1,a2
 5a8:	1782                	slli	a5,a5,0x20
 5aa:	9381                	srli	a5,a5,0x20
 5ac:	97aa                	add	a5,a5,a0
 5ae:	0007c783          	lbu	a5,0(a5)
 5b2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5b6:	0005879b          	sext.w	a5,a1
 5ba:	02c5d5bb          	divuw	a1,a1,a2
 5be:	0685                	addi	a3,a3,1
 5c0:	fec7f0e3          	bgeu	a5,a2,5a0 <printint+0x2a>
  if(neg)
 5c4:	00088b63          	beqz	a7,5da <printint+0x64>
    buf[i++] = '-';
 5c8:	fd040793          	addi	a5,s0,-48
 5cc:	973e                	add	a4,a4,a5
 5ce:	02d00793          	li	a5,45
 5d2:	fef70823          	sb	a5,-16(a4)
 5d6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5da:	02e05863          	blez	a4,60a <printint+0x94>
 5de:	fc040793          	addi	a5,s0,-64
 5e2:	00e78933          	add	s2,a5,a4
 5e6:	fff78993          	addi	s3,a5,-1
 5ea:	99ba                	add	s3,s3,a4
 5ec:	377d                	addiw	a4,a4,-1
 5ee:	1702                	slli	a4,a4,0x20
 5f0:	9301                	srli	a4,a4,0x20
 5f2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5f6:	fff94583          	lbu	a1,-1(s2)
 5fa:	8526                	mv	a0,s1
 5fc:	00000097          	auipc	ra,0x0
 600:	f58080e7          	jalr	-168(ra) # 554 <putc>
  while(--i >= 0)
 604:	197d                	addi	s2,s2,-1
 606:	ff3918e3          	bne	s2,s3,5f6 <printint+0x80>
}
 60a:	70e2                	ld	ra,56(sp)
 60c:	7442                	ld	s0,48(sp)
 60e:	74a2                	ld	s1,40(sp)
 610:	7902                	ld	s2,32(sp)
 612:	69e2                	ld	s3,24(sp)
 614:	6121                	addi	sp,sp,64
 616:	8082                	ret
    x = -xx;
 618:	40b005bb          	negw	a1,a1
    neg = 1;
 61c:	4885                	li	a7,1
    x = -xx;
 61e:	bf8d                	j	590 <printint+0x1a>

0000000000000620 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 620:	7119                	addi	sp,sp,-128
 622:	fc86                	sd	ra,120(sp)
 624:	f8a2                	sd	s0,112(sp)
 626:	f4a6                	sd	s1,104(sp)
 628:	f0ca                	sd	s2,96(sp)
 62a:	ecce                	sd	s3,88(sp)
 62c:	e8d2                	sd	s4,80(sp)
 62e:	e4d6                	sd	s5,72(sp)
 630:	e0da                	sd	s6,64(sp)
 632:	fc5e                	sd	s7,56(sp)
 634:	f862                	sd	s8,48(sp)
 636:	f466                	sd	s9,40(sp)
 638:	f06a                	sd	s10,32(sp)
 63a:	ec6e                	sd	s11,24(sp)
 63c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 63e:	0005c903          	lbu	s2,0(a1)
 642:	18090f63          	beqz	s2,7e0 <vprintf+0x1c0>
 646:	8aaa                	mv	s5,a0
 648:	8b32                	mv	s6,a2
 64a:	00158493          	addi	s1,a1,1
  state = 0;
 64e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 650:	02500a13          	li	s4,37
      if(c == 'd'){
 654:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 658:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 65c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 660:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 664:	00000b97          	auipc	s7,0x0
 668:	3f4b8b93          	addi	s7,s7,1012 # a58 <digits>
 66c:	a839                	j	68a <vprintf+0x6a>
        putc(fd, c);
 66e:	85ca                	mv	a1,s2
 670:	8556                	mv	a0,s5
 672:	00000097          	auipc	ra,0x0
 676:	ee2080e7          	jalr	-286(ra) # 554 <putc>
 67a:	a019                	j	680 <vprintf+0x60>
    } else if(state == '%'){
 67c:	01498f63          	beq	s3,s4,69a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 680:	0485                	addi	s1,s1,1
 682:	fff4c903          	lbu	s2,-1(s1)
 686:	14090d63          	beqz	s2,7e0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 68a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 68e:	fe0997e3          	bnez	s3,67c <vprintf+0x5c>
      if(c == '%'){
 692:	fd479ee3          	bne	a5,s4,66e <vprintf+0x4e>
        state = '%';
 696:	89be                	mv	s3,a5
 698:	b7e5                	j	680 <vprintf+0x60>
      if(c == 'd'){
 69a:	05878063          	beq	a5,s8,6da <vprintf+0xba>
      } else if(c == 'l') {
 69e:	05978c63          	beq	a5,s9,6f6 <vprintf+0xd6>
      } else if(c == 'x') {
 6a2:	07a78863          	beq	a5,s10,712 <vprintf+0xf2>
      } else if(c == 'p') {
 6a6:	09b78463          	beq	a5,s11,72e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6aa:	07300713          	li	a4,115
 6ae:	0ce78663          	beq	a5,a4,77a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6b2:	06300713          	li	a4,99
 6b6:	0ee78e63          	beq	a5,a4,7b2 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6ba:	11478863          	beq	a5,s4,7ca <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6be:	85d2                	mv	a1,s4
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	e92080e7          	jalr	-366(ra) # 554 <putc>
        putc(fd, c);
 6ca:	85ca                	mv	a1,s2
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	e86080e7          	jalr	-378(ra) # 554 <putc>
      }
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	b765                	j	680 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6da:	008b0913          	addi	s2,s6,8
 6de:	4685                	li	a3,1
 6e0:	4629                	li	a2,10
 6e2:	000b2583          	lw	a1,0(s6)
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	e8e080e7          	jalr	-370(ra) # 576 <printint>
 6f0:	8b4a                	mv	s6,s2
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b771                	j	680 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f6:	008b0913          	addi	s2,s6,8
 6fa:	4681                	li	a3,0
 6fc:	4629                	li	a2,10
 6fe:	000b2583          	lw	a1,0(s6)
 702:	8556                	mv	a0,s5
 704:	00000097          	auipc	ra,0x0
 708:	e72080e7          	jalr	-398(ra) # 576 <printint>
 70c:	8b4a                	mv	s6,s2
      state = 0;
 70e:	4981                	li	s3,0
 710:	bf85                	j	680 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 712:	008b0913          	addi	s2,s6,8
 716:	4681                	li	a3,0
 718:	4641                	li	a2,16
 71a:	000b2583          	lw	a1,0(s6)
 71e:	8556                	mv	a0,s5
 720:	00000097          	auipc	ra,0x0
 724:	e56080e7          	jalr	-426(ra) # 576 <printint>
 728:	8b4a                	mv	s6,s2
      state = 0;
 72a:	4981                	li	s3,0
 72c:	bf91                	j	680 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 72e:	008b0793          	addi	a5,s6,8
 732:	f8f43423          	sd	a5,-120(s0)
 736:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 73a:	03000593          	li	a1,48
 73e:	8556                	mv	a0,s5
 740:	00000097          	auipc	ra,0x0
 744:	e14080e7          	jalr	-492(ra) # 554 <putc>
  putc(fd, 'x');
 748:	85ea                	mv	a1,s10
 74a:	8556                	mv	a0,s5
 74c:	00000097          	auipc	ra,0x0
 750:	e08080e7          	jalr	-504(ra) # 554 <putc>
 754:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 756:	03c9d793          	srli	a5,s3,0x3c
 75a:	97de                	add	a5,a5,s7
 75c:	0007c583          	lbu	a1,0(a5)
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	df2080e7          	jalr	-526(ra) # 554 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 76a:	0992                	slli	s3,s3,0x4
 76c:	397d                	addiw	s2,s2,-1
 76e:	fe0914e3          	bnez	s2,756 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 772:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 776:	4981                	li	s3,0
 778:	b721                	j	680 <vprintf+0x60>
        s = va_arg(ap, char*);
 77a:	008b0993          	addi	s3,s6,8
 77e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 782:	02090163          	beqz	s2,7a4 <vprintf+0x184>
        while(*s != 0){
 786:	00094583          	lbu	a1,0(s2)
 78a:	c9a1                	beqz	a1,7da <vprintf+0x1ba>
          putc(fd, *s);
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	dc6080e7          	jalr	-570(ra) # 554 <putc>
          s++;
 796:	0905                	addi	s2,s2,1
        while(*s != 0){
 798:	00094583          	lbu	a1,0(s2)
 79c:	f9e5                	bnez	a1,78c <vprintf+0x16c>
        s = va_arg(ap, char*);
 79e:	8b4e                	mv	s6,s3
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	bdf9                	j	680 <vprintf+0x60>
          s = "(null)";
 7a4:	00000917          	auipc	s2,0x0
 7a8:	2ac90913          	addi	s2,s2,684 # a50 <malloc+0x166>
        while(*s != 0){
 7ac:	02800593          	li	a1,40
 7b0:	bff1                	j	78c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7b2:	008b0913          	addi	s2,s6,8
 7b6:	000b4583          	lbu	a1,0(s6)
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	d98080e7          	jalr	-616(ra) # 554 <putc>
 7c4:	8b4a                	mv	s6,s2
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	bd65                	j	680 <vprintf+0x60>
        putc(fd, c);
 7ca:	85d2                	mv	a1,s4
 7cc:	8556                	mv	a0,s5
 7ce:	00000097          	auipc	ra,0x0
 7d2:	d86080e7          	jalr	-634(ra) # 554 <putc>
      state = 0;
 7d6:	4981                	li	s3,0
 7d8:	b565                	j	680 <vprintf+0x60>
        s = va_arg(ap, char*);
 7da:	8b4e                	mv	s6,s3
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	b54d                	j	680 <vprintf+0x60>
    }
  }
}
 7e0:	70e6                	ld	ra,120(sp)
 7e2:	7446                	ld	s0,112(sp)
 7e4:	74a6                	ld	s1,104(sp)
 7e6:	7906                	ld	s2,96(sp)
 7e8:	69e6                	ld	s3,88(sp)
 7ea:	6a46                	ld	s4,80(sp)
 7ec:	6aa6                	ld	s5,72(sp)
 7ee:	6b06                	ld	s6,64(sp)
 7f0:	7be2                	ld	s7,56(sp)
 7f2:	7c42                	ld	s8,48(sp)
 7f4:	7ca2                	ld	s9,40(sp)
 7f6:	7d02                	ld	s10,32(sp)
 7f8:	6de2                	ld	s11,24(sp)
 7fa:	6109                	addi	sp,sp,128
 7fc:	8082                	ret

00000000000007fe <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7fe:	715d                	addi	sp,sp,-80
 800:	ec06                	sd	ra,24(sp)
 802:	e822                	sd	s0,16(sp)
 804:	1000                	addi	s0,sp,32
 806:	e010                	sd	a2,0(s0)
 808:	e414                	sd	a3,8(s0)
 80a:	e818                	sd	a4,16(s0)
 80c:	ec1c                	sd	a5,24(s0)
 80e:	03043023          	sd	a6,32(s0)
 812:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 816:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 81a:	8622                	mv	a2,s0
 81c:	00000097          	auipc	ra,0x0
 820:	e04080e7          	jalr	-508(ra) # 620 <vprintf>
}
 824:	60e2                	ld	ra,24(sp)
 826:	6442                	ld	s0,16(sp)
 828:	6161                	addi	sp,sp,80
 82a:	8082                	ret

000000000000082c <printf>:

void
printf(const char *fmt, ...)
{
 82c:	711d                	addi	sp,sp,-96
 82e:	ec06                	sd	ra,24(sp)
 830:	e822                	sd	s0,16(sp)
 832:	1000                	addi	s0,sp,32
 834:	e40c                	sd	a1,8(s0)
 836:	e810                	sd	a2,16(s0)
 838:	ec14                	sd	a3,24(s0)
 83a:	f018                	sd	a4,32(s0)
 83c:	f41c                	sd	a5,40(s0)
 83e:	03043823          	sd	a6,48(s0)
 842:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 846:	00840613          	addi	a2,s0,8
 84a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 84e:	85aa                	mv	a1,a0
 850:	4505                	li	a0,1
 852:	00000097          	auipc	ra,0x0
 856:	dce080e7          	jalr	-562(ra) # 620 <vprintf>
}
 85a:	60e2                	ld	ra,24(sp)
 85c:	6442                	ld	s0,16(sp)
 85e:	6125                	addi	sp,sp,96
 860:	8082                	ret

0000000000000862 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 862:	1141                	addi	sp,sp,-16
 864:	e422                	sd	s0,8(sp)
 866:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 868:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86c:	00000797          	auipc	a5,0x0
 870:	2047b783          	ld	a5,516(a5) # a70 <freep>
 874:	a805                	j	8a4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 876:	4618                	lw	a4,8(a2)
 878:	9db9                	addw	a1,a1,a4
 87a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 87e:	6398                	ld	a4,0(a5)
 880:	6318                	ld	a4,0(a4)
 882:	fee53823          	sd	a4,-16(a0)
 886:	a091                	j	8ca <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 888:	ff852703          	lw	a4,-8(a0)
 88c:	9e39                	addw	a2,a2,a4
 88e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 890:	ff053703          	ld	a4,-16(a0)
 894:	e398                	sd	a4,0(a5)
 896:	a099                	j	8dc <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 898:	6398                	ld	a4,0(a5)
 89a:	00e7e463          	bltu	a5,a4,8a2 <free+0x40>
 89e:	00e6ea63          	bltu	a3,a4,8b2 <free+0x50>
{
 8a2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a4:	fed7fae3          	bgeu	a5,a3,898 <free+0x36>
 8a8:	6398                	ld	a4,0(a5)
 8aa:	00e6e463          	bltu	a3,a4,8b2 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ae:	fee7eae3          	bltu	a5,a4,8a2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8b2:	ff852583          	lw	a1,-8(a0)
 8b6:	6390                	ld	a2,0(a5)
 8b8:	02059713          	slli	a4,a1,0x20
 8bc:	9301                	srli	a4,a4,0x20
 8be:	0712                	slli	a4,a4,0x4
 8c0:	9736                	add	a4,a4,a3
 8c2:	fae60ae3          	beq	a2,a4,876 <free+0x14>
    bp->s.ptr = p->s.ptr;
 8c6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8ca:	4790                	lw	a2,8(a5)
 8cc:	02061713          	slli	a4,a2,0x20
 8d0:	9301                	srli	a4,a4,0x20
 8d2:	0712                	slli	a4,a4,0x4
 8d4:	973e                	add	a4,a4,a5
 8d6:	fae689e3          	beq	a3,a4,888 <free+0x26>
  } else
    p->s.ptr = bp;
 8da:	e394                	sd	a3,0(a5)
  freep = p;
 8dc:	00000717          	auipc	a4,0x0
 8e0:	18f73a23          	sd	a5,404(a4) # a70 <freep>
}
 8e4:	6422                	ld	s0,8(sp)
 8e6:	0141                	addi	sp,sp,16
 8e8:	8082                	ret

00000000000008ea <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8ea:	7139                	addi	sp,sp,-64
 8ec:	fc06                	sd	ra,56(sp)
 8ee:	f822                	sd	s0,48(sp)
 8f0:	f426                	sd	s1,40(sp)
 8f2:	f04a                	sd	s2,32(sp)
 8f4:	ec4e                	sd	s3,24(sp)
 8f6:	e852                	sd	s4,16(sp)
 8f8:	e456                	sd	s5,8(sp)
 8fa:	e05a                	sd	s6,0(sp)
 8fc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8fe:	02051493          	slli	s1,a0,0x20
 902:	9081                	srli	s1,s1,0x20
 904:	04bd                	addi	s1,s1,15
 906:	8091                	srli	s1,s1,0x4
 908:	0014899b          	addiw	s3,s1,1
 90c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 90e:	00000517          	auipc	a0,0x0
 912:	16253503          	ld	a0,354(a0) # a70 <freep>
 916:	c515                	beqz	a0,942 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 918:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 91a:	4798                	lw	a4,8(a5)
 91c:	02977f63          	bgeu	a4,s1,95a <malloc+0x70>
 920:	8a4e                	mv	s4,s3
 922:	0009871b          	sext.w	a4,s3
 926:	6685                	lui	a3,0x1
 928:	00d77363          	bgeu	a4,a3,92e <malloc+0x44>
 92c:	6a05                	lui	s4,0x1
 92e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 932:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 936:	00000917          	auipc	s2,0x0
 93a:	13a90913          	addi	s2,s2,314 # a70 <freep>
  if(p == (char*)-1)
 93e:	5afd                	li	s5,-1
 940:	a88d                	j	9b2 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 942:	00000797          	auipc	a5,0x0
 946:	13678793          	addi	a5,a5,310 # a78 <base>
 94a:	00000717          	auipc	a4,0x0
 94e:	12f73323          	sd	a5,294(a4) # a70 <freep>
 952:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 954:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 958:	b7e1                	j	920 <malloc+0x36>
      if(p->s.size == nunits)
 95a:	02e48b63          	beq	s1,a4,990 <malloc+0xa6>
        p->s.size -= nunits;
 95e:	4137073b          	subw	a4,a4,s3
 962:	c798                	sw	a4,8(a5)
        p += p->s.size;
 964:	1702                	slli	a4,a4,0x20
 966:	9301                	srli	a4,a4,0x20
 968:	0712                	slli	a4,a4,0x4
 96a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 96c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 970:	00000717          	auipc	a4,0x0
 974:	10a73023          	sd	a0,256(a4) # a70 <freep>
      return (void*)(p + 1);
 978:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 97c:	70e2                	ld	ra,56(sp)
 97e:	7442                	ld	s0,48(sp)
 980:	74a2                	ld	s1,40(sp)
 982:	7902                	ld	s2,32(sp)
 984:	69e2                	ld	s3,24(sp)
 986:	6a42                	ld	s4,16(sp)
 988:	6aa2                	ld	s5,8(sp)
 98a:	6b02                	ld	s6,0(sp)
 98c:	6121                	addi	sp,sp,64
 98e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 990:	6398                	ld	a4,0(a5)
 992:	e118                	sd	a4,0(a0)
 994:	bff1                	j	970 <malloc+0x86>
  hp->s.size = nu;
 996:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 99a:	0541                	addi	a0,a0,16
 99c:	00000097          	auipc	ra,0x0
 9a0:	ec6080e7          	jalr	-314(ra) # 862 <free>
  return freep;
 9a4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9a8:	d971                	beqz	a0,97c <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9aa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ac:	4798                	lw	a4,8(a5)
 9ae:	fa9776e3          	bgeu	a4,s1,95a <malloc+0x70>
    if(p == freep)
 9b2:	00093703          	ld	a4,0(s2)
 9b6:	853e                	mv	a0,a5
 9b8:	fef719e3          	bne	a4,a5,9aa <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 9bc:	8552                	mv	a0,s4
 9be:	00000097          	auipc	ra,0x0
 9c2:	b7e080e7          	jalr	-1154(ra) # 53c <sbrk>
  if(p == (char*)-1)
 9c6:	fd5518e3          	bne	a0,s5,996 <malloc+0xac>
        return 0;
 9ca:	4501                	li	a0,0
 9cc:	bf45                	j	97c <malloc+0x92>
