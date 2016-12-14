%Ejercicio 4

datos=csvread('irisbin.csv');

[Entrenamiento, Test]=leaveKout(datos,1);% o 1 para leaveOneOut

ne=length(Entrenamiento);
nt=length(Test);

for i=1:ne
    [Error_trn,ECT,W] = P_Multicapa_trn_Iris(Entrenamiento{i},2,[6 3],3,400,10,0.05,1,0.02);
    [Error_tst] = P_Multicapa_tst_Iris(Test{i},2,[6 3],3,1,W);
    TasaDeError_trn(i)=Error_trn(end);
    TasaDeError_tst(i)=Error_tst;
    
    
end
figure(1)
bar(1:ne,TasaDeError_trn);
title('Error de entrenamiento de cada partición');
xlabel('particiones');
ylabel('%');

figure(2)
bar(1:ne,TasaDeError_tst);
title('Error de prueba de cada partición');
xlabel('particiones');
ylabel('%');


PromedioTasaDeError_trn=mean(TasaDeError_trn);
DesviacionEstandar_trn=sqrt(var(TasaDeError_trn));

PromedioTasaDeError_tst=mean(TasaDeError_tst);
DesviacionEstandar_tst=sqrt(var(TasaDeError_tst));
    


