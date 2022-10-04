clear % mem clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img = imread('a1.bmp');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% g = imread('a2.bmp');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read and preprocess for a3 denoised only
% img = imread('a3m.bmp');
% img = rgb2gray(img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% img pre-processing for a1, a3
s = imsharpen(img,'Radius',2,'Amount',1);
he = histeq(s);
g = imgaussfilt(he,1.4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GUI tool used to find the best value of eliminating outliners to generate a3 denoised image
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
% % edge outline storage matrix for a1, a2
b = false(size(g));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a3 only
% bound = false(size(b));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% edge threshold extract for a1
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
% % edge threshold extract for denoised a3 image: a3m
% for i=1:667
%     for j=1:1000
%         if b(i,j)>=6
%             bound(i,j) = 1;
%         end
%     end
% end
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for a1, a2 only
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
% point cnt and 
cnt = 0;
s = size(b);
r = s(1);
c = s(2);
for i=1:r
    for j=1:c
        if b(i,j) == 1
            cnt = cnt + 1;
        end
    end
end
cnt = cnt/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extract x, y from boundary bool matrix
out = zeros(7000,2);
s = size(b);
r = s(1);
c = s(2);
k = 1;
for i=1:r
    for j=1:c
        if b(i,j) == 1
            out(k,1) = i; out(k,2) = j;
            k = k+1;
        end
    end
end



