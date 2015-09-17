#include <wiringPi.h>
#include <stdio.h>
#include <stdlib.h>
#include <softPwm.h>

int main(void){
	wiringPiSetup();
	int i;
	while(1){
		i=digitalRead(1);
		printf("%d", i);
		getchar();
	}
	return 0;
}