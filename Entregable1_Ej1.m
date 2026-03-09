% ENTREGABLE 1 - EJERCICIO 1
% UPC - EEBE
% Teresa Martín Alguacil
% Marzo 2026
% v1.0.0

clear
clc
close all
format long

%% 1. DATOS DE ENTRADA
% Ensamblaje de K_global
num_nodos = 5;          % nodos
dofs_por_nodo = 3;      % gdls: x, y, theta
num_elementos = 4;      % Barras
tam_global = num_nodos * dofs_por_nodo; %tamaño de la K_global

K_global = zeros(tam_global, tam_global); %Inicializar matriz
K_elems = cell(1, num_elementos);
%}
K_base = [ 3234176,         0,          0, -3234176,         0,          0;
                 0,    179877,   22484693,         0,   -179877,   22484693;
                 0,  22484693, 3747448871,         0, -22484693,  1873724436;
          -3234176,         0,          0,  3234176,         0,          0;
                 0,   -179877, -22484693,         0,    179877,  -22484693;
                 0,  22484693,   1873724436,         0, -22484693, 3747448871];

K_elems{1} = K_base; % Matriz del Elemento 1-2
K_elems{2} = K_base; % Matriz del Elemento 2-3
K_elems{3} = K_base; % Matriz del Elemento 3-4
K_elems{4} = K_base; % Matriz del Elemento 4-5

% Definimos la conectividad (qué nodo se une con cuál)
% [Nodo_i, Nodo_j] para cada elemento
conectividad = [1, 2; 
                2, 3; 
                3, 4; 
                4, 5];

for e = 1:num_elementos
    % Extraer nodos del elemento actual
    n_i = conectividad(e, 1);
    n_j = conectividad(e, 2);
    
    % Calcular índices globales de los Grados de Libertad (DOFs)
    % Siguiendo el orden: xi, yi, theta_i, xj, yj, theta_j
    idx = [3*n_i-2, 3*n_i-1, 3*n_i, ...
           3*n_j-2, 3*n_j-1, 3*n_j];
    
    % Sumar la matriz específica de este elemento a la global
    K_global(idx, idx) = K_global(idx, idx) + K_elems{e};
end

%Ensamblaje vector F_externas
F_ext = zeros(15, 1);
F_ext(2)  = -46.875;   % Fy1
F_ext(3)  = -2604.17;  % M1
F_ext(5)  = -312.875;  % Fy2
F_ext(6)  = -5208.337; % M2
F_ext(8)  = -625.375;  % Fy3
F_ext(9)  = -5208.337; % M3
F_ext(11) = -937.875;  % Fy4
F_ext(12) = -5208.337;    % M4
F_ext(13) = 10000;     % Fx5 
F_ext(14) = -578.5;    % Fy5
F_ext(15) = 23437.5;   % M5

%% 2. DEFINICIÓN DE CONDICIONES DE CONTORNO
% Grados de libertad restringidos (desplazamiento = 0)
dofs_restringidos = [1, 2, 14]; 

% Grados de libertad libres (desconocidos)
total_dofs = size(F_ext, 1);
dofs_libres = setdiff(1:total_dofs, dofs_restringidos);

%% 3. RESOLUCIÓN DE DESPLAZAMIENTOS {d}
% Partición: K_libre * d_libre = F_ext_libre
d = zeros(total_dofs, 1);
K_LL = K_global(dofs_libres, dofs_libres);
F_L  = F_ext(dofs_libres);

d(dofs_libres) = K_LL \ F_L;

%% 4. CÁLCULO DE REACCIONES {R}
% Las reacciones son: {R} = [K]*{d} - {F_ext}
% Solo nos interesan en los dofs restringidos
F_reacciones = K_global * d;
Reacciones = F_reacciones(dofs_restringidos) - F_ext(dofs_restringidos);

%% 5. FUERZAS INTERNAS
Fuerzas_Internas = cell(1, num_elementos);

for e = 1:num_elementos
    % 1. Identificar qué nodos forman el elemento
    n_i = conectividad(e, 1);
    n_j = conectividad(e, 2);
    
    % 2. Obtener los índices de los 6 grados de libertad de esta barra
    idx = [3*n_i-2, 3*n_i-1, 3*n_i, 3*n_j-2, 3*n_j-1, 3*n_j];
    
    % 3. Extraer los desplazamientos globales que corresponden a esta barra
    d_elem = d(idx);
    
    % 4. Calcular las fuerzas internas en los extremos del elemento
    F_int_elem = K_elems{e} * d_elem;
    
    % Guardar en el contenedor
    Fuerzas_Internas{e} = F_int_elem;
    
    % Mostrar los resultados en la Command Window de forma limpia
    fprintf('Elemento %d (Conecta Nodos %d y %d):\n', e, n_i, n_j);
    nombres_dofs = {'Axial_i (Fx)'; 'Cortante_i (Fy)'; 'Momento_i (M)'; ...
                    'Axial_j (Fx)'; 'Cortante_j (Fy)'; 'Momento_j (M)'};
    disp(table(nombres_dofs, F_int_elem, 'VariableNames', {'Esfuerzo', 'Valor_N_Ncm'}));
end