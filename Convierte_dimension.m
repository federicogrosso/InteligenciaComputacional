function [r,y]=Convierte_dimension(nombre)
    datos=csvread(nombre);
    x1_media=mean(datos(:,1));
    x2_media=mean(datos(:,2));
    y=datos(:,3);
    
    for i=1:length(datos)
        r(i)=sqrt((datos(i,1)-x1_media)^2 + (datos(i,2)-x2_media)^2);
    end
    r=r';
end

    
   
    
