%%Ejercicio 3
 
% close all

%item a y b
%Parametros: cant de capas - neu x capas - cant salidas - n epocas -
%            tolerancia - vel apren - b funcion sigm - momento - particion

[Error_trn,W_pmc]=P_Multicapa_trn('concentlite.csv',2,[4 1],1,300,5,0.05,1,0.02,20);
[Error_p]=P_Multicapa_tst('concentlite_tst.csv',2,[4 1],1,W_pmc,1); 
X=['La tasa de error de prueba es: ',num2str(Error_p), ' %'];
disp(X);

%item c
%clear all

% [r,y]=Convierte_dimension('concentlite.csv');%convertimos los datos a una dimension y lo guardamos en r.
% [W,E,n_epoca]=PerceptronSimple_trn_Grafica([r y],0.05,100,5,1,0.5) %entrenamos un perceptron simple con estos datos.
