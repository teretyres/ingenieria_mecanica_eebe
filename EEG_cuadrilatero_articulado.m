
%ECUACIONES DE ENLACE GEOMÉTRICAS Y CINEMÁTICAS DEL TABURETE

clear all

%Dimensiones
r = 100; %mm
l = 300;  %mm
d = 400;  %mm

%Ángulo máximo de la manivela que se quiere calcular
phi1max = 360;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CÁLCULO DE POSICIONES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

posicion=[1,1];
resultados_posicion=zeros(phi1max,2);
phi_manivela=zeros(phi1max,1);

for i=1:1:phi1max
    phi1=i*pi/180; %rad
    phi_manivela(i)=phi1;
    %cálculo de una posición
    fun = @(q)robot_eeg(q,phi1,l,r,d);
    q0 = [posicion(1),posicion(2)];
    posicion = fsolve(fun,q0);
    resultados_posicion(i,1) = posicion(1,1);
    resultados_posicion(i,2) = posicion(1,2);
end

resultados_posiciondeg(:,1)=resultados_posicion(:,1)*180/pi;
resultados_posiciondeg(:,2)=resultados_posicion(:,2)*180/pi;
phi_maniveladeg=phi_manivela*180/pi;

%figure(1)

figure('DefaultAxesFontSize',16)
grid minor

figure(1)
plot(phi_maniveladeg,resultados_posiciondeg(:,1),'k','LineWidth',2)
grid minor
xlabel('$\varphi_1$ (deg)','Interpreter','latex')
ylabel('$\varphi_2$ (deg)','Interpreter','latex')
xlim([0 phi1max])
ylim([min(resultados_posiciondeg(:,1)) max(resultados_posiciondeg(:,1))])

figure(2)
plot(phi_maniveladeg,resultados_posiciondeg(:,2),'r','LineWidth',2)
grid minor
xlabel('$\varphi_1$ (deg)','Interpreter','latex')
ylabel('$\varphi_3$ (deg)','Interpreter','latex')
xlim([0 phi1max])
ylim([min(resultados_posiciondeg(:,2)) max(resultados_posiciondeg(:,2))])

%% Calculo de una posición
phi=11.5*pi/180;
r=100;
l=300;
d=400;
fun= @(q) robot_eeg(q,phi,l,r,d);
q0=[1,1];
posicion= fsolve(fun,q0)