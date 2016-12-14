
% ---- Ejercicio 1 ------

%function [W,E,n_epoca]=entrenamiento(nombre,gamma,max_e,error,n,t)

% nombre: nombre del archivo que contiene los datos
% gamma: velocidad de aprendizaje
% max_e: cantidad maxima de epocas a realizar
% error: tolerancia de error aceptable
% n: cantidad de entradas
% el t es para ir graficando con cierta pausa, si es 0 no grafica las
% rectas, en el caso del xor usar 0 o una pausa muy chica.

DatosOR_trn = csvread('OR_trn.csv');
DatosOR_tst = csvread('OR_tst.csv');
DatosXOR_trn = csvread('XOR_trn.csv');
DatosXOR_tst = csvread('XOR_tst.csv');



%[W,E,n_epoca]=PerceptronSimple_trn_Grafica(DatosOR_trn,0.1,30,1,2,0.5);
 %[E]=PerceptronSimple_tst_Grafica(DatosOR_tst,W);
%[W,E,n_epoca]=PerceptronSimple_trn_Grafica(DatosXOR_trn,0.1,30,10,2,0.5);
 [E]=PerceptronSimple_tst_Grafica(DatosXOR_tst,W);



