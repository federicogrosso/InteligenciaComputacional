function [Error,ECT,W] = P_Multicapa_trn_Iris(datos,n_capas,neu_x_capa,cant_salidas,n_epoca,tol,gamma,b,u)%%agrega u para momento 

%% b parametro de funcion sigmodea
%% u parametro usado en la actualizacion de los pesos
%% 
  %  datos=datos(randperm(length(datos)),:);
    hasta=size(datos,2)-cant_salidas;
    cant_filas=size(datos,1);
    x=datos(:,1:hasta);
    
 
    x=[-1*ones(cant_filas,1) x];
    yd=datos(:,end-cant_salidas+1:end);
    
    epoca=1;
    
    W=RellenaW(size(x,2)-1,n_capas,neu_x_capa);
    Y={n_capas};
    Deltas={n_capas};
    dW2=W;
    %for i=1:length(W)
    %    dW2{i}=zeros(size(W{i}));
    %end
    
    while(epoca<n_epoca)
        for i=1:size(x,1)
            %%hacia adelante
            Y={};
            Y{1}=x(i,:);
            
            for j=1:n_capas
                for k=1:neu_x_capa(j)
                    
                    Y{j+1}(k) = FuncionSigmodea(sum((Y{j}.* W{j}(k,:))),b);
                end
                Y{j+1}=[-1 Y{j+1}];
            end
            
            
            %%hacia atras
            for p=1:cant_salidas
               Deltas{n_capas}(p,1)=0.5*(yd(i,p)-Y{n_capas+1}(p+1))*(1+Y{n_capas+1}(p+1))*(1-Y{n_capas+1}(p+1));
            end
            
            
            for j=n_capas-1:-1:1
                cola=0.5*((1+Y{j+1}(2:end)).*(1-Y{j+1}(2:end)))';
                M=(W{j+1}(:,2:end)')*Deltas{j+1};
                Deltas{j}=M.*cola;
            end
            %%actualizacion pesos
          %  dW2=0;
            for k=1:n_capas
%                 for j=1:neu_x_capa(k)
%                     dW=u*Deltas{k}(j).*Y{k+1}(j);
%                     W{k}(j,:)= W{k}(j,:)+ dW;                                   
%                 end
                dW=gamma*Deltas{k}*Y{k}; 
                W{k}=W{k}+dW+u*dW2{k};%%se agrego termino de momento u*dW2
                dW2{k}=dW;
            end      
        end
        %%error entrenamiento 
        error_final=0;
      
   
         for l=1:length(yd)
             error_patron=0;
             Y={};
             Y{1}=x(l,:);
             for j=1:n_capas
                for k=1:neu_x_capa(j)
                    Y{j+1}(k) = FuncionSigmodea(sum((Y{j}.* W{j}(k,:))),b);
                end
                Y{j+1}=[-1 Y{j+1}];
             end
             
           ECT_aux(l,:)=(Y{end}(2:end) - yd(l,:)).^2;
             
             
           % modificacion
           salida=-ones(1,cant_salidas);
           [v,idx]=max(Y{end}(2:end));
           salida(idx)=1;

              
            if(sum(eq(salida,yd(l,:)))~= 3) %eq devuelve 1 en las posiciones que tienen iguales
            error_final=error_final+1;
            end             
             
         end
        %hacer error cuadratico total: (salida - yd)^2 y asignarlo a ECT
        Error(epoca)=error_final*100/length(yd);
        ECT(epoca)=mean(sum(ECT_aux));
      
        if (Error(epoca)<= tol)
            return;
        end
        epoca=epoca+1;

    end

   
end