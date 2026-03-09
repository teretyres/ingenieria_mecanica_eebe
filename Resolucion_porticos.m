clc; clear; close;

syms A E L I C1 C2 C3 C4 C5 sinTheta cosTheta
C1 = A*E/L;
C2 = 12*E*I/L^3;
C3 = 6*E*I/L^2;
C4 = 4*E*I/L;
C5 = 2*E*I/L;

% Matriz de rigidez de un elemento i-j (en ejes locales)
Kij_L = [
     C1  0   0  -C1  0   0
     0   C2  C3  0  -C2  C3
     0   C3  C4  0  -C3  C5
    -C1  0   0   C1  0   0
    0   -C2 -C3  0   C2 -C3
    0    C3  C5  0  -C3  C4
];

% Matriz de transformación de un elemento i-j

Tij = [
     cosTheta   sinTheta    0    0          0           0
    -sinTheta   cosTheta    0    0          0           0
     0          0           1    0          0           0
     0          0           0    cosTheta   sinTheta    0
     0          0           0   -sinTheta   cosTheta    0
     0          0           0    0          0           1
];


% Matriz de rigidez de un elemento i-j (en ejes globales)

Kij_G = transpose(Tij)*Kij_L*Tij;

%% Datos
% Generales
num_nodos = 6;
gdl = 3;
dim = num_nodos*gdl;
E_num =2526700; % [N/cm^2]

% Elementos

%  ------------------------------ E1-2 ------------------------------
Ni_12=1;
Nj_12=2;
xi_12=0; % [cm]
yi_12=0; % [cm]
xj_12=0; % [cm]
yj_12=300; % [cm]
L_12=300; % [cm]
cosTheta_12 = (xj_12-xi_12)/L_12;
sinTheta_12 = (yj_12-yi_12)/L_12;
A_12 = 2500; % [cm^2] - dato del problema
I_12 = 520833.3333; % [cm^4] - dato del problema
% Matrices de rigidez local y global, y matriz de transformación
K12_L = subs(Kij_L, {A, E, I, L},{A_12, E_num, I_12, L_12});
T12 = subs(Tij, {sinTheta, cosTheta},{sinTheta_12, cosTheta_12});
K12_G = subs(Kij_G, {A, E, I, L, sinTheta, cosTheta}, {A_12, E_num, I_12, L_12, sinTheta_12, cosTheta_12});

%  ------------------------------ E2-3  ------------------------------
Ni_23=2;
Nj_23=3;
xi_23=0; % [cm]
yi_23=300; % [cm]
xj_23=300; % [cm]
yj_23=300; % [cm]
L_23=300; % [cm]
cosTheta_23 = (xj_23-xi_23)/L_23;
sinTheta_23 = (yj_23-yi_23)/L_23;
A_23 = 1250; % [cm^2] - dato del problema
I_23 = 260416.6666; % [cm^4] - dato del problema
% Matrices de rigidez local y global, y matriz de transformación
K23_L = subs(Kij_L, {A, E, I, L},{A_23, E_num, I_23, L_23});
T23 = subs(Tij, {sinTheta, cosTheta},{sinTheta_23, cosTheta_23});
K23_G = subs(Kij_G, {A, E, I, L, sinTheta, cosTheta}, {A_23, E_num, I_23, L_23, sinTheta_23, cosTheta_23});

%  ------------------------------ E3-4  ------------------------------
Ni_34=3;
Nj_34=4;
xi_34=300; % [cm]
yi_34=300; % [cm]
xj_34=500; % [cm]
yj_34=300; % [cm]
L_34=200; % [cm]
cosTheta_34 = (xj_34-xi_34)/L_34;
sinTheta_34 = (yj_34-yi_34)/L_34;
A_34 = 1250; % [cm^2] - dato del problema
I_34 = 260416.6666; % [cm^4] - dato del problema
% Matrices de rigidez local y global, y matriz de transformación
K34_L = subs(Kij_L, {A, E, I, L},{A_34, E_num, I_34, L_34});
T34 = subs(Tij, {sinTheta, cosTheta},{sinTheta_34, cosTheta_34});
K34_G = subs(Kij_G, {A, E, I, L, sinTheta, cosTheta}, {A_34, E_num, I_34, L_34, sinTheta_34, cosTheta_34});

%  ------------------------------ E4-5  ------------------------------
Ni_45=4;
Nj_45=5;
xi_45=500; % [cm]
yi_45=300; % [cm]
xj_45=650; % [cm]
yj_45=300; % [cm]
L_45=150; % [cm]
cosTheta_45 = (xj_45-xi_45)/L_45;
sinTheta_45 = (yj_45-yi_45)/L_45;
A_45 = 1250; % [cm^2] - dato del problema
I_45 = 260416.6666; % [cm^4] - dato del problema
% Matrices de rigidez local y global, y matriz de transformación
K45_L = subs(Kij_L, {A, E, I, L},{A_45, E_num, I_45, L_45});
T45 = subs(Tij, {sinTheta, cosTheta},{sinTheta_45, cosTheta_45});
K45_G = subs(Kij_G, {A, E, I, L, sinTheta, cosTheta}, {A_45, E_num, I_45, L_45, sinTheta_45, cosTheta_45});

%  ------------------------------ E4-6  ------------------------------
Ni_46=4;
Nj_46=6;
xi_46=500; % [cm]
yi_46=300; % [cm]
xj_46=500; % [cm]
yj_46=0; % [cm]
L_46=300; % [cm]
cosTheta_46 = (xj_46-xi_46)/L_46;
sinTheta_46 = (yj_46-yi_46)/L_46;
A_46 = 1225; % [cm^2] - dato del problema
I_46 = 125052.083; % [cm^4] - dato del problema
% Matrices de rigidez local y global, y matriz de transformación
K46_L = subs(Kij_L, {A, E, I, L},{A_46, E_num, I_46, L_46});
T46 = subs(Tij, {sinTheta, cosTheta},{sinTheta_46, cosTheta_46});
K46_G = subs(Kij_G, {A, E, I, L, sinTheta, cosTheta}, {A_46, E_num, I_46, L_46, sinTheta_46, cosTheta_46});

%  ------------------------------ E1-4  ------------------------------
Ni_14=1;
Nj_14=4;
xi_14=0; % [cm]
yi_14=0; % [cm]
xj_14=500; % [cm]
yj_14=300; % [cm]
L_14=583.095; % [cm]
cosTheta_14 = (xj_14-xi_14)/L_14;
sinTheta_14 = (yj_14-yi_14)/L_14;
A_14 = 625; % [cm^2] - dato del problema
I_14 = 0; % [cm^4] - dato del problema
% Matrices de rigidez local y global, y matriz de transformación
K14_L = subs(Kij_L, {A, E, I, L},{A_14, E_num, I_14, L_14});
T14 = subs(Tij, {sinTheta, cosTheta},{sinTheta_14, cosTheta_14});
K14_G = subs(Kij_G, {A, E, I, L, sinTheta, cosTheta}, {A_14, E_num, I_14, L_14, sinTheta_14, cosTheta_14});


%% Vectores de fuerzas
FA_dist_nod = zeros(dim,1);
FA_nod = zeros(dim,1);
FR = sym(zeros(dim,1));

% gdl_n = 1 (fx), 2 (fy), 3 (mom); nodo = 1,..., n; pos = (n-1)*3 + gdl_n

% Fuerzas aplicadas sobre barras trasladadas a nodos -------------------

% FAy2
gdl_n=2; n=2; pos = (n-1)*3 + gdl_n;
FA_dist_nod(pos,1) = -4500; % [N]
% FAm2
gdl_n=3; n=2; pos = (n-1)*3 + gdl_n;
FA_dist_nod(pos,1) = -225000; % [N-cm]
% FAy3
gdl_n=2; n=3; pos = (n-1)*3 + gdl_n;
FA_dist_nod(pos,1) = -4500; % [N]
% FAm3
gdl_n=3; n=3; pos = (n-1)*3 + gdl_n;
FA_dist_nod(pos,1) = 225000; % [N-cm] 

% Fuerzas directamente aplicadas en nodos ------------------------------

% FAx2
gdl_n=1; n=2; pos = (n-1)*3 + gdl_n;
FA_nod(pos,1) = 50000; % [N]
% FAy5
gdl_n=2; n=5; pos = (n-1)*3 + gdl_n;
FA_nod(pos,1) = -1500; % [N] 

% Fuerzas resultantes --------------------------------------------------
syms Rx1 Ry1 M1 Ry6

% FAx2
gdl_n=1; n=1; pos = (n-1)*3 + gdl_n;
FR(pos,1) = Rx1;
% FAy5
gdl_n=2; n=1; pos = (n-1)*3 + gdl_n;
FR(pos,1) = Ry1;
% FAm3
gdl_n=3; n=1; pos = (n-1)*3 + gdl_n;
FR(pos,1) = M1;
% FAx2
gdl_n=2; n=6; pos = (n-1)*3 + gdl_n;
FR(pos,1) = Ry6;

% Vector de fuerza resultante ------------------------------------------

FA = FA_dist_nod + FA_nod;
F = FA + FR;

%% Vector de desplazamientos
d = sym(zeros(dim, 1));

% Vector de desplazamiento resultante -----------------------------------
syms u2 v2 theta2 u3 v3 theta3 u4 v4 theta4 u5 v5 theta5 u6 theta6

% x2
gdl_n=1; n=2; pos = (n-1)*3 + gdl_n;
d(pos,1) = u2;
% y2
gdl_n=2; n=2; pos = (n-1)*3 + gdl_n;
d(pos,1) = v2;
% theta2
gdl_n=3; n=2; pos = (n-1)*3 + gdl_n;
d(pos,1) = theta2;

% x3
gdl_n=1; n=3; pos = (n-1)*3 + gdl_n;
d(pos,1) = u3;
% y3
gdl_n=2; n=3; pos = (n-1)*3 + gdl_n;
d(pos,1) = v3;
% theta3
gdl_n=3; n=3; pos = (n-1)*3 + gdl_n;
d(pos,1) = theta3;

% x4
gdl_n=1; n=4; pos = (n-1)*3 + gdl_n;
d(pos,1) = u4;
% y4
gdl_n=2; n=4; pos = (n-1)*3 + gdl_n;
d(pos,1) = v4;
% theta4
gdl_n=3; n=4; pos = (n-1)*3 + gdl_n;
d(pos,1) = theta4;

% x5
gdl_n=1; n=5; pos = (n-1)*3 + gdl_n;
d(pos,1) = u5;
% y5
gdl_n=2; n=5; pos = (n-1)*3 + gdl_n;
d(pos,1) = v5;
% theta5
gdl_n=3; n=5; pos = (n-1)*3 + gdl_n;
d(pos,1) = theta5;

% x6
gdl_n=1; n=6; pos = (n-1)*3 + gdl_n;
d(pos,1) = u6;
% theta6
gdl_n=3; n=6; pos = (n-1)*3 + gdl_n;
d(pos,1) = theta6;

%% Matriz ensamblada (ejes globales)

KG_T = zeros(dim,dim);
gdl_array = [1,2,3];
Ni_s= [Ni_12,Ni_23, Ni_34, Ni_45, Ni_46, Ni_14];
Nj_s= [Nj_12,Nj_23, Nj_34, Nj_45, Nj_46, Nj_14];
Kij_G_s= {K12_G,K23_G, K34_G, K45_G, K46_G, K14_G};

for ii=1:length(Ni_s)
    KG_T_ith = zeros(dim,dim);
    n_i = Ni_s(ii);
    n_j = Nj_s(ii);
    K_ij = Kij_G_s{ii};
    gdl_n_i = (n_i-1)*gdl+gdl_array;
    gdl_n_j = (n_j-1)*gdl+gdl_array;
    
    KG_T_ith(gdl_n_i,gdl_n_i) = K_ij(1:3,1:3);
    KG_T_ith(gdl_n_i,gdl_n_j) = K_ij(1:3,4:6);
    KG_T_ith(gdl_n_j,gdl_n_i) = K_ij(4:6,1:3);
    KG_T_ith(gdl_n_j,gdl_n_j) = K_ij(4:6,4:6);

    KG_T = KG_T + KG_T_ith;
end


%% Visualización en pantalla de resultados parciales

% Matrices de rigidez locales de cada elemento
fprintf('K12_L')
vpa(K12_L,11)
fprintf('K23_L')
vpa(K23_L,11)
fprintf('K34_L')
vpa(K34_L,11)
fprintf('K45_L')
vpa(K45_L,11)
fprintf('K46_L')
vpa(K46_L,11)
fprintf('K14_L')
vpa(K14_L,11)

% Matrices de rigidez globales de cada elemento
fprintf('K12_G')
vpa(K12_G,11)
fprintf('K23_G')
vpa(K23_G,11)
fprintf('K34_G')
vpa(K34_G,11)
fprintf('K45_G')
vpa(K45_G,11)
fprintf('K46_G')
vpa(K46_G,11)
fprintf('K14_G')
vpa(K14_G,11)

% Vector de fuerza
fprintf('Vector de Fuerzas Aplicadas (distribuidas y nodales)')
vpa(FA)
fprintf('Vector de Reacciones')
vpa(FR)
fprintf('Vector de Fuerzas resultante')
vpa(F)

% Vector de desplazamiento
fprintf('Vector de desplazamientos resultante')
d

% Matriz de rigidez global
fprintf('Matriz de rigidez total global')
vpa(KG_T,11)

%% Reordenamiento de vectores y matriz en función de desplazamientos incógnita

d_idx_desconocidos = [4,5,6,7,8,9,10,11,12,13,14,15,16,18];
d_idx_conocidos = [1,2,3,17];

d_reord_desc = d(d_idx_desconocidos);
d_reord_con = d(d_idx_conocidos);
F_reord_desc = F(d_idx_desconocidos);
F_reord_con = F(d_idx_conocidos);

fprintf('Vector de desplazamientos reordenado')
d_reord = [d_reord_desc; d_reord_con]
fprintf('Vector de fuerzas reordenado')
F_reord = [F_reord_desc; F_reord_con]
fprintf('Matriz de rigidez reordenada')
KG_T_reord = vpa(KG_T([d_idx_desconocidos, d_idx_conocidos],[d_idx_desconocidos, d_idx_conocidos]),11)

%% Vectores y matriz reducidos
fprintf('Vector de desplazamientos reducido')
d_reducido = d_reord_desc
fprintf('Vector de fuerzas reducido')
F_reducido = F_reord_desc
fprintf('Matriz de rigidez reducida')
KG_T_reducida = vpa(KG_T([d_idx_desconocidos],[d_idx_desconocidos]),11)

%% Resolución del sistema reducido y obtención de desplazamientos incógnita

d_res = solve(d_reducido==inv(KG_T_reducida)*F_reducido, d_reducido)

%% Cálculo de reacciones

d_final = [
    0
    0
    0
    d_res.u2
    d_res.v2
    d_res.theta2
    d_res.u3
    d_res.v3
    d_res.theta3
    d_res.u4
    d_res.v4
    d_res.theta4
    d_res.u5
    d_res.v5
    d_res.theta5
    d_res.u6
    0
    d_res.theta6
];

Rs = round(KG_T*d_final-FA,2)