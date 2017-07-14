%% Obtencion de vector de datos
function [irisVector] = getIrisVector( loaded_img, porcent )

    %Create Blank and white file
    bg_loaded_img = rgb2gray( loaded_img );

    %img = histeq( loaded_img );
    img = histeq( bg_loaded_img );

    [ center, rad ] = getXYImage( loaded_img , 75 );
    %imshow(loaded_img)
    % Input parameters

    xPosPupil = center(1);
    yPosPupil = center(2);
    rPupil = rad * 1.8;
    xPosIris = center(1);
    yPosIris = center(2);
    rIris = 250;

    %  By default the samples are interpolated, however it is also possible to
    %  use neirest neighbor interpolation (no interpolation). This speeds up
    %  the computation, but is less preciese. 
    % Normalize the iris region according to daugmans model and defining the
    % number of samples in radial and angular direction
    irisRegion_3 = rubberSheetNormalisation( img, xPosPupil, yPosPupil, rPupil , xPosIris , yPosIris , rIris, ...
        'DebugMode', 0,'UseInterpolation', 0 ...
    );

%% Prueba de funcion
[irisVector,binIMG] = getVectorImage( irisRegion_3 , porcent );
