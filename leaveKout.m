function [E,P] = leaveKout(matriz,k)

cantDatos=length(matriz);

matriz=matriz(randperm(cantDatos),:); %mezclo la matriz
n=floor(cantDatos/k);
cont=2; %empieza en 2 xq declaro fuera del for el primer conjunto de matrices

P{1}=matriz(1:k,:);
E{1}=matriz(k+1:end,:);

for i=2:n
    desde=(i-1)*k+1; %para i=0 -> (1-1)*k+1=1
    hasta=desde+k-1; %desde=6 y k=5 -> 6+5-1=10
    
    P{cont}=matriz(desde:hasta,:);
    E{cont}=[ matriz(1:desde-1,:) ; matriz(hasta+1:end,:) ];

    cont=cont+1;
end