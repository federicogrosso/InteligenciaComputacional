function [E]=PerceptronSimple_tst(x_original,W,n)


    x = ones(size(x_original,1),size(x_original,2))*-1;
    x(:,2:end) = x_original(:,1:n);
    cantidad_filas = size(x,1);
    yd = x_original(:,end);
    salida = 0;
            E=0;
     for i=1:cantidad_filas
        z = sum(W.*x(i,:));
        if (z<0)
            salida = -1;
        else
            salida = 1;
        end
        if (salida ~= yd(i))
             E=E+1;
        end
     end
        E = E*100;
        E = E/cantidad_filas;
       
end
    