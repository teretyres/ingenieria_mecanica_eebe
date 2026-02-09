% CLASE 1 (asíncrona) - SISMO DE LORCA
% UPC - EEBE
% Teresa Martín Alguacil
% Febrero 2026
% v1.0.0


clear
clc
close all

fig_num=13; % por si no quieres que tus figuras se númeren automáticamente empezando por 1

%% DATOS
% 2 maneras de leer los archivos .eqf, importdata es interno de MATLAB
[~, dataX]=hdrload('LorcaX.eqf');
file = importdata("LorcaY.eqf");
dataY = file.data; 
timeX= dataX(:, 2); %tiempo acelerograma en dirección X, [s]
timeY= dataY(:, 2); %tiempo acelerograma en dirección Y, [s]
accelX= dataX(:, 3); %aceleración acelerograma en dirección X, [g]
accelY= dataY(:, 3); %aceleración acelerograma en dirección Y, [g]

%% PGA - Peak Ground Acceleration
[pgaX, ix] = max(abs(accelX));
[pgaY, iy] = max(abs(accelY));
pgaX_timeX= timeX(ix);
pgaY_timeY= timeY(iy);
%index_pga_timeX= find(abs(accelX) == pgaX); Manera alternativa de
%   encontrar el índice de mi valor dentro de mi matriz
%index_pga_timeY = find(abs(accelY) == pgaY);

%% GRÁFICAR
% Aceleración X
figure(fig_num)
fig_num= fig_num+1;
subplot(2,1,1)
hold on
plot(timeX, accelX, color='r')
plot(pgaX_timeX, accelX(ix), 'or', color='g')
xlabel('Time [s]')
ylabel('Acceleration in X [g]')
title('Sismograph in Lorca')
legend('acceleration x', sprintf('PGA= %1.3d [g]', pgaX ))
grid on
hold off

subplot(2,1,2)
hold on
plot(timeY, accelY)
plot(pgaY_timeY, accelY(iy), 'or', color='g')
xlabel('Time [s]')
ylabel('Acceleration in Y [g]')
title('Sismograph in Lorca')
legend('acceleration y', sprintf('PGA= %1.3d [g]', pgaY ))
grid on
hold off