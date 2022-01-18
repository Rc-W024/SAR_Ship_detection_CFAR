img = imread('G:\UPC\PhD\JRS\Matlab\img\E2.png');
bw = im2bw(img);

[L,num] = bwlabel(bw);

status = regionprops(L,'BoundingBox');
centroid = regionprops(L,'Centroid');

figure;
imshow(img,'Border','tight');
hold on

for n = 1:num
    rectangle('Position',status(n).BoundingBox,'EdgeColor','r')
end

