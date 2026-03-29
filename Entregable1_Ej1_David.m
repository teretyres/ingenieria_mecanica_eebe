% % Ejercicio 1 entregable ECIM
% 04-03-2026
% UPC - EEBE
% David Jiménez 
% V1.1.0


clear all
clc
close all
format long;

%% 1. PROPIEDADES GEOMÉTRICAS Y MECÁNICAS
b = 40;                 % Ancho (cm)
h = 80;                 % Peralte/Altura (cm)
A = b * h;              % Área (cm^2)
I = 1076666.666;     % Inercia (cm^4)
E = 252670;             % Módulo de Young (N/cm^2)
G = 101068;             % Módulo de corte (N/cm^2)
L_total = 1000;         % Longitud total (cm)
w_max = 5;              % Carga distribuida máxima (N/cm)
F_axial = 10000;        % Carga axial en el extremo derecho (N)

disp('  PROBLEMA 1: Viga discretizada en 4 elementos')

%% 2. DEFINICIÓN DEL PROBLEMA 2 (4 ELEMENTOS)
n_elem = 4;
n_nodos = n_elem + 1;
L_e = L_total / n_elem; % Longitud de cada elemento = 250 cm
GDL = 3 * n_nodos;      % Grados de libertad totales (15)

% Factor de Timoshenko (phi)
phi2 = (12 * E * I) / (A * G * L_e^2);

% 2.1 Matriz de Rigidez Local/Global de un elemento (Ejes locales = globales, no se usa )
k_e = zeros(6,6);
k_e(1,1) = A*E/L_e;                 k_e(1,4) = -A*E/L_e;
k_e(4,1) = -A*E/L_e;                k_e(4,4) = A*E/L_e;
k_e(2,2) = 12*E*I/((phi2+1)*L_e^3); k_e(2,3) = 6*E*I/((phi2+1)*L_e^2);
k_e(2,5) = -12*E*I/((phi2+1)*L_e^3);k_e(2,6) = 6*E*I/((phi2+1)*L_e^2);
k_e(3,2) = k_e(2,3);                k_e(3,3) = (4+phi2)*E*I/((phi2+1)*L_e);
k_e(3,5) = -6*E*I/((phi2+1)*L_e^2); k_e(3,6) = (2-phi2)*E*I/((phi2+1)*L_e);
k_e(5,2) = k_e(2,5);                k_e(5,3) = k_e(3,5);
k_e(5,5) = 12*E*I/((phi2+1)*L_e^3); k_e(5,6) = -6*E*I/((phi2+1)*L_e^2);
k_e(6,2) = k_e(2,6);                k_e(6,3) = k_e(3,6);
k_e(6,5) = k_e(5,6);                k_e(6,6) = (4+phi2)*E*I/((phi2+1)*L_e);

% 2.2 Ensamblaje de la Matriz Global K (15x15)
K2 = zeros(GDL, GDL);
for i = 1:n_elem
    idx = (3*(i-1)+1):(3*(i-1)+6);
    K2(idx, idx) = K2(idx, idx) + k_e;
end

% 2.3 Vector de Fuerzas Globales y fuerzas de accion

F2_acc = [0;-46.875;-2.604166666666667e+03;0;-3.125e+02;-5.208333333333334e+03;0;-625;-5.208333333333332e+03;0;-9.375e+02;-5.208333333333332e+03;10000;-5.78125e+02;2.34375e+04];

% 2.4 Condiciones de contorno y Resolución
% Apoyo articulado en Nodo 1 (u1=0, v1=0) -> GDL 1 y 2 Apoyo deslizante en Nodo 5 (v5=0)
restringidos = [1, 2, 14];
libres = setdiff(1:GDL, restringidos);

d2 = zeros(GDL, 1);
d2(libres) = K2(libres, libres) \ F2_acc(libres);

% 2.5 Cálculo de Reacciones
R2 = K2 * d2 - F2_acc;

% Mostrar Desplazamientos P2
disp('-> Desplazamientos Nodos 1 al 5 [u(cm), v(cm), theta(rad)]:');
for i = 1:n_nodos
    fprintf('Nodo %d: u = %10.5f, v = %10.5f, theta = %10.6f\n', ...
            i, d2(3*i-2), d2(3*i-1), d2(3*i));
end

% Mostrar Reacciones P2
disp(' '); disp('-> Reacciones en los Apoyos [N, N*cm]:');
fprintf('Nodo 1 (Articulado): Rx = %10.2f, Ry = %10.2f\n', R2(1), R2(2));
fprintf('Nodo 5 (Rodillo)   : Ry = %10.2f\n', R2(14));

%% 3. Fuerzas de cada tramo
disp(' '); % Espacio para que en la consola se pueda leer bien el resultado
disp('-> Fuerzas Internas en cada elemento [N, N, N*cm]:');
for i = 1:n_elem
    idx = (3*(i-1)+1):(3*(i-1)+6);
    d_elem = d2(idx);
    % Ecuación de fuerzas internas: F_int = k_elem * d_elem - F_acciones
    F_int = k_e * d_elem - F2_acc(i);
    
    % Ajuste de signos
    F_int(1:3) = -F_int(1:3); 
    
    fprintf('Elemento %d (Nodos %d-%d):\n', i, i, i+1);
    fprintf('  Nodo i: N = %8.2f, V = %8.2f, M = %10.2f\n', F_int(1), F_int(2), F_int(3));
    fprintf('  Nodo j: N = %8.2f, V = %8.2f, M = %10.2f\n', F_int(4), F_int(5), F_int(6));
end