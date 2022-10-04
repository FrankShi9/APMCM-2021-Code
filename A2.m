clear % mem clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img = imread('b4.bmp');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% g = imread('a2.bmp');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read and preprocess for a3 denoised only
% img = imread('a3m.bmp');
% img = rgb2gray(img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% img pre-processing for b
s = imsharpen(img,'Radius',2,'Amount',1);
he = histeq(s);
g = imgaussfilt(he,1.4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GUI tool to find the best value of eliminating outliners to generate a3 denoised image
% imshow(g)
% imcontrast 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%used only for a3 final output
% b = edge(img, 'Canny'); 
% imshow(img)
% hold on
% visboundaries(b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % close operation -> bugs -> disabled
% se = strel('disk',2);
% % g = imbothat(g,se); % bottom hat operation -> bug -> disabled
% imgC = imclose(g,se);
% imshow(imgC);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Gmag, Gdir] = imgradient(g, 'central');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % edge outline storage matrix
b = false(size(g));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% edge threshold extract for b
for i=1:972
    for j=1:1276
        if Gmag(i,j)>30
            b(i,j) = 1;
        end
    end
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % edge threshold extract for a2
% for i=1:972
%     for j=1:1276
%         if Gmag(i,j)>20 && Gmag(i,j)<80
%             b(i,j) = 1;
%         end
%     end
% end
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % edge threshold extract for denoised a3 image
% % for i=1:667
% %     for j=1:1000
% %         if Gmag(i,j)>40 && Gmag(i,j)<120
% %             b(i,j) = 1;
% %         end
% %     end
% % end
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imshow(g)
hold on
visboundaries(b)
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% arc length approximate
perim = regionprops(b,'Perimeter');
perim = perim.Perimeter;
% by definition we /=2 then we approximate the arc length by /= 2 again since my model would draw the edge about twice as it should be. 
perim = perim/4; 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% point cnt per contour
cnt = 0;
s = size(b);
r = s(1);
c = s(2);
for i=1:r
    for j=1:c
        if b(i,j) == 1 && j>=766 && j<=1075 && i>=403 && i<=612
            cnt = cnt + 1;
        end
    end
end
cnt = cnt/2;

