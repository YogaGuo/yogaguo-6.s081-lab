/*
 * @Description:
 * @Version: 2.0
 * @Autor: Yogaguo
 * @Date: 2022-06-17 20:22:39
 * @LastEditors: Yogaguo
 * @LastEditTime: 2022-06-18 13:54:46
 */
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/param.h"
#define SIZE 1024
int main(int argc, char *argv[])
{

    if (argc < 2)
    {
        fprintf(2, "Usage: %s <param>\n", argv[0]);
        exit(1);
    }
    if (argc + 1 > MAXARG)
    {
        fprintf(2, "too much argvs\n");
        exit(1);
    }
    char *full_argv[MAXARG];
    char input_argv[SIZE];
    for (int i = 1; i < argc; i++)
        full_argv[i - 1] = argv[i];

    full_argv[argc] = 0;
    int len;
    int i;
    while (1)
    {
        i = 0;
        while (1)
        {
            // read a line
            len = read(0, &input_argv[i], 1);
            if (len == 0 || input_argv[i] == '\n')
                break;
            i++;
        }
        if (i == 0)
            break;
        input_argv[i] = 0;
        full_argv[argc - 1] = input_argv;
        int pid = fork();
        if (pid < 0)
        {
            fprintf(2, "fork() error!\n");
            exit(1);
        }
        else if (pid == 0)
        {
            exec(full_argv[0], full_argv);
            fprintf(2, "exec() error!\n");
            exit(1);
        }
        else
        {
            wait((int *)0);
        }
    }
    exit(0);
}