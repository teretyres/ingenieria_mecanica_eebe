%ECUACIONES DE ENLACE GEOMÉTRICAS ROBOT DE 6 BARRAS

function f = robot_eeg(q,phi1,l,r,d)
f(1) = r*sin(phi1)+l*sin(q(1))-l*sin(q(2));
f(2) = r*cos(phi1)+l*cos(q(1))+l*cos(q(2))-d;