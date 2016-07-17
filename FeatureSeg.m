%% image segementation
% the interactive mode can be turned off by setting interactive to be
% 'false'

% input image is grayscale and named "image_bd"

% the automated segmentation algorithm is the following
% 1. use canny method to find the feature with significant edges
% 2. use image dilate to strengthen the edges
% 3. fill in the holes in between the thick lines
% 4. clear the boundary
% 5. smooth the object by erosion
% 6. clear small features 

% interactive segmenation algorithm
% if interactive mode is on
% the automated steps will be performed
% if there is only one feature selected, then there's no need 
% for interactively selecting ROI
% if not, use roipoly to get the right ROI

% the originial algorithm is developed by MATLAB and can be found at 
% http://www.mathworks.com/help/images/examples/detecting-a-cell-using-image-segmentation.html
% slightly modified by Yue Li
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% automated selection
%interactive mode
interactive = 'true';
% read image
image_bd = load('image_bd');
image_bd = image_bd.image_bd;
% show image
% figure(1),imagesc(image_bd),axis square, colormap(gray)

% use sobel edge detection 
[~, threshold] = edge(image_bd, 'canny');
fudgeFactor = 1.5; % can be adjusted
BWs = edge(image_bd,'canny', 0.3 * fudgeFactor);
% figure(2), imshow(BWs), title('binary gradient mask');
        
% image dilate
se90 = strel('line', 1.5, 90);
se0 = strel('line', 1.5, 0);
BWsdil = imdilate(BWs, [se90 se0]);
% figure(3), imshow(BWsdil), title('dilated gradient mask');
        
% fill interior gaps
BWdfill = imfill(BWsdil, 'holes');
%figure(4), imshow(BWdfill), title('binary image with filled holes');
        
% remove object on the boundary
BWnobord = imclearborder(BWdfill, 4);
% figure(5), imshow(BWnobord), title('cleared border image');
           
% smoothen the object
seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);

 % remove small objects
BWfinal = bwareaopen(BWfinal, 300); 
figure(6), imshow(BWfinal), title('segmented image');

%% interactive selection
if interactive == 'true'
% see if the nucleus has been segmented by chekcing the number of
% regions 
    [B,L,N,A] = bwboundaries(BWfinal,'noholes');
    if length(B)>1
        % select the smaller region
        % set the region with larger peri to be zero
        small = length(B{1});
        % find the smallest peri
            for k = 1:length(B)

                tmp = length(B{k});
                if small > tmp         
                    small = tmp;
                    select = k;
                end
            end

                % select this region
         BWSelect = zeros(size(BWfinal));  
         Pos = B{select};

         for h = 1:length(B{select})       
            BWSelect(Pos(h,1),Pos(h,2))=100;
         end
         BWSelect = logical(BWSelect);
         BWSelect = imfill(BWSelect, 'holes');
         figure(7), imshow(BWSelect)
         BWfinal = BWSelect;
    end
end
