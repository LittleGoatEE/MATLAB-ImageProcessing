%% Image registration by cross correaltion
% can only deal with translation 
% and the images should have very similar features
% the two images should have the same size
% the script will align the two images 
% written by Yue Li
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Original_Offset_Crop,Denoised_Crop,Corr_Offset,max_c] = CrossCorrReg(Original,Denoised)

figure(994), imshowpair(Denoised,Original);

%Select ROI for crosscorrelation

figure(995), imagesc(Original),colormap(gray),colorbar
h = imrect(gca, [0 0 length(Original) length(Original)]);
addNewPositionCallback(h,@(p) title(mat2str(p,3)));
fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
setPositionConstraintFcn(h,fcn); 
accepted_pos_ROI = wait(h); 
pos_ROI = getPosition(h);

ROI = imcrop(Original,pos_ROI);
figure(996), imagesc(ROI)
c = normxcorr2(ROI,Denoised);
figure(997), surf(c), shading flat

[max_c, imax] = max(abs(c(:)));
[ypeak, xpeak] = ind2sub(size(c),imax(1));

Corr_Offset = [(pos_ROI(1)-1-xpeak+size(ROI,2)) 
               (pos_ROI(2)-1-ypeak+size(ROI,1))];
           
xoffset = round(Corr_Offset(1));
yoffset = round(Corr_Offset(2));

Original_Offset = circshift(Original,[-yoffset -xoffset]);
figure(998), imshowpair(Denoised,Original_Offset);


close 994 995 996 997 998
Original_Offset_Crop = Original_Offset;
Denoised_Crop = Denoised;

figure, imshowpair(Denoised_Crop,Original_Offset_Crop);
