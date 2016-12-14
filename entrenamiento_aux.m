function [W,E,n_epoca]=entrenamiento_aux(x,yd,gamma,max_e,error) 
% el t es para ir graficando con cierta pausa, si es 0 no grafica las
% rectas, en el caso del xor usar 0 o una pausa muy chica.
    x=[-ones(length(x),1) x];
    W=rand(1,2)-0.5;
    epoca=1;
    salida=0;
    while(epoca<max_e)
          Error = 0;
        for i=1:length(x)
            z=sum(W.*x( i,:));

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
                Error = Error+1;
            end
        end
        E(epoca) = Error*100/length(x);
        
        n_epoca = epoca;
        if(E(epoca)<=error)
            return;
        end
        epoca = epoca+1;
    end
    return