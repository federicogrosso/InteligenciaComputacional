function W = RellenaW(n_datos,n_capa,neu_x_capa)
    W={n_capa};
    vec=[n_datos neu_x_capa];
    for i=1:n_capa
        W{i} = rand(vec(i+1),vec(i)+1)-0.5; %% fila cantidad de neuronas, columnas cantidad de entradas
    end
end
