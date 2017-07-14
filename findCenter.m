%% Obtencion de centro de una figura circular a base de una imagen binarizada
%   Entradas
%       - image <binarized>
%           Imagen binarizada, con un unico elemento
%
%   Salidas
%       - center, Cordenadas en (X,Y) del centro de la figura
%       - radius, radio de la figura

function [ center , radius ] = findCenter( image )

    %Definicion de variables utiles
    [ x, y ] = size( image );

    %Inicio y fin de coordenadas en X
    begin_x = 0;
    end_x   = 0;
    count_x = 0;

    %inicio y fin de coordenadas en Y
    begin_y = 0;
    end_y   = 0;
    count_y = 0;


    for i = 1 : x
        curr = sum( image( i, : ) );
        if curr > count_x
            count_x = count_x + 1;
            begin_x = begin_x + i;
            end_x   = end_x + i + curr;
        end
    end

    begin_x = begin_x / count_x;
    end_x   = end_x / count_x;

    for i = 1 : y
        curr = sum( image( :, i ) );
        if curr > count_y
            count_y = count_y + 1;
            begin_y = begin_y + i;
            end_y   = end_y + i + curr;
        end
    end

    begin_y = begin_y / count_y;
    end_y   = end_y / count_y;

    center_x = floor( ( begin_x + end_x - 1 ) / 2 );
    center_y = floor( ( begin_y + end_y - 1 ) / 2 );

%% Asignacion de valores
center = [ center_x, center_y ];
radius = (end_x - begin_x) / 2;
    