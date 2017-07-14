% setup_image = 'images/DS12.jpg';
setup_image = 'images/eye.png';

% Load the image
loaded_img =  imread(setup_image);
irisVector = getIrisVector( loaded_img, 0.3 );