
%----> ejercicio 2-a
% [E_trn,E_tst]=Validacion_Cruzada('spheres1d10.csv',5,80);
% 
% Error_promedio_trn=mean(E_trn)
% Error_promedio_tst=mean(E_tst)
% 
% Var_trn=var(E_trn)
% Var_tst=var(E_tst)


%--> ejercicio 2-b
nombre1= 'spheres2d10.csv';
nombre2= 'spheres2d50.csv';
nombre3= 'spheres2d70.csv';
[E_trn,E_tst]=Validacion_Cruzada(nombre3,10,80);

Error_promedio_trn=mean(E_trn)
Error_promedio_tst=mean(E_tst)

Var_trn=var(E_trn)
Var_tst=var(E_tst)


