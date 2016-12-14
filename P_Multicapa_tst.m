function [Error_p]=P_Multicapa_tst(datos1,n_capas,neu_x_capa,cant_salidas,W,b)
    %     %%prueba
    datos=csvread(datos1);
    x_prueba=datos(:,1:3);
    yd_prueba=datos(:,end);
    
    cont1=1;
    cont2=1;
    error_final = 0;
    for l=1:length(yd_prueba)
             error_patron=0;
             Y={};
             Y{1}=x_prueba(l,:);
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
                  clase1_p(cont1,:)=x_prueba(l,2:end);
                  cont1=cont1+1;
              else
                  salida=1;
                  clase2_p(cont2,:)=x_prueba(l,2:end);
                  cont2=cont2+1;
              end
              
              if(salida ~= yd_prueba(l,i))
                  error_patron=error_patron+1;
              end
              
              if (error_patron > 0)
                  error_final=error_final+1;
              end
              
             end
         end
         figure
         plot(clase1_p(:,1),clase1_p(:,2),'+');
         hold on;
         plot(clase2_p(:,1),clase2_p(:,2),'r*');
       
         
        Error_p=error_final*100/length(yd_prueba); 
    