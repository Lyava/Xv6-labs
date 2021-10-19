#include "kernel/types.h"
#include "user.h"

int main(){
    // int p_f[2];     //父进程管道
    // int p_c[2];     //子进程管道
    // char * ping = "ping";
    // char * pong = "pong";
    // char buf[10];
    // if(pipe(p_c) < 0) return -1;
    // if(pipe(p_f) < 0) return -1;
    // int pid = fork();
    // if(pid == 0){   //当前状态如果是子进程
    //     close(p_c[0]);  //关闭p_c的读端
    //     close(p_f[1]);  //关闭p_f的写端
    //     sleep(1);
    //     while(read(p_f[0],buf,sizeof(buf)) > 0){
    //         printf("recieved %s",buf);
    //         write(p_c[1],ping,4);
    //     }
    //     close(p_c[1]);
    //     close(p_f[0]);
    //     exit(0);
    // }else if(pid > 0){
    //     close(p_c[1]);  //关闭p_c的读端
    //     close(p_f[0]);  //关闭p_f的写端
    //     sleep(1);
    //     while(read(p_c[0],buf,sizeof(buf)) > 0){
    //         printf("recieved %d",buf);
    //         write(p_f[1],pong,4);
    //     }
    //     close(p_c[0]);
    //     close(p_f[1]);
    //     exit(0);
    // }
    // exit(0);
    int p1[2];
    int p2[2];
    char p2c;
    char c2p;
    pipe(p1);
    pipe(p2);
    if(fork() == 0){
        close(p1[0]);
        close(p2[1]);
        if(read(p2[0],&p2c,1))
            fprintf(1,"%d: received ping\n", getpid());
        write(p1[1], "o", 1);
        close(p1[1]);

    }else{
        close(p1[1]);
        close(p2[0]);
        write(p2[1],"i", 1);
        if(read(p1[0],&c2p,1))
            fprintf(1, "%d: received pong\n", getpid());

        close(p2[1]);
    }
    exit(0);
}