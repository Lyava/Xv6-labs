#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/param.h"

int main(int argc, char*argv[]){
    if (argc < 2)
    {
        fprintf(2, "usage: xargs command\n");
        exit(1);
    }
    char *argv_c[MAXARG];   //argv in child process
    char arc;
    while(1){
        for(int i = 1; i < argc; i++){
            argv_c[i-1] = argv[i];
        }
        char *temp = (char*)malloc(512);
        int tempc = 0;  //tempc记录temp的尾字符
        int argc_c = argc - 1;
        if(read(0, &arc, 1) <= 0){   //ctrl+D退出
            exit(0);
        }
        while(arc != '\n'){
            printf("%c\n", arc);
            if(arc == ' '){
                argv_c[argc_c++] = temp;
                temp = 0;
            }else{
                temp[tempc++] = arc;
                printf("%s",temp);
                read(0, &arc, 1);
            }
        }
        argv_c[argc_c++] = temp;
        argv_c[argc_c] = 0;
        //printf("%s", temp);
        if(fork() == 0){
            exec(argv_c[0], argv_c);
        }else{
            wait(0);
        }
    }
    exit(0);
}