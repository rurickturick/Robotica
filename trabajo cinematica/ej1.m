%% EJERCICIO 1 Cinemática directa e inversa
%% APARTADO A
% articulaciones del robot
l1 = link([0 13 0 6 0]);
l2 = link([pi 12 0 0 0]);
l3 = link([0 0 0 0 0]);
l4 = link([0 0 0 0 1]);

% creamos el robot
rob = robot({l1 l2 l3 l4});

% dibujamos el robot en la posicion del enunciado
plot(rob, [0 0 0 0])

% para poder jugar con el robot
drivebot(rob)

% se pausa hasta dar a espacio
pause

%% APARTADO B
% matriz de la primera articulación
m1 = [1 0 0 13
0 1 0 0
0 0 1 6
0 0 0 1];

% matriz de la segunda articulación
m2 = [1 0 0 12
0 -1 0 0
0 0 -1 0
0 0 0 1];

% matriz de la tercera articulación
m3 = [1 0 0 0
0 1 0 0
0 0 1 0
0 0 0 1];

% matriz de la cuarta articulación
m4 = [1 0 0 0
0 1 0 0
0 0 1 0
0 0 0 1];

% matriz efector final, solo multiplicamos por las dos primeras, porque las
% otras dos son la matriz identidad
mf = m1*m2;

% esto devuelve una matriz igual a mf
fkine(rob,[0 0 0 0])

%se pausa hasta dar a espacio
pause

%% APARTADO C
% esto devuelve el vector [0 0 0 0]
ikine(rob, mf) 

%se pausa hasta dar a espacio
pause

%% EJERCICIO 2  Movimiento y planificación
%%  APARTADO A
% cerramos todas las ventanas
close all

%crear el prisma del punto C
% definimos los vertices 
v1 = [0 0 0 1; 0 2 0 1; 0 2 4 1; 0 0 4 1; -2 0 0 1; -2 2 0 1; -2 2 4 1; -2 0 4 1];
%definimos las aristas (nos van a sevir para todas las tres figuras, ya que son las mismas)
a1 = [1 2; 2 3; 3 4; 4 1; 5 6; 6 7; 7 8; 8 5; 2 6; 3 7; 4 8; 1 5];

%trasponemos v1
v1 = v1';

%translado de figura
v1 = transl([0 4 0])*v1;
% impresion de la figura
objplot(v1, a1, 8, 12, 'k')

%se pausa hasta dar a espacio
pause

% crear prisma punto A
% definimos los vertices
v2= [4 0 0 1; 4 1 0 1; 4 1 0.5 1; 4 0 0.5 1; 0 0 0 1; 0 1 0 1 ; 0 1 0.5 1; 0 0 0.5 1];

%trasponemos v2
v2 = v2';

%translado de figuras
v2 = transl([0 11 0])*v2;
% impresion de la figura
objplot(v2, a1, 8, 12, 'b')

%se pausa hasta dar a espacio
pause

% crear prisma punto B
% definimos los vertices
v3= [2 2 0 1; 2 12 0 1; 2 12 0.5 1; 2 2 0.5 1; 0 2 0 1; 0 12 0 1 ; 0 12 0.5 1; 0 2 0.5 1];

%trasponemos v3
v3 = v3';

%translado de figuras
v3 = transl([7 0 0])*v3;
% impresion de la figura
objplot(v3, a1, 8, 12, 'y')

%se pausa hasta dar a espacio
pause
%pintamos el robot
plot(rob, [0 0 0 0]) 

%se pausa hasta dar a espacio
pause

%% movimientos del robot  
% que el efector final va a la posición del punto B
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación
mat = [1 0 0 8
0 -1 0 7
0 0 -1 5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, vector)

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en el punto
% B (cogemos la pieza)
mat = [1 0 0 8
0 -1 0 7
0 0 -1 0.5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición B
plot(rob, vector)

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación
mat = [1 0 0 8
0 -1 0 7
0 0 -1 5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, vector)

%se pausa hasta dar a espacio
pause

%% giro -90 grados de pieza con el punto B
%transladamos la pieza con el punto B a la posición de aproximación (la
%levantamos)
v3 = transl([0 0 5])*v3;
% mostramos la pieza en la nueva posición
objplot(v3, a1, 8, 12, 'y') 

%se pausa hasta dar a espacio
pause
% rotamos la última articulación del robot, para girar el efector final
plot(rob, [vector(1) vector(2) vector(3)+pi/2 vector(4)])
% rotamos la pieza con el punto B en -90º
v3 = (trotz(-pi/2))*v3;
v3 = transl([1 15 0])*v3;
% pintamos la pieza en su nueva  posición
objplot(v3, a1, 8, 12, 'y')

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación
mat = [1 0 0 5
0 -1 0 16
0 0 -1 5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, [vector(1) vector(2) vector(3)+pi/2 vector(4)])

%se pausa hasta dar a espacio
pause
% transladamos la pieza a la posición de aproximación
v3 = transl([-3 9 0])*v3;
%pintamos la pieza en la posición de aproximación
objplot(v3, a1, 8, 12, 'y')

%se pausa hasta dar a espacio
pause
% transladamos la pieza con el punto B a la posición final
v3 = transl([0 0 -5])*v3;
% Pintamos la pieza en la posición final
objplot(v3,a1,8,12,'y')

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en la
% posición final de la pieza
mat = [1 0 0 5
0 -1 0 16
0 0 -1 0.5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
%pintamos el robot en la posición final
plot(rob, [vector(1) vector(2) vector(3)+pi/2 vector(4)])

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación
mat = [1 0 0 5
0 -1 0 16
0 0 -1 5
0 0 0 1];

% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, [vector(1) vector(2) vector(3)+pi/2 vector(4)])

%se pausa hasta dar a espacio
pause

%% giro 90 grados de pieza con el punto A
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación para coger la pieza con el punto A
mat = [1 0 0 2
0 -1 0 11.5
0 0 -1 5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, [vector(1) vector(2) vector(3)+pi/2 vector(4)])

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en la
% posición para que coja la pieza con punto A
mat = [1 0 0 2
0 -1 0 11.5
0 0 -1 0.5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición que coge la pieza
plot(rob, [vector(1) vector(2) vector(3)+pi/2 vector(4)])

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación para coger la pieza con el punto A
mat = [1 0 0 2
0 -1 0 11.5
0 0 -1 5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, [vector(1) vector(2) vector(3)+pi/2 vector(4)])

%se pausa hasta dar a espacio
pause
% transladamos la pieza a la posición de aproximación
v2 = transl([0 0 5])*v2;
% pintamos la pieza en la posición de aproximación
objplot(v2, a1, 8, 12, 'b')

%se pausa hasta dar a espacio
pause
%giramos el efector final del robot 90º
plot(rob, vector)
% rotamos la pieza 90º 
v2 = (trotz( pi/2))*v2;
v2 = transl([13.5 9.5 0])*v2;
%mostramos la pieza en su nueva posición
objplot(v2, a1, 8, 12, 'b')

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación a la posición final de la pieza
mat = [1 0 0 10.5 
0 -1 0 16
0 0 -1 5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, vector)

%se pausa hasta dar a espacio
pause
% transladamos la pieza hasta la psición de aproximación
v2 = transl([8.5 4.5 0])*v2;
% pintamos la pieza en su nueva posición
objplot(v2, a1, 8, 12, 'b')

%se pausa hasta dar a espacio
pause
% transladamos la pieza hasta la psición final
v2 = transl([0 0 -5])*v2;
% pintamos la pieza en su nueva posición
objplot(v2, a1, 8, 12, 'b')

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en 
% la posición final de la pieza
mat = [1 0 0 10.5
0 -1 0 16
0 0 -1 0.5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición final
plot(rob, vector)

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación a la posición final de la pieza
mat = [1 0 0 10.5
0 -1 0 16
0 0 -1 5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, [vector(1) vector(2) vector(3)+pi/2 vector(4)])

%se pausa hasta dar a espacio
pause

%% mover pieza con el punto C
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación a la posición de la pieza con el punto C
mat = [1 0 0 -1
0 -1 0 5
0 0 -1 9
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, vector)

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en la
% posición para que coja la pieza con punto C
mat = [1 0 0 -1
0 -1 0 5
0 0 -1 4
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot cogiendo la pieza
plot(rob, vector)

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación a la posición de la pieza con el punto C
mat = [1 0 0 -1
0 -1 0 5
0 0 -1 9
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación

plot(rob, vector)

%se pausa hasta dar a espacio
pause
% transladamos la pieza a la posición de aproximación
v1 = transl([0 0 5])*v1;
% pintamos la pieza en su nueva posición
objplot(v1, a1, 8, 12, 'k')

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación a la posición final de la pieza con el punto C
mat = [1 0 0 1
0 -1 0 16
0 0 -1 9
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, vector)

%se pausa hasta dar a espacio
pause
%transladamos la pieza hasta la posición de aproximación de su posición
%final
v1 = transl([2 11 0])*v1;
% pintamos la pieza en su nueva posición
objplot(v1, a1, 8, 12, 'k')

%se pausa hasta dar a espacio
pause
%transladamos la pieza hasta su posición final
v1 = transl([0 0 -4.5])*v1;
% mostramos la pieza en su nuva ubicación
objplot(v1, a1, 8, 12, 'k')

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en 
% la posición final de la pieza con el punto C
mat = [1 0 0 1
0 -1 0 16
0 0 -1 4.5
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, vector)

%se pausa hasta dar a espacio
pause
% definimos la matriz de posicion/orientación del efector final en el punto
% de aproximación a la posición final de la pieza con el punto C
mat = [1 0 0 1
0 -1 0 16
0 0 -1 9
0 0 0 1];
% obtenemos los ángulos de las articulaciones del robot mediante cinemática
%inversa
vector = ikine(rob, mat);
% mostramos el robot en la posición de aproximación
plot(rob, vector)
% pintamos las piezas en su posición final con un color distinto
objplot(v1, a1, 8, 12, 'm')
objplot(v2, a1, 8, 12, 'm')
objplot(v3, a1, 8, 12, 'm')

%se pausa hasta dar a espacio
pause

 % devolvemos el robot a su posición 0
plot(rob, [0 0 0 0])

%se pausa hasta dar a espacio
pause


%% APARTADO C
%Mostrar Aceleración y velocidad en las articulaciones con los movimientos
%de la pieza A
%posición inicial del robot antes de empezar a mover la pieza A
Q0 = [5 16 5 1];
% 1ª posición intermedia del robot moviendo la pieza A
Q1 = [2 11.5 5 1];
%2ª posición intermedia del robot moviendo la pieza A
Q2 = [2 11.5 0.5 1];
% 3ª posición intermedia del robot moviendo la pieza A
Q3 = [2 11.5 5 1];
%giro
Q4 = [2 11.5 5 1];
% 5ª posición intermedia del robot moviendo la pieza A
Q5 = [10.5 16 5 1];
% 6ª posición intermedia del robot moviendo la pieza A
Q6 = [10.5 16 0.5 1];
% 7ª posición intermedia del robot moviendo la pieza A
Q7 = [10.5 16 5 1];
% tiempo primer movimiento 
T1 = [0 0.1 1];
% tiempo segundo movimiento 
T2 = [0 0.56 2];
% tiempo tercer movimiento 
T3 = [0 0.56 2];
% tiempo cuarto movimiento 
T4 = [0 0.56 1.5];
% tiempo quinto movimiento 
T5 = [0 0.56 1];
% tiempo sexto movimiento 
T6 = [0 0.56 2];
% tiempo septimo movimiento 
T7 = [0 0.56 2];
%graficas primer movimiento
[Q Vel Acc] = jtraj(Q0, Q1, T1);
% grafica velocidad primer movimiento
figure(2);
subplot(4,1,1)
plot (T1,Vel(:,1));
title('Velocidad eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,2)
plot (T1,Vel(:,2));
title('Velocidad eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,3)
plot (T1,Vel(:,3));
title('Velocidad eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,4)
plot (T1,Vel(:,4));
title('Velocidad eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')

%se pausa hasta dar a espacio
pause

% grafica aceleracion primer movimiento
figure (3)
subplot(4,1,1)
plot (T1,Vel(:,1));
title('Aceleración eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,2)
plot (T1,Vel(:,2));
title('Aceleración eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,3)
plot (T1,Vel(:,3));
title('Aceleración eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,4)
plot (T1,Vel(:,4));
title('Aceleración eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')

%se pausa hasta dar a espacio
pause

%graficas segundo movimiento
[Q ,Vel ,Acc] = jtraj(Q1,Q2,T2);
% grafica velocidad segundo movimiento
figure(4);
subplot(4,1,1)
plot (T2,Vel(:,1));
title('Velocidad eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,2)
plot (T2,Vel(:,2));
title('Velocidad eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,3)
plot (T2,Vel(:,3));
title('Velocidad eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,4)
plot (T2,Vel(:,4));
title('Velocidad eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')

%se pausa hasta dar a espacio
pause

% grafica aceleracion segundo movimiento
figure (5)
subplot(4,1,1)
plot (T2,Vel(:,1));
title('Aceleración eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,2)
plot (T2,Vel(:,2));
title('Aceleración eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,3)
plot (T2,Vel(:,3));
title('Aceleración eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,4)
plot (T2,Vel(:,4));
title('Aceleración eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')

%se pausa hasta dar a espacio
pause

%graficas tercer movimiento
[Q ,Vel ,Acc] = jtraj(Q2,Q3,T3);
% grafica velocidad tercer movimiento
figure(6);
subplot(4,1,1)
plot (T3,Vel(:,1));
title('Velocidad eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,2)
plot (T3,Vel(:,2));
title('Velocidad eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,3)
plot (T3,Vel(:,3));
title('Velocidad eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,4)
plot (T3,Vel(:,4));
title('Velocidad eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')

%se pausa hasta dar a espacio
pause

% grafica aceleracion tercer movimiento
figure (7)
subplot(4,1,1)
plot (T3,Vel(:,1));
title('Aceleración eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,2)
plot (T3,Vel(:,2));
title('Aceleración eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,3)
plot (T3,Vel(:,3));
title('Aceleración eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,4)
plot (T3,Vel(:,4));
title('Aceleración eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')

%se pausa hasta dar a espacio
pause

%graficas cuarto movimiento
[Q Vel Acc] = jtraj(Q3,Q4,T4);
% grafica velocidad cuarto movimiento
figure(8);
subplot(4,1,1)
plot (T4,Vel(:,1));
title('Velocidad eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,2)
plot (T4,Vel(:,2));
title('Velocidad eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,3)
plot (T4,Vel(:,3));
title('Velocidad eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,4)
plot (T4,Vel(:,4));
title('Velocidad eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')

%se pausa hasta dar a espacio
pause

% grafica aceleracion cuarto movimiento
figure (9)
subplot(4,1,1)
plot (T4,Vel(:,1));
title('Aceleración eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,2)
plot (T4,Vel(:,2));
title('Aceleración eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,3)
plot (T4,Vel(:,3));
title('Aceleración eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,4)
plot (T4,Vel(:,4));
title('Aceleración eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')

%se pausa hasta dar a espacio
pause

%graficas quinto movimiento
[Q Vel Acc] = jtraj(Q4, Q5, T5);
% grafica velocidad quinto movimiento
figure(10);
subplot(4,1,1)
plot (T5,Vel(:,1));
title('Velocidad eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,2)
plot (T5,Vel(:,2));
title('Velocidad eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,3)
plot (T5,Vel(:,3));
title('Velocidad eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,4)
plot (T5,Vel(:,4));
title('Velocidad eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')

%se pausa hasta dar a espacio
pause

% grafica aceleracion quinto movimiento
figure (11)
subplot(4,1,1)
plot (T5,Vel(:,1));
title('Aceleración eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,2)
plot (T5,Vel(:,2));
title('Aceleración eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,3)
plot (T5,Vel(:,3));
title('Aceleración eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,4)
plot (T5,Vel(:,4));
title('Aceleración eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')

%se pausa hasta dar a espacio
pause

%graficas sexto movimiento
[Q Vel Acc] = jtraj(Q5, Q6, T6);
% grafica velocidad sexto movimiento
figure(12);
subplot(4,1,1)
plot (T6,Vel(:,1));
title('Velocidad eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,2)
plot (T6,Vel(:,2));
title('Velocidad eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,3)
plot (T6,Vel(:,3));
title('Velocidad eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,4)
plot (T6,Vel(:,4));
title('Velocidad eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')

%se pausa hasta dar a espacio
pause

% grafica aceleracion sexto movimiento
figure (13)
subplot(4,1,1)
plot (T6,Vel(:,1));
title('Aceleración eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,2)
plot (T6,Vel(:,2));
title('Aceleración eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,3)
plot (T6,Vel(:,3));
title('Aceleración eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,4)
plot (T6,Vel(:,4));
title('Aceleración eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')

%se pausa hasta dar a espacio
pause

%graficas septimo movimiento
[Q Vel Acc] = jtraj(Q6, Q7, T7);
% grafica velocidad primer movimiento
figure(14);
subplot(4,1,1)
plot (T7,Vel(:,1));
title('Velocidad eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,2)
plot (T7,Vel(:,2));
title('Velocidad eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,3)
plot (T7,Vel(:,3));
title('Velocidad eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')
subplot(4,1,4)
plot (T7,Vel(:,4));
title('Velocidad eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s)')

%se pausa hasta dar a espacio
pause

% grafica aceleracion septimo movimiento
figure (15)
subplot(4,1,1)
plot (T7,Vel(:,1));
title('Aceleración eje 1')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,2)
plot (T7,Vel(:,2));
title('Aceleración eje 2')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,3)
plot (T7,Vel(:,3));
title('Aceleración eje 3')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')
subplot(4,1,4)
plot (T7,Vel(:,4));
title('Aceleración eje 4')
xlabel('Tiempo(s)')
ylabel('velocidad(Rad/s^2)')

%se pausa hasta dar a espacio
pause

close all