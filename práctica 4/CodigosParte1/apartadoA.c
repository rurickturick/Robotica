//Apartada A
#include<stdio.h>
#include<wiringPi.h> 
#include<softPwm.h>

#define motor1 0	//17
#define motor2 1	//18

int main(void){
	printf("Apartado A\n");
	
	delay(10000);
	wiringPiSetup();
	softPwmCreate(motor1, 0, 50);
	softPwmCreate(motor2, 0, 50);

	softPwmWrite(motor1, 5);
	softPwmWrite(motor2, 30);
	
	getchar();

	return 0;
}
