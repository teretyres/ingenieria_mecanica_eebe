% CLASE 1 (asíncrona) - SISMO DE LORCA
% UPC - EEBE
% Teresa Martín Alguacil
% Febrero 2026
% v1.0.0


clear all
clc
close all

%% DATOS
% 2 maneras de leer los archivos .eqf, importdata es interno de MATLAB
[~, dataX]=hdrload('LorcaX.eqf');
file = importdata("LorcaY.eqf");
dataY = file.data; 
timeX= dataX(:, 2); %tiempo acelerograma en dirección X, [s]
timeY= dataY(:, 2); %tiempo acelerograma en dirección Y, [s]
accelX= dataX(:, 3); %aceleración acelerograma en dirección X, [g]
accelY= dataY(:, 3); %aceleración acelerograma en dirección Y, [g]

%%
