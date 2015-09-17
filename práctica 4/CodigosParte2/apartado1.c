//Apartado 1
#include<stdio.h>
#include<wiringPi.h> 
#include<softPwm.h>

#define motor1 0	//17
#define motor2 1	//18
#define encoder1 5 	//24
#define encoder2 6	//25
#define sensor 4	//23
#define led 3		//22
#define cinco_cm 4
#define diez_gr 6

int main(void){ 
	int valor1=0, valor2=0, cont1=0, cont2=0;
	int mov[]={40, 45, 40, -45, 40};
	int l_mov=5;
	int i = 0;

	printf("Apartado 1\n");
 
	delay(10000);

	wiringPiSetup();

	softPwmCreate(motor1, 0, 50);
	softPwmCreate(motor2, 0, 50);

 	pinMode(encoder1, INPUT);
	pinMode(encoder2, INPUT);
	pinMode(sensor, INPUT); 
	pinMode(led, OUTPUT);
	
	for(i=0; i<l_mov; i++){
		int lect=mov[i];
		cont1=0;
		cont2=0;
		if(i%2==0){ // Esto es un avance
			if(lect>0){ // Avance
				while((cont1<(lect/5)*cinco_cm) && (cont2<(lect/5)*cinco_cm)){
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
			}
			else{ //Marcha atras
				while((cont1<(lect/-5)*cinco_cm) && (cont2<(lect/-5)*cinco_cm)){
					softPwmWrite(motor1, 30);
					softPwmWrite(motor2, 5);
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
			}
		}
		else{ //Giro
			if(lect>0){ //Giro izquierda
				while((cont1<(lect/10)*diez_gr) && (cont2<(lect/10)*diez_gr)){
					softPwmWrite(motor1, 5);
					softPwmWrite(motor2, 5);
					valor1=digitalRead(encoder1);
					valor2=digitalRead(encoder2);
					printf("Cont1: %d\n", cont1);
					printf("Cont2: %d\n", cont2);
					if(valor1==0)
						cont1++;
					delay(4.6);
					if(valor2==0)
						cont2++;
					delay(4.6);
				}
			}
			else{ //Giro derecha
				while((cont1<(lect/-10)*diez_gr) && (cont2<(lect/-10)*diez_gr)){
					softPwmWrite(motor1, 30);
					softPwmWrite(motor2, 30);
					valor1=digitalRead(encoder1);
					valor2=digitalRead(encoder2);
					printf("Cont1: %d\n", cont1);
					printf("Cont2: %d\n", cont2);
					if(valor1==0)
						cont1++;
					delay(4.6);
					if(valor2==0)
						cont2++;
					delay(4.6);
				}
			}
		}
	} 
	return 0; 
}
