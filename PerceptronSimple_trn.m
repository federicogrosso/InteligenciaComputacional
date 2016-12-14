function [W,E,n_epoca]=PerceptronSimple_trn(x_original,gamma,max_e,error,n) 
% x_original: matriz que contiene los datos (entradas y salidas)
% gamma: velocidad de aprendizaje
% max_e: cantidad maxima de epocas a realizar
% error: tolerancia de error aceptable
% n: cantidad de entradas
% el t es para ir graficando con cierta pausa, si es 0 no grafica las
% rectas, en el caso del xor usar 0 o una pausa muy chica.

    epoca = 0;
    x = ones(size(x_original,1),size(x_original,2))*-1;
    x(:,2:end) = x_original(:,1:n);
    yd = x_original(:,end);
    W = rand(1,n+1)-0.5;
    salida=0;
    while(epoca<max_e)
          E = 0;
        for i=1:length(x)
            z=sum(W.*x(i,:));
            if (z<0)
                salida = -1;          
            else
                salida = 1;
            end
            W=W+gamma*(yd(i)-salida)*x(i,:);
        end
        for i=1:length(x)
            z = sum(W.*x(i,:));
            if (z<0)
                salida = -1;
            else
                salida = 1;
            end
            if (salida ~= yd(i))
                E = E+1;
            end
        end
        E = E*100/length(x);
        epoca = epoca+1;
        n_epoca = epoca;
        if(E<=error)
            return;
        end
    end
    return
