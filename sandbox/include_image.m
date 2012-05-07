%%
% 
% <<../Document1 Page 001.png>>
% 
%%
% 
% <<../Document1 Page 002.png>>
% 

u = cmu.units;
t = [0 1 2 3 ]*u.hr
Ca = [4 2 1 0]*u.mol/u.L

k = 2*u.L/u.mol/u.hr

Cao = 4*u.mol/u.L
t12 = 1*u.hr

tau = t/t12
C = Ca/Cao

alpha = 2
k*t12*Cao^(alpha-1)