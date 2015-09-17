#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <wiringPi.h>
#include <softPwm.h>

// 17 - 18 - 21 - 22 - 23 - 24 -  25  GPIO
// 0  - 1  - 2  - X -  4  - 5  -  6   WIRING PI!!
/* PINES */
#define MOT_IZQ     1 // 18
#define MOT_DCH     0  // 17
#define ENC_RUEDA_DCH   6 // 25
#define ENC_RUEDA_IZQ   5 // 24
#define LED 3
#define SENSOR_DELANTERO 4 // 23
/* CONSTANTES */
#define PI 3.14159265359
#define RADIO_RUEDA 4.5 // cm
#define DIVISIONES_RUEDA 30
#define DISTANCIA_RUEDAS 16 
#define DISTANCIA_POR_DIVISION RADIO_RUEDA/DIVISIONES_RUEDA
#define VEL_MAX     24 
#define VEL_MIN     6 
#define VEL_PARADA  15.05
#define MUESTREO  1 //en milisegundos
#define EPSILON (2*PI*RADIO_RUEDA) / DIVISIONES_RUEDA


int POS_X_ROBOT = 0;
int POS_Y_ROBOT = 0; 

float leer_encoder_digital(int encoder){
  return digitalRead(encoder);
}

float leer_encoder_analogico(int encoder){
	return analogRead(encoder);
}

float detectar_obstaculo(){
  return digitalRead(SENSOR_DELANTERO);
}

float abs(float f){
	return (f>0) ? f : -f; 
}


float distanciaPuntos(int x1, int y1, int x2, int y2){
	return sqrt(pow(x1-x2,2) + pow(y1-y2,2));	
}
// x1 , y1 -> robot
// x2 , y2 -> destino
float anguloPuntos(int x1 , int y1 , int x2 , int y2){

	float resultado = 0.0;	
	if(x2-x1 > 0){
			if(y2-y1 > 0){ // primer cuadrante
					resultado = (asin((y2-y1)/distanciaPuntos(x1,y1,x2,y2)))*-1;
			}else{ // cuarto cuadrante
				resultado =  (PI/2 + asin((fabs(y2-y1))/distanciaPuntos(x1,y1,x2,y2)))*-1;
			}
	}else{
			if(y2-y1 > 0){ // segundo cuadrante
					resultado = (asin((y2-y1)/distanciaPuntos(x1,y1,x2,y2)));
			}else{ // tercero cuadrante
				resultado = (PI/2 + asin((fabs(y2-y1))/distanciaPuntos(x1,y1,x2,y2)));
			}
	}
	return resultado * 180 / PI;

}


void experimento22(int x , int y){
	
	//calcular la ruta
	float angulo = anguloPuntos(POS_X_ROBOT,POS_Y_ROBOT,x,y);
	float distancia = distanciaPuntos(POS_X_ROBOT,POS_Y_ROBOT,x,y);
	girar(angulo);
	int error = moverConObs(distancia);
	while(error == -1 ){
		delay(1000);
		mover(-30);
		girar(-30);
		error = moverconObs(100);
		if(error==0){
		float angulo = anguloPuntos(POS_X_ROBOT,POS_Y_ROBOT,x,y);
		float distancia = distanciaPuntos(POS_X_ROBOT,POS_Y_ROBOT,x,y);
		girar(angulo);
		int error = moverConObs(distancia);
		}
	
		


	}
	

}

void girar(float theta){
	
	//int num_giros = ((DIVISIONES_RUEDA * theta ) / (2*PI)) +0.5f ; //for rounding ;
	theta = (theta * PI) / 180;
	int distancia = (theta * DISTANCIA_RUEDAS ) / 2; 
	//int distancia = 25;
	int fin = 0;
	int obstaculo = 0;
	float distancia_recorrida_dch = 0.0;
	float distancia_recorrida_izq = 0.0;
	float nr,nl,nr_antiguo, nl_antiguo;
	int divisiones_recorridas_dch = 0;
	int divisiones_recorridas_izq = 0;
	int velocidad = VEL_MAX;

	if(theta > 0){
			velocidad = VEL_MIN;
	}else{
		distancia *= -1;
	}
	
		
	while(fin==0){
		//fprintf(stdout , "distancia GIRAR : %d\n" , distancia);	

	if((distancia_recorrida_dch - distancia_recorrida_izq) > EPSILON){
			softPwmWrite(MOT_IZQ,velocidad);
			softPwmWrite(MOT_DCH,VEL_PARADA);					
	}
	else if((distancia_recorrida_izq  - distancia_recorrida_dch)  > EPSILON){
			softPwmWrite(MOT_DCH,velocidad);
			softPwmWrite(MOT_IZQ,VEL_PARADA);					
	}else {
			softPwmWrite(MOT_IZQ,velocidad);
			softPwmWrite(MOT_DCH,velocidad);
	}
	
  	nr = digitalRead(ENC_RUEDA_DCH);
  	nl = digitalRead(ENC_RUEDA_IZQ);
		/*
    fprintf(stdout , "nr : %f\n" , nr);
		fprintf(stdout , "nr_antiguo : %f\n" , nr_antiguo);
		*/
    if(nr != nr_antiguo){
			divisiones_recorridas_dch++;
			nr_antiguo = nr;
   		distancia_recorrida_dch = ((RADIO_RUEDA * 2 * PI) * divisiones_recorridas_dch) / DIVISIONES_RUEDA;
		}
		if(nl != nl_antiguo){
			distancia_recorrida_izq = ((RADIO_RUEDA * 2 * PI) * divisiones_recorridas_izq) / DIVISIONES_RUEDA;
			divisiones_recorridas_izq++;
			nl_antiguo = nl;
		}
		//delay(MUESTREO);
	  /*  
		fprintf(stdout, "distancia dcha : %f\n " , distancia_recorrida_dch);
		fprintf(stdout ,"distancia izq : %f\n" , distancia_recorrida_izq);
		fprintf(stdout , "encoder dcha :%f\n" , nr_antiguo);
		*/
		if(distancia_recorrida_dch>distancia && distancia_recorrida_izq > distancia) fin=1;

  }
  softPwmWrite(MOT_DCH,VEL_PARADA);
  softPwmWrite(MOT_IZQ,VEL_PARADA);
   
}

void experimento21(int values[] , int n){
		
		
		fprintf(stdout,"sizeof values : %d\n" , sizeof(values));	
		int i =0;
		for(i=0; i < n ; i+=2){
			fprintf(stdout ,"experimento 21 : i : %d\n : n : %d\n" , i , n );
			mover(values[i]);
			delay(1000);
			girar(values[i+1]);	
			delay(1000);	
		}

}

int moverConObs(int distancia){

	int fin = 0;
	int obstaculo = 0;
	float distancia_recorrida_dch = 0.0;
	float distancia_recorrida_izq = 0.0;
	float nr,nl,nr_antiguo, nl_antiguo;
	int divisiones_recorridas_dch = 0;
	int divisiones_recorridas_izq = 0;
	
	int vel_izq , vel_dch;
	if(distancia > 0){
		vel_izq = VEL_MAX;
		vel_dch = VEL_MIN;	

	}else{
		distancia *=-1;
		vel_izq = VEL_MIN;
		vel_dch = VEL_MAX;
	}

  while(fin==0){
	
	if((distancia_recorrida_dch - distancia_recorrida_izq) > EPSILON){
			softPwmWrite(MOT_IZQ,vel_izq);
			softPwmWrite(MOT_DCH,VEL_PARADA);					
	}
	else if((distancia_recorrida_izq  - distancia_recorrida_dch)  > EPSILON){
			softPwmWrite(MOT_DCH,vel_dch);
			softPwmWrite(MOT_IZQ,VEL_PARADA);					
	}else {
			softPwmWrite(MOT_IZQ,vel_izq);
			softPwmWrite(MOT_DCH,vel_dch);
	}
	
	if(detectar_obstaculo()==1.0){		
		  softPwmWrite(MOT_DCH,VEL_PARADA);
		  softPwmWrite(MOT_IZQ,VEL_PARADA);
		
			return 1;		
		}
  	nr = digitalRead(ENC_RUEDA_DCH);
  	nl = digitalRead(ENC_RUEDA_IZQ);
		/*
    fprintf(stdout , "nr : %f\n" , nr);
		fprintf(stdout , "nr_antiguo : %f\n" , nr_antiguo);
		*/
    if(nr != nr_antiguo){
			divisiones_recorridas_dch++;
			nr_antiguo = nr;
   		distancia_recorrida_dch = ((RADIO_RUEDA * 2 * PI) * divisiones_recorridas_dch) / DIVISIONES_RUEDA;
		}

		if(nl != nl_antiguo){
			distancia_recorrida_izq = ((RADIO_RUEDA * 2 * PI) * divisiones_recorridas_izq) / DIVISIONES_RUEDA;
			divisiones_recorridas_izq++;
			nl_antiguo = nl;
		}

		delay(MUESTREO);
   
		
		//fprintf(stdout, "distancia dcha : %f\n " , distancia_recorrida_dch);
		//fprintf(stdout ,"distancia izq : %f\n" , distancia_recorrida_izq);
		//fprintf(stdout , "encoder dcha :%f\n" , nr_antiguo);
		
		if(distancia_recorrida_dch>distancia && distancia_recorrida_izq > distancia) fin=1;

  }
  softPwmWrite(MOT_DCH,VEL_PARADA);
  softPwmWrite(MOT_IZQ,VEL_PARADA);


	return 0;
}


void mover(int distancia){

	int fin = 0;
	int obstaculo = 0;
	float distancia_recorrida_dch = 0.0;
	float distancia_recorrida_izq = 0.0;
	float nr,nl,nr_antiguo, nl_antiguo;
	int divisiones_recorridas_dch = 0;
	int divisiones_recorridas_izq = 0;
	
	int vel_izq , vel_dch;
	if(distancia > 0){
		vel_izq = VEL_MAX;
		vel_dch = VEL_MIN;	

	}else{
		distancia *=-1;
		vel_izq = VEL_MIN;
		vel_dch = VEL_MAX;
	}

  while(fin==0){
	
	if((distancia_recorrida_dch - distancia_recorrida_izq) > EPSILON){
			softPwmWrite(MOT_IZQ,vel_izq);
			softPwmWrite(MOT_DCH,VEL_PARADA);					
	}
	else if((distancia_recorrida_izq  - distancia_recorrida_dch)  > EPSILON){
			softPwmWrite(MOT_DCH,vel_dch);
			softPwmWrite(MOT_IZQ,VEL_PARADA);					
	}else {
			softPwmWrite(MOT_IZQ,vel_izq);
			softPwmWrite(MOT_DCH,vel_dch);
	}
	
	/*while(detectar_obstaculo()==1.0){		
  		softPwmWrite(MOT_DCH,VEL_PARADA);
  		softPwmWrite(MOT_IZQ,VEL_PARADA);	
			digitalWrite(LED,HIGH);
			delay(500);
			digitalWrite(LED,LOW);
			delay(500);		
		}*/
  	nr = digitalRead(ENC_RUEDA_DCH);
  	nl = digitalRead(ENC_RUEDA_IZQ);
		/*
    fprintf(stdout , "nr : %f\n" , nr);
		fprintf(stdout , "nr_antiguo : %f\n" , nr_antiguo);
		*/
    if(nr != nr_antiguo){
			divisiones_recorridas_dch++;
			nr_antiguo = nr;
   		distancia_recorrida_dch = ((RADIO_RUEDA * 2 * PI) * divisiones_recorridas_dch) / DIVISIONES_RUEDA;
		}

		if(nl != nl_antiguo){
			distancia_recorrida_izq = ((RADIO_RUEDA * 2 * PI) * divisiones_recorridas_izq) / DIVISIONES_RUEDA;
			divisiones_recorridas_izq++;
			nl_antiguo = nl;
		}

		delay(MUESTREO);
   
		
		//fprintf(stdout, "distancia dcha : %f\n " , distancia_recorrida_dch);
		//fprintf(stdout ,"distancia izq : %f\n" , distancia_recorrida_izq);
		//fprintf(stdout , "encoder dcha :%f\n" , nr_antiguo);
		
		if(distancia_recorrida_dch>distancia && distancia_recorrida_izq > distancia) fin=1;

  }
  softPwmWrite(MOT_DCH,VEL_PARADA);
  softPwmWrite(MOT_IZQ,VEL_PARADA);

}
void experimento1(){
	digitalWrite(LED,LOW); 
 	mover(1000);
	//encender led
	digitalWrite(LED,HIGH);
}

void setup(){
  softPwmCreate (MOT_DCH, 0, 25);
  softPwmCreate (MOT_IZQ, 0, 25);
  pinMode(SENSOR_DELANTERO,INPUT); 
  pinMode(ENC_RUEDA_DCH,INPUT); 
  pinMode(ENC_RUEDA_IZQ,INPUT); 
  pinMode(LED,OUTPUT); 

}
int main () {

  if (wiringPiSetup () == -1) { // No está cargada la librería
    fprintf (stdout, "oops: %s\n", strerror (errno)) ;
    return 1 ;
  }
	setup();
	delay(5);
	//experimento1();
	//girar(180);
	int n = 2;
	int values[2] = { 20 , 45 };

	//mover(2000);
	//experimento21(values,n);
	fprintf(stdout , "%f\n" , anguloPuntos(0,0,1,1));
	fprintf(stdout , "%f\n" , anguloPuntos(0,0,-1,1));
	fprintf(stdout , "%f\n" , anguloPuntos(0,0,-1,-1));
	fprintf(stdout , "%f\n" , anguloPuntos(0,0,1,-1));
	return 0;
}
