#include <stdio.h>
#include <wiringPi.h>
#include<softPwm.h>

#define motor1 0
#define motor2 1

 int main(void){
	printf("Prueba motor\n");
	wiringPiSetup();
	softPwmCreate(motor1, 0, 50);
	softPwmCreate(motor2, 0, 50);
	for(;;) {
		softPwmWrite(motor1, 8);
		softPwmWrite(motor2, 16);
		delay(1000);
		softPwmWrite(motor1, 16);
		softPwmWrite(motor2, 8);
		delay(1000);
		softPwmWrite(motor1, 15);
		softPwmWrite(motor2, 15);
		delay(1000);
	}
	return 0;
}
