#include<stdio.h>
#include<limits.h>
int tadd_ok(int x, int y){
    int sum = x + y;
    return !((sum <= 0 && x > 0 && y >0) || (sum >=0 && x < 0 && y < 0));
}

int tsub_ok(int x, int y){
    return tadd_ok(x, -y);
}

int tmul_ok_1(int x, int y){
    int p = x*y;
    return !x || p/x==y;
}

int tmul_ok_2(int x, int y){
    int_64t pll = (int_64t) x*y;
    return pll == (int) pll;
}

int main(){
    printf("%d", tsub_ok(0, (INT_MIN+1)));
    printf("%d",0-INT_MIN);
    return 1;
}
