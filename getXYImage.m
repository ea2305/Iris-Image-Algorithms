%% Recorte del histograma y obtenci?n de centro de pupila
%   INPUTS
%       - image <double>
%           Imagen a procesar en n x n en blanco y negro
%       - redux <double>
%           Indice de reduccion de la imagen
%
%   OUTPUT
%       - irisVector <double> 
%           Informacon de muestreo binarizado

function [center,rad] = getXYImage( image, umbral_iris )


%conversion a blanco y negro
bg_image = rgb2gray( image );
bg_image = histeq( bg_image );

%Obtencion de dimensiones
[imgX,imgY] = size( bg_image );

%contenedor de nueva imagen
template_umbral = ones( imgX, imgY );

%Obtencion de datos de pupila
%Detecci?n del umbral <= 75
for i = 1 : imgX
    for j = 1 : imgY
        curr = bg_image(i,j);
        
        if  curr <= umbral_iris
            template_umbral(i,j) = curr;
        end
        
    end
end

%biinarizacion
binUmbral = im2bw(template_umbral) ;

% Invert
negative_binUmbral = logical( abs( binUmbral - 1 ) );

%erosion, patron e implementacion
patron_2 = strel('cube',8);
patron_3 = strel('cube',9);
patron_4 = strel('cube',15);
patron_5 = [
    0,0,0,0,1,1,0,0,0,0;
    0,0,1,1,1,1,1,1,0,0;
    0,1,1,1,1,1,1,1,1,0;
    0,1,1,1,1,1,1,1,1,0;
    1,1,1,1,1,1,1,1,1,1;
    1,1,1,1,1,1,1,1,1,1;
    0,1,1,1,1,1,1,1,1,0;
    0,1,1,1,1,1,1,1,1,0;
    0,0,1,1,1,1,1,1,0,0;
    0,0,0,0,1,1,0,0,0,0;
];

% Verificacion de elemento unico
numberOfElements = 0;

final_image = imdilate( negative_binUmbral , patron_3 );
final_image = imdilate( final_image , patron_4 );
final_image = imdilate( final_image , patron_2 );


while numberOfElements ~= 1
    %Si no continuamos
    final_image = imerode( final_image , patron_4 );
    % Verificacion de elemento unico
    [labeledImage, numberOfElements] = bwlabel(final_image);
end

%% Calculo de centro
center = [0,0];
rad = 0;


while rad < 20
    [ center, rad ] = findCenter( final_image );
    % arreglo de imagen final
    final_image = imdilate( final_image , patron_5 );
end

[img_centers, img_rads] = imfindcircles( final_image, [10,200]);

center = img_centers(1,:);
rad = img_rads(1,:);
