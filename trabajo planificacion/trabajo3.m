close all; clear all;
% DATOS DE ENTRADA:

% Puntos objetivo:
p0=[5,1];
pD=[6,1];
pA=[10,11];
pF=[10,12];

% tiempo para cada segmento:
t1=2.6;
t2=2;
t3=2.6;
t4=2.6;
t5=2.6;

% --------------------------------------------------------

% Calculo de los tiempos intermedios:
t0=0;
tD=t0+t1;
tI1=tD+t2;
tI2=tI1+t3;
tA=tI2+t4;
tF=tA+t5;

% MATRIZ CON LAS ECUACIONES QUE HAY QUE RESOLVER:

% Se resuelve la matriz general de la memoria

M=[   t0^3,   t0^2,  t0,  1,         0,      0,   0,  0,         0,      0,    0,  0,        0,      0,    0,  0,         0,      0,    0,  0
    3*t0^2,   2*t0,   1,  0,         0,      0,   0,  0,         0,      0,    0,  0,        0,      0,    0,  0,         0,      0,    0,  0
    3*2*t0,      2,   0,  0,         0,      0,   0,  0,         0,      0,    0,  0,        0,      0,    0,  0,         0,      0,    0,  0
      tD^3,   tD^2,  tD,  1,     -tD^3,  -tD^2, -tD, -1,         0,      0,    0,  0,        0,      0,    0,  0,         0,      0,    0,  0
    3*tD^2,   2*tD,   1,  0,   -3*tD^2,  -2*tD,  -1,  0,         0,      0,    0,  0,        0,      0,    0,  0,         0,      0,    0,  0
    3*2*tD,      2,   0,  0,   -3*2*tD,     -2,   0,  0,         0,      0,    0,  0,        0,      0,    0,  0,         0,      0,    0,  0
      tD^3,   tD^2,  tD,  1,         0,      0,   0,  0,         0,      0,    0,  0,        0,      0,    0,  0,         0,      0,    0,  0
         0,      0,   0,  0,     tI1^3,  tI1^2, tI1,  1,    -tI1^3, -tI1^2, -tI1, -1,        0,      0,    0,  0,         0,      0,    0,  0
         0,      0,   0,  0,   3*tI1^2,  2*tI1,   1,  0,  -3*tI1^2, -2*tI1,   -1,  0,        0,      0,    0,  0,         0,      0,    0,  0  
         0,      0,   0,  0,   3*2*tI1,      2,   0,  0,  -3*2*tI1,     -2,    0,  0,        0,      0,    0,  0,         0,      0,    0,  0
         0,      0,   0,  0,         0,      0,   0,  0,     tI2^3,  tI2^2,  tI2,  1,   -tI2^3, -tI2^2, -tI2, -1,         0,      0,    0,  0
         0,      0,   0,  0,         0,      0,   0,  0,   3*tI2^2,  2*tI2,    1,  0, -3*tI2^2, -2*tI2,   -1,  0,         0,      0,    0,  0
         0,      0,   0,  0,         0,      0,   0,  0,   3*2*tI2,      2,    0,  0, -3*2*tI2,     -2,    0,  0,         0,      0,    0,  0
         0,      0,   0,  0,         0,      0,   0,  0,         0,      0,    0,  0,     tA^3,   tA^2,   tA,  1,     -tA^3,  -tA^2,  -tA, -1
         0,      0,   0,  0,         0,      0,   0,  0,         0,      0,    0,  0,   3*tA^2,   2*tA,    1,  0,   -3*tA^2,  -2*tA,   -1,  0  
         0,      0,   0,  0,         0,      0,   0,  0,         0,      0,    0,  0,   3*2*tA,      2,    0,  0,   -3*2*tA,     -2,    0,  0
         0,      0,   0,  0,         0,      0,   0,  0,         0,      0,    0,  0,     tA^3,   tA^2,   tA,  1,         0,      0,    0,  0
         0,      0,   0,  0,         0,      0,   0,  0,         0,      0,    0,  0,        0,      0,    0,  0,      tF^3,   tF^2,   tF,  1
         0,      0,   0,  0,         0,      0,   0,  0,         0,      0,    0,  0,        0,      0,    0,  0,    3*tF^2,   2*tF,    1,  0
         0,      0,   0,  0,         0,      0,   0,  0,         0,      0,    0,  0,        0,      0,    0,  0,    3*2*tF,      2,    0,  0];
       

Bx=[p0(1), 0, 0, 0, 0, 0, pD(1), 0, 0, 0, 0, 0, 0, 0, 0, 0, pA(1), pF(1), 0, 0]';
By=[p0(2), 0, 0, 0, 0, 0, pD(2), 0, 0, 0, 0, 0, 0, 0, 0, 0, pA(2), pF(2), 0, 0]';

% RESOLVER LAS ECUACIONES:

% Ecuación:  M*pX=Bx
pX=M\Bx;
% Ecuación:  M*pY=By
pY=M\By;

% SOLUCIÓN PARA CADA VARIABLE (X,Y)

% Coeficientes de X e Y para las curvas 1,2,3,4,5:
pX1=pX(1:4);
pX2=pX(5:8);
pX3=pX(9:12);
pX4=pX(13:16);
pX5=pX(17:20);
pY1=pY(1:4);
pY2=pY(5:8);
pY3=pY(9:12);
pY4=pY(13:16);
pY5=pY(17:20);

% ----------------------------------------------------

% CÁLCULO DE LOS PUNTOS (DIBUJO):

% Cálculo de la curva, la velocidad y la aceleración:
t1=t0:0.1:tD;
t2=tD:0.1:tI1;
t3=tI1:0.1:tI2;
t4=tI2:0.1:tA;
t5=tA:0.1:tF;

% Posición:
x1=polyval(pX1,t1);
y1=polyval(pY1,t1);
x2=polyval(pX2,t2);
y2=polyval(pY2,t2);
x3=polyval(pX3,t3);
y3=polyval(pY3,t3);
x4=polyval(pX4,t4);
y4=polyval(pY4,t4);
x5=polyval(pX5,t5);
y5=polyval(pY5,t5);

% Velocidad:
dpX1=polyder(pX1);
dpY1=polyder(pY1);
dpX2=polyder(pX2);
dpY2=polyder(pY2);
dpX3=polyder(pX3);
dpY3=polyder(pY3);
dpX4=polyder(pX4);
dpY4=polyder(pY4);
dpX5=polyder(pX5);
dpY5=polyder(pY5);
dx1=polyval(dpX1,t1);
dy1=polyval(dpY1,t1);
dx2=polyval(dpX2,t2);
dy2=polyval(dpY2,t2);
dx3=polyval(dpX3,t3);
dy3=polyval(dpY3,t3);
dx4=polyval(dpX4,t4);
dy4=polyval(dpY4,t4);
dx5=polyval(dpX5,t5);
dy5=polyval(dpY5,t5);

% Aceleración:
ddpX1=polyder(dpX1);
ddpY1=polyder(dpY1);
ddpX2=polyder(dpX2);
ddpY2=polyder(dpY2);
ddpX3=polyder(dpX3);
ddpY3=polyder(dpY3);
ddpX4=polyder(dpX4);
ddpY4=polyder(dpY4);
ddpX5=polyder(dpX5);
ddpY5=polyder(dpY5);
ddx1=polyval(ddpX1,t1);
ddy1=polyval(ddpY1,t1);
ddx2=polyval(ddpX2,t2);
ddy2=polyval(ddpY2,t2);
ddx3=polyval(ddpX3,t3);
ddy3=polyval(ddpY3,t3);
ddx4=polyval(ddpX4,t4);
ddy4=polyval(ddpY4,t4);
ddx5=polyval(ddpX5,t5);
ddy5=polyval(ddpY5,t5);

% Dibujo de la solución:

figure
%dibujado obstaculo
x=[5,9,9,5,5];
y=[5,5,8,8,5];
plot(x,y,'black');
hold on;
%dibujado trayectoria
plot(x1,y1,'c',x2,y2,'b',x3,y3,'r',x4,y4,'g',x5,y5,'m',p0(1),p0(2),'o',pD(1),pD(2),'x',pA(1),pA(2),'*',pF(1),pF(2),'d')

title('Curvas 1 (cyan), 2 (azul), 3 (rojo), 4 (verde), 5 (magenta)');
%dibujado graficas posición, velocidad, aceleración
figure

subplot(4,2,1), plot(t1,x1,'c',t2,x2,'b',t3,x3,'r',t4,x4,'g',t5,x5,'m'),title('x(t)')
subplot(4,2,2), plot(t1,y1,'c',t2,y2,'b',t3,y3,'r',t4,y4,'g',t5,y5,'m'),title('y(t)')
subplot(4,2,3), plot(t1,dx1,'c',t2,dx2,'b',t3,dx3,'r',t4,dx4,'g',t5,dx5,'m'),title('dx(t)')
subplot(4,2,4), plot(t1,dy1,'c',t2,dy2,'b',t3,dy3,'r',t4,dy4,'g',t5,dy5,'m'),title('dy(t)')
subplot(4,2,5), plot(t1,ddx1,'c',t2,ddx2,'b',t3,ddx3,'r',t4,ddx4,'g',t5,ddx5,'m'),title('ddx(t)')
subplot(4,2,6), plot(t1,ddy1,'c',t2,ddy2,'b',t3,ddy3,'r',t4,ddy4,'g',t5,ddy5,'m'),title('ddy(t)')
subplot(4,2,7), text (0.1,0.5,sprintf('El tiempo del recorrido es %.2f segundos',tF))