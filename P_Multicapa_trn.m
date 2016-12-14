function [Error_trn,W] = P_Multicapa_trn(datos1,n_capas,neu_x_capa,cant_salidas,n_epoca,tol,gamma,b,u,k)%%agrega u para momento 

%% b parametro de funcion sigmodea
%% u parametro usado en la actualizacion de los pesos
%% 
    datos=csvread(datos1);
    hasta=size(datos,2)-cant_salidas;
    cant_filas=size(datos,1)-k;
    x=datos(1:end-k,1:hasta);
    x_prueba=datos(end-k+1:end,1:hasta);
   
    
 
    x=[-1*ones(cant_filas,1) x];
    x_prueba=[-ones(k,1) x_prueba];
    yd=datos(1:end-k,end-cant_salidas+1:end);
    yd_prueba=datos(end-k+1:end,end-cant_salidas+1:end);
    csvwrite('concentlite_tst.csv',[x_prueba yd_prueba]);
    
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
               Deltas{n_capas}=0.5*(yd(i,p)-Y{n_capas+1}(p+1))*(1+Y{n_capas+1}(p+1))*(1-Y{n_capas+1}(p+1));
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
        cont1=1;
        cont2=1;
        clear clase1;
        clear clase2;
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
             for i=1:cant_salidas
              salida=Y{end}(i+1);
             
              if (salida < 0)
                  salida=-1;
                  clase1(cont1,:)=x(l,2:end);
                  cont1=cont1+1;
              else
                  salida=1;
                  clase2(cont2,:)=x(l,2:end);
                  cont2=cont2+1;
              end
              
              if(salida ~= yd(l,i))
                  error_patron=error_patron+1;
              end
              
              if (error_patron > 0)
                  error_final=error_final+1;
              end
              
             end
         end
         
        Error_trn(epoca)=error_final*100/length(yd); 
      
        if (Error_trn(epoca)<= tol)
       
            figure
            plot(clase1(:,1),clase1(:,2),'+');
            hold on;
            plot(clase2(:,1),clase2(:,2),'r*');
            figure
            plot(Error_trn);
            title('Error vs Epocas');
            return;
        end
        epoca=epoca+1;

    end
    figure
    plot(clase1(:,1),clase1(:,2),'+');
    hold on;
    plot(clase2(:,1),clase2(:,2),'r*');
    figure
    plot(Error_trn);
    title('Error vs Epocas');
   
end
        
    
    
    
    
