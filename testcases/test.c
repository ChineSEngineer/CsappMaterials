#include<stdio.h>
#include<math.h>
#include<limits.h>
int div16_complex(int m){
    return (m>>4) + ((m & 15) && 1) * ((m >> 31) && 1);
}

int div16(int m){
    return (m + (m & 0xF)) >> 4;
}

int main(){
    //printf("%u\n", (unsigned int) (-1));
    printf("%d\n", (int)(double)INT_MAX);
    printf("%d\n", (int)(float)INT_MAX);
}
