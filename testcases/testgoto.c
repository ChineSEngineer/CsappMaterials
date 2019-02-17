#include<stdio.h>
int main(){
	for(int i=0; i<10;i++){
		if(i == 5){
			goto xx;
		}	
	}
	printf("1");
	return 1;
xx:
	printf("0");
	return 0;
}
