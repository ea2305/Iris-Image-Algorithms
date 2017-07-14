% setup_image = 'DS12.jpg';
setup_image = 'eye.png';

% Load the image
loaded_img =  imread(setup_image);
irisVector = getIrisVector( loaded_img, 0.3 );