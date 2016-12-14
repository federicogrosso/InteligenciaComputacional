function [Error_promedio_trn,Error_promedio_tst,C_trn,C_tst]=Validacion_Cruzada(nombre,k,porc_trn)
   % nombre: nombre del archivo que contiene los datos
   % k: cantidad de particiones
   % porc_trn: porcentaje de patrones a entrenar
   
    x_aux = csvread(nombre);
    
    C_trn={k};
    C_tst={k};
    
    cant_trn=(porc_trn*size(x_aux,1))/100;
    
    for i=1:k % por cada particion
        vec_idx=randperm(size(x_aux,1)); %se arma el vector de indices desordenados
        
        M_trn=x_aux(vec_idx(1:cant_trn),:); 
        M_tst=x_aux(vec_idx(cant_trn+1:end),:);
        
        C_trn{i}=M_trn;
        C_tst{i}=M_tst;
        
        [W,Error_trn(i)]=PerceptronSimple_trn(M_trn,0.1,100,15,3);
        Error_tst(i)=PerceptronSimple_tst(M_tst,W,3);
        
    end
    
    
    Error_promedio_trn=Error_trn;
    Error_promedio_tst=Error_tst;
end

        
        
        
        
        
        
        
        
    