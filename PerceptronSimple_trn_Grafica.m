function [W,E,n_epoca]=PerceptronSimple_trn_Grafica(x_original,gamma,max_e,error,n,t)

% x_original: matriz que contiene los datos (entradas y salidas)
% gamma: velocidad de aprendizaje
% max_e: cantidad maxima de epocas a realizar
% error: tolerancia de error aceptable
% n: cantidad de entradas
% el t es para ir graficando con cierta pausa, si es 0 no grafica las
% rectas, en el caso del xor usar 0 o una pausa muy chica.

    epoca = 0;
    x = ones(size(x_original,1),size(x_original,2))*-1;
    x(:,2:end) = x_original(:,1:n); % matriz de patrones con -1 en la primer columna
    yd = x_original(:,end); % salidas deseadas por separado
    
   % grafica los puntos
      for i=1:length(x)     
        if yd(i)==1
            plot(x(i,2),x(i,3),'r*');
            hold on;
        else            
            plot(x(i,2),x(i,3),'b*');
            hold on;
        end
      end
      
      
    W = rand(1,n+1)-0.5; % se obtienen los pesos de manera aleatoria
    salida=0;
    
    while(epoca<max_e)
          E = 0;
        for i=1:length(x) %se recorren los patrones y actualizo los pesos
            z=sum(W.*x(i,:));
            if (z<0)
                salida = -1;          
            else
                salida = 1;
            end
            W=W+gamma*(yd(i)-salida)*x(i,:);
             %grafico de las rectas(USAR EN CASO OR)
       
%             if ( (t ~= 0) && (yd(i)-salida~= 0)) %%grafica la recta segun varian los pesos, cuando el error es 0, ya encontro la recta ideal, y no grafica
%                   a = W(1)/W(3);
%                   b = W(2)/W(3);
%                   eje_x = [-1:0.1:1];
%                   y = a-b*eje_x;
%                   plot(eje_x,y);
%                   axis([-1.5 1.5 -1.5 1.5])
%                   title('Variaciones de las Rectas según los pesos');
%                   drawnow;
%                   pause(t)
%              end

        end
        
       % grafico de las rectas
      
       
            if ( (t ~= 0) && (mod(epoca,3)== 0)) %%grafica cada 3 epocas
                  a = W(1)/W(3);
                  b = W(2)/W(3); %pendiente
                  eje_x = [-1:0.1:1];
                  y = a-b*eje_x;
                  plot(eje_x,y);
                  axis([-1.5 1.5 -1.5 1.5])
                  title('Variaciones de las Rectas según los pesos');
                  drawnow;
                  pause(t)
             end

        
        for i=1:length(x) %se calcula el error
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
        
        if(E<=error) %si el error es mayor al requerido, sigo entrenando
            return;
        end
        
    end
    
end
    
    
    
    
    
    