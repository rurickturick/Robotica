//Apartado C
#include<stdio.h>
#include<wiringPi.h> 
#include<softPwm.h>

#define motor1 0	//17
#define motor2 1	//18
#define encoder1 5 	//24
#define encoder2 6	//25
#define sensor 4	//23
#define led 3		//22
#define pulsos 32	//pulsos para dar una vuelta
#define vueltas 2

int main(void){ 
	int valor1=0, valor2=0, cont=0, cont1=0, cont2=0;

	printf("Apartado C\n");
 
	delay(5000);

	wiringPiSetup();

	softPwmCreate(motor1, 0, 50);
	softPwmCreate(motor2, 0, 50);

 	pinMode(encoder1, INPUT);
	pinMode(encoder2, INPUT);
	pinMode(sensor, INPUT); 
	pinMode(led, OUTPUT);

		while(cont1<4 && cont2<4){
			softPwmWrite(motor1, 5);
			softPwmWrite(motor2, 30);
			valor1=digitalRead(encoder1);
			valor2=digitalRead(encoder2);
			printf("Cont1: %d\n", cont1);
			printf("Cont2: %d\n", cont2);
			if(valor1==0)
				cont1++;
			delay(20);
			if(valor2==0)
				cont2++;
			delay(20);
		} 
	return 0; 
}
