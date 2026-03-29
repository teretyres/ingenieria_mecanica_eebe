% =========================================================================
% RESOLUCIÓN DE VIGA CONTINUA P3 - MÉTODO DE LOS 3 MOMENTOS
% =========================================================================
clear; clc; close all;

%% 1. DEFINICIÓN DEL SISTEMA MATRICIAL (A * M = B)
% Ecuaciones simplificadas de los 3 momentos para los apoyos A, B y C
A = [12,  6,  0; 
      6, 24,  6; 
      0,  6, 25];

B_vec = [-1200; -2145; -1631.5625];

% Resolver Momentos Internos (kN·m)
M_int = A \ B_vec;
Ma = M_int(1);
Mb = M_int(2);
Mc = M_int(3);
Md = 0; % Extremo libremente apoyado

fprintf('--- MOMENTOS EN LOS APOYOS (kN·m) ---\n');
fprintf('Ma = %8.3f\nMb = %8.3f\nMc = %8.3f\nMd = %8.3f\n\n', Ma, Mb, Mc, Md);

%% 2. CÁLCULO DE CORTANTES (V) Y REACCIONES (R)
% Tramo 1 (AB) - L = 6m, P = 50kN en x=2 y x=4
V_Ader = (50*4 + 50*2 - Ma + Mb) / 6;
V_Bizq = 100 - V_Ader;

% Tramo 2 (BC) - L = 6m, P = 70kN en x=3
V_Bder = (70*3 - Mb + Mc) / 6;
V_Cizq = 70 - V_Bder;

% Tramo 3 (CD) - L = 6.5m, w = 10kN/m
V_Cder = (10*6.5*(6.5/2) - Mc + Md) / 6.5;
V_Dizq = (10*6.5) - V_Cder;

% Reacciones Totales (kN)
Ra = V_Ader;
Rb = V_Bizq + V_Bder;
Rc = V_Cizq + V_Cder;
Rd = V_Dizq;

fprintf('--- REACCIONES VERTICALES (kN) ---\n');
fprintf('Ra = %8.3f\nRb = %8.3f\nRc = %8.3f\nRd = %8.3f\n', Ra, Rb, Rc, Rd);

%% 3. CREACIÓN DE VECTORES PARA DIAGRAMAS
% Discretización del eje X global
xg1 = linspace(0, 6, 200);      % Tramo 1
xg2 = linspace(6, 12, 200);     % Tramo 2
xg3 = linspace(12, 18.5, 200);  % Tramo 3

% Ejes locales para cálculos
xl1 = xg1;
xl2 = xg2 - 6;
xl3 = xg3 - 12;

% Ecuaciones de Cortante (V)
V1 = Ra - 50.*(xl1>2) - 50.*(xl1>4);
V2 = V_Bder - 70.*(xl2>3);
V3 = V_Cder - 10.*xl3;

% Ecuaciones de Momento Flector (M)
M1 = Ma + Ra.*xl1 - 50.*max(0, xl1-2) - 50.*max(0, xl1-4);
M2 = Mb + V_Bder.*xl2 - 70.*max(0, xl2-3);
M3 = Mc + V_Cder.*xl3 - 10.*(xl3.^2)./2;

% Concatenar arrays para plotear
X_plot = [xg1, xg2, xg3];
V_plot = [V1, V2, V3];
M_plot = [M1, M2, M3];

%% 4. DIBUJAR LOS DIAGRAMAS
figure('Name', 'Leyes de Esfuerzos', 'Color', 'w', 'Position', [100, 100, 800, 600]);

% Gráfico de Cortante (V)
subplot(2,1,1);
hold on; grid on;
plot(X_plot, V_plot, 'b', 'LineWidth', 1.5);
fill([X_plot, flip(X_plot)], [V_plot, zeros(size(V_plot))], 'b', 'FaceAlpha', 0.1);
yline(0, 'k-', 'LineWidth', 1);
title('Diagrama de Esfuerzo Cortante (V) [kN]');
xlabel('Posición x (m)'); ylabel('Cortante (kN)');
% Acotar máximos
text(0, Ra+5, sprintf('%.1f', Ra), 'Color', 'b', 'FontWeight', 'bold');
text(6, -V_Bizq-5, sprintf('%.1f', -V_Bizq), 'Color', 'b', 'FontWeight', 'bold');

% Gráfico de Momento Flector (M)
% (Nota: en ingeniería civil es común dibujar el momento positivo hacia abajo)
subplot(2,1,2);
hold on; grid on;
plot(X_plot, M_plot, 'r', 'LineWidth', 1.5);
fill([X_plot, flip(X_plot)], [M_plot, zeros(size(M_plot))], 'r', 'FaceAlpha', 0.1);
yline(0, 'k-', 'LineWidth', 1);
set(gca, 'YDir', 'reverse'); % Invertir eje Y
title('Diagrama de Momento Flector (M) [kN·m]');
xlabel('Posición x (m)'); ylabel('Momento (kN·m)');
% Acotar máximos en los apoyos
text(0, Ma-5, sprintf('%.1f', Ma), 'Color', 'r', 'FontWeight', 'bold');
text(6, Mb-5, sprintf('%.1f', Mb), 'Color', 'r', 'FontWeight', 'bold');
text(12, Mc-5, sprintf('%.1f', Mc), 'Color', 'r', 'FontWeight', 'bold');