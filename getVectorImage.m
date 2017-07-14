%   INPUTS
%       - image <double>
%           Imagen a procesar en n x n en blanco y negro
%       - redux <double>
%           Indice de reduccion de la imagen
%
%   OUTPUT
%       - irisVector <double> 
%           Informacon de muestreo binarizado
%
function [ irisVector, img ] = getVectorImage( image , redux )
    
    img = imbinarize( image );

    %Obtenci?n de dimensiones
    [ imgX, imgY ] = size( img );

    %Limite de imagenes
    xM = imgX * redux;
    yM = imgY * redux;

    %Desplazamiento
    movX = 1 : floor( (imgX / xM) : imgX );
    movY = 1 : floor( (imgY / yM) : imgY );

    irisVector = zeros( 1, ( floor( xM * yM ) ) );
    index = 1;

    for i = movX
        for j = movY
           irisVector(index) = img(i,j);
           index = index + 1;
        end
    end