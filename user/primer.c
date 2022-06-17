/*
 * @Description:
 * @Version: 2.0
 * @Autor: Yogaguo
 * @Date: 2022-06-17 19:03:31
 * @LastEditors: Yogaguo
 * @LastEditTime: 2022-06-17 20:15:03
 */
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void help(int left_pipe[])
{
    int num;
    read(left_pipe[0], &num, sizeof(num));
    if (num == -1)
        exit(0);
    printf("<pid: %d> primer: %d\n", getpid(), num);

    int right_pipe[2];
    pipe(right_pipe);
    int pid = fork();
    if (pid < 0)
    {
        fprintf(2, "fork() error!\n");
        exit(1);
    }
    else if (pid == 0)
    {
        close(right_pipe[1]);
        help(right_pipe);
    }
    else
    {
        int buf;
        close(right_pipe[0]);
        while (read(left_pipe[0], &buf, sizeof(buf)) != 0 && buf != -1)
        {
            if (buf % num != 0)
                write(right_pipe[1], &buf, sizeof(buf));
        }
        buf = -1;
        write(right_pipe[1], &buf, sizeof(buf));
        wait((int *)0);
        exit(0);
    }
}
int main(int argc, char *argv[])
{

    int left_pipe[2];

    pipe(left_pipe);

    int pid = fork();
    if (pid < 0)
    {
        fprintf(2, "fork() error!\n");
        exit(1);
    }
    else if (pid == 0)
    {
        close(left_pipe[1]);
        help(left_pipe);
    }
    else
    {
        close(left_pipe[0]);
        for (int i = 2; i <= 35; i++)
        {
            write(left_pipe[1], &i, sizeof(i));
        }
        int flag = -1;
        write(left_pipe[1], &flag, sizeof(flag));
        wait((int *)0);
    }
    exit(0);
}