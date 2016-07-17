%% In matlab there is a command "rgb2gray" that convert color image (rgb) tp
% grayscale images
% however, there is no built-in function to convert grayscale to a color
% image 
% so this script is designed to turn a grayscale image to a color image
% using colormap "jet"
% the colormap can be changed 
% written by Yue Li
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load data
% data file name is 'p0_Rms.mat' for example
% p0_Rms ranges from 0 to 1 is a grayscale image
rms = load('p0_Rms.mat');
rms = rms.cubeRms;
figure, imagesc(rms)

% Apply false color
RmsScale = uint16(rms*65536);
saturation  = 1.2; % saturation 
RmsColor=ind2rgb(uint8(double(RmsScale)/65535*255*saturation),jet(64));
figure,colormap(jet), imshow(RmsColor)

% save colored image
imwrite(RmsColor,'rms.png','png')
 

