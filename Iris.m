
%Lectura del archivo
%image = imread( 'eye2.bmp' ) ;
image = imread( 'eye.png' ) ;
%image = imread( 'DS12.jpg' ) ;
umbral_iris = 75;

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

erode_center = imdilate( negative_binUmbral , patron_3 );
erode_center = imdilate( erode_center , patron_4 );
erode_center = imdilate( erode_center , patron_2 );


while numberOfElements ~= 1
    %Si no continuamos
    erode_center = imerode( erode_center , patron_4 );
    % Verificacion de elemento unico
    [labeledImage, numberOfElements] = bwlabel(erode_center);
end

%% Calculo de centro
center = [0,0];
rad = 0;


while rad < 10
    [ center, rad ] = findCenter( erode_center );
    % arreglo de imagen final
    erode_center = imdilate( erode_center , patron_5 );
end

[img_centers, img_rads] = imfindcircles( erode_center, [10,200]);

center = img_centers(1,:);
rad = img_rads(1,:);

subplot(1,2,1)
imshow(erode_center);

subplot(1,2,2)
imshow(bg_image);

%fprintf('X : %d , Y : %d\n',center(1),center(2));
