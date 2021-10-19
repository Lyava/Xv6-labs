#include "kernel/types.h"
#include "user.h"

void find_primes(int p[]){      //埃拉托斯特尼筛法
    close(p[1]);
    int prime;
    if(read(p[0], &prime, 4) > 0){
        fprintf(1, "prime %d\n", prime);    //第一个必为质数
    }

    int p_c[2];
    pipe(p_c);
    if(fork() == 0){    //子管道筛选下一个质数
        find_primes(p_c);
    }else{              //筛选prime倍数以外的数
        int num;
        close(p_c[0]);
        while(read(p[0], &num, 4) > 0){
            if(num % prime != 0){
                write(p_c[1], &num, 4);
            }
        }
        close(p_c[1]);
        wait(0);
    }
}

int main(){
    int p[2];
    pipe(p);
    if(fork() == 0){    //子进程筛选质数
        find_primes(p);
    }else{              //父进程装入数字
        close(p[0]);
        for(int i = 2; i<=35;i++){
            write(p[1], &i , 4);
        }
        close(p[1]);
        wait(0);    //??
    }
    exit(0);
}