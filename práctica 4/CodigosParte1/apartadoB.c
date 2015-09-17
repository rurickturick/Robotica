//Apartada B
#include<stdio.h>
#include<wiringPi.h> 
#include<softPwm.h>

#define motor1 0	//17
#define motor2 1	//18
#define encoder1 5	//24
#define encoder2 6	//25
#define led 3		//22

int main(void){ 
	int valor1=0, valor2=0, cont=0;
	
	printf("Apartado B\n");

	delay(10000);

	wiringPiSetup();

	softPwmCreate(motor1, 0, 50);
	softPwmCreate(motor2, 0, 50);

	pinMode(encoder1, INPUT);
	pinMode(encoder2, INPUT);
	pinMode(led, OUTPUT);

	while(cont!=171){
		softPwmWrite(motor1, 5);
		softPwmWrite(motor2, 30);
		while(cont<171){
			valor1=digitalRead(encoder1);
			valor2=digitalRead(encoder2);
			if(valor1==0)	//Si es blanco se incrementa el contador
				cont++;
			printf("%d\n", cont);
			digitalWrite(led, LOW);
			delay(40);
	}
	softPwmWrite(motor1, 15);	//Paramos el robot
	softPwmWrite(motor2, 15);
	printf("Robot parado\n");
	digitalWrite(led, HIGH);
	}
	return 0;
}
