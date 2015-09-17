//Apartado 2
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

void giraIzq(int grados){
	int valor1=0, valor2=0, cont1=0, cont2=0;
	while(cont1<=(grados/10)*diez_gr && cont2<=(grados/10)*diez_gr){
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

void giraDer(int grados){
	int valor1=0, valor2=0, cont1=0, cont2=0;
	while(cont1<=(grados/10)*diez_gr && cont2<=(grados/10)*diez_gr){
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

void avanza(int distancia){
	int valor1=0, valor2=0, cont1=0, cont2=0;
	while(cont1<=(distancia/5)*cinco_cm && cont2<=(distancia/5)*cinco_cm && digitalRead(sensor)!=1){
		softPwmWrite(motor1, 5);
		softPwmWrite(motor2, 30);
		valor1=digitalRead(encoder1);
		valor2=digitalRead(encoder2);
		printf("Cont1: %d\n", cont1);
		printf("Cont2: %d\n", cont2);
		digitalWrite(led, LOW);
		if(valor1==0)
			cont1++;
		delay(20);
		if(valor2==0)
			cont2++;
		delay(20);
	}
	softPwmWrite(motor1, 15);
	softPwmWrite(motor2, 15);
	giraIzq(90);
	int c1=0,c2=0;
	while(c1<=(20/5)*cinco_cm && c2<=(20/5)*cinco_cm){
		softPwmWrite(motor1, 5);
		softPwmWrite(motor2, 30);
		valor1=digitalRead(encoder1);
		valor2=digitalRead(encoder2);
		digitalWrite(led, LOW);
		if(valor1==0)
			c1++;
		if(valor2==0)
			c2++;
		cont1=0;
		cont2=0;
	}
	while(digitalRead(sensor)){
		delay(500);
		digitalWrite(led, HIGH);
		delay(500);
		digitalWrite(led, LOW);
	}
}

void retrocede(int distancia){
	int valor1=0, valor2=0, cont1=0, cont2=0;
	while(cont1<=(distancia/5)*cinco_cm && cont2<=(distancia/5)*cinco_cm){
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

int main(void){ 
	int valor1=0, valor2=0, cont1=0, cont2=0;
	int p_ini[]={0, 0, 1}; //Primer valor x, segundo la y y tercer valor indica la orientacion 1 norte, 2 oeste, 3 sur y 4 este
	int p_fin[]={40,40, 1};
	int p_act[]={0, 0, 1};

	printf("Apartado 2\n");
	
	delay(10000);

	wiringPiSetup();

	softPwmCreate(motor1, 0, 50);
	softPwmCreate(motor2, 0, 50);

 	pinMode(encoder1, INPUT);
	pinMode(encoder2, INPUT);
	pinMode(sensor, INPUT); 
	pinMode(led, OUTPUT);
	
	while(p_act[0]!=p_fin[0] &&  p_act[1]!=p_fin[1]){
		if(p_act[2]!=4){
			switch(p_act[2]){
				case 1: giraDer(90); break;
				case 2: giraDer(180); break;
				case 3: giraIzq(90); break;
				default: printf("malo");
			}
			p_act[2]=4;
		}
		avanza(p_fin[0]-p_act[0]);
		p_act[0]+=p_fin[0]-p_act[0];
		if(p_act[2]!=p_fin[2]){
			switch(p_fin[2]){
				case 1: giraIzq(90); break;
				case 2: giraDer(180); break;
				case 3: giraDer(90); break;
			}
			p_act[2]=p_fin[2];
		}
		avanza(p_fin[1]-p_act[1]);
		p_act[1]+=p_fin[1]-p_act[1];
	
	} 
	return 0; 
}
