function [W,E,n_epoca]=entrenamiento_aux(W,x,yd,gamma,max_e,error) 
% el t es para ir graficando con cierta pausa, si es 0 no grafica las
% rectas, en el caso del xor usar 0 o una pausa muy chica.
    epoca=0;
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