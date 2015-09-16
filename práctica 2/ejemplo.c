#include <wiringPi.h>
#include <stdio.h>
#include <stdlib.h>
#include <softPwm.h>

int main(void){
  wiringPiSetup();
  int i;
  char a;
  for(i=0; i<100; i++){
    softPwmCreate(0, 0, 50);
    printf("%d",i);
    softPwmWrite(0, i);
    getchar();
  }
  return 0;
}