function [Error] = P_Multicapa_tst_Iris(datos,n_capas,neu_x_capa,cant_salidas,b,W)%%agrega u para momento 

%% b parametro de funcion sigmodea
%% u parametro usado en la actualizacion de los pesos
%% 
    cant_filas=size(datos,1);
    datos=datos(randperm(cant_filas),:);
    hasta=size(datos,2)-cant_salidas;
  
    x=datos(:,1:hasta);
    
 
    x=[-1*ones(cant_filas,1) x];
    yd=datos(:,end-cant_salidas+1:end);   
    Y={n_capas};
    
        %%error prueba
    error_final=0;
      for l=1:cant_filas
           Y={};
           Y{1}=x(l,:);
           for j=1:n_capas
              for k=1:neu_x_capa(j)
                  Y{j+1}(k) = FuncionSigmodea(sum((Y{j}.* W{j}(k,:))),b);
              end
              Y{j+1}=[-1 Y{j+1}];
           end
             
             
           % modificacion
           salida=-ones(1,cant_salidas);
           [v,idx]=max(Y{end}(2:end));
           salida(idx)=1;

              
            if(sum(eq(salida,yd(l,:)))~= 3) %eq devuelve 1 en las posiciones que tienen iguales
            error_final=error_final+1;
            end             
             
       end
         
        Error=error_final*100/cant_filas;    
end