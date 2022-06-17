/*
 * @Description:
 * @Version: 2.0
 * @Autor: Yogaguo
 * @Date: 2022-06-17 18:25:41
 * @LastEditors: Yogaguo
 * @LastEditTime: 2022-06-17 18:58:11
 */
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define BUFSIZE 2
int main(int argc, char *argv[])
{
    int p1[2];
    int p2[2];
    char buf[BUFSIZE];
    pipe(p1);
    pipe(p2);
    int pid = fork();
    if (pid < 0)
    {
        fprintf(2, "fork() error");
        exit(1);
    }
    if (pid == 0)
    {
        close(p1[1]);
        close(p2[0]);
        read(p1[0], buf, BUFSIZE);
        fprintf(1, "<%d>: reveived ping\n", getpid());
        write(p2[1], "1", 1);
    }
    else
    {
        close(p1[0]);
        close(p2[1]);
        write(p1[1], "1", 1);
        read(p2[0], buf, BUFSIZE);
        fprintf(1, "<%d>: received pong\n", getpid());
        wait((int *)0);
    }
    exit(0);
}