function [E]=PerceptronSimple_tst_Grafica(x_original,W)


    x = ones(size(x_original,1),size(x_original,2))*-1;
    x(:,2:end) = x_original(:,1:2);
    cantidad_filas = size(x,1);
    yd = x_original(:,end);
    
 % grafica los puntos y la recta
      for i=1:length(x)     
        if yd(i)==1
            plot(x(i,2),x(i,3),'r*');
            hold on;
        else            
            plot(x(i,2),x(i,3),'b*');
            hold on;
        end
      end
    a = W(1)/W(3);
    b = W(2)/W(3);
    eje_x = [-1:0.1:1];
    y = a-b*eje_x;
    plot(eje_x,y);
    axis([-1.5 1.5 -1.5 1.5])
    
    salida = 0;
    E=0;
    
    %como ya se está probando,es decir que ya realice mi entrnamiento y tengo los W adecuados, se
    %recorren los patrones y se calcula el error
    
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
    