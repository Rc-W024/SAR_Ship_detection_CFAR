function sar_cfar_6(hObject,eventdata,handles,f)
% Two-parameter CFAR ship detection based on Rayleigh distribution 
%   hObject -- Object
%   eventdata -- Event
%   handles -- Handle
%   In this case, neither the object nor the event is used, only the handle is used
%   f is the input SAR image
%   The SAR image has changed from three-dimensional to one-dimensional

% Start the timer
tic

f = imread('...\SAR.jpg');
figure;
imshow(f);
title('Raw image');

Pfa = 0.04;                       % constant false alarm rate
% densGate = 0.01;                % density filter threshold
% rad = 1;                        % radius value of the morphological filter structuring element

% Preprocessing
f = double(f);
f_size = size(f);

% Determine target size
width = 5;
height = 10;

%-----------------------------------------------------------------------------
% 1.Determine CFAR detector parameters including window size, protection area
%   width, clutter area width
%-----------------------------------------------------------------------------

% Determine the parameters of the CFAR detector
% 1.Take the maximum value of length and width
global tMaxLength;
tMaxLength = max(width,height);

% 2.Determine the side length of the protection area
global proLength;
proLength = tMaxLength*2 + 1;                           % odd number

% 3.Determine the clutter zone ring width
global cLength;
cLength = 1;                                            % usually 1 pixel

% 4.Calculate the number of pixels used for the clutter area
numPix = 2*cLength*(2*cLength+proLength+proLength); 

% 5.Half of the side length of the CFAR detector
global cfarHalfLength;
cfarHalfLength = tMaxLength+cLength;

% 6.Side length of the CFAR detector
global cfarLength;
cfarLength = proLength + 2*cLength;
str = sprintf('Side length of the CFAR detector：%f, Clutter zone ring width：%f, ...
              Number of pixels used for clutter：%f', proLength,cLength,numPix);
disp(str);

%-----------------------------------------------------------------------------
% 2.Expand the raw image boundary to eliminate the influence of the boundary
%-----------------------------------------------------------------------------
padLength = cfarHalfLength;           % determine the border size of the image padding to be half the size of the CFAR sliding window
global g;
g = padarray(f,[padLength padLength],'symmetric');      % g is the filled image
% global g_dis;
% g_dis = g;

%-----------------------------------------------------------------------------
% 3.Determine CFAR threshold
%-----------------------------------------------------------------------------
% The threshold is obtained from the determined false alarm probability
th = (2*sqrt(-log(Pfa))-sqrt(pi))/(sqrt(4-pi));

%-----------------------------------------------------------------------------
% 4.Use the CFAR detector to solve the local threshold and perform the
%   judgment of a single pixel
%-----------------------------------------------------------------------------

% Define the result processing matrix
global resultArray
resultArray = zeros(size(g));

% CFAR detection

% The CFAR detector is divided into four detection zones, as shown in the following figure
%
%          |————————————————————————|
%          |——————————-1————————————|
%          |   |                |   |
%          |   |                |   |
%          | 3 |                | 4 |
%          |   |                |   |
%          |   |                |   |
%          |   |                |   |
%          |————————————————————————|  
%          |——————————-2————————————|
%
% Iterate over each point in the image

for i = (1+padLength):(f_size(1)+padLength)
    for j = (1+padLength):(f_size(2)+padLength)
        [csIndex1 csIndex2 csIndex3 csIndex4] = getEstSec(i,j,1);
        % Get the 4 clutter estimation areas corresponding to the pixel at (i, j)
        [u,delta] = cfarEstPra(csIndex1,csIndex2,csIndex3,csIndex4);
        % Get the mean and standard deviation from the clutter area
        temp = (g(i,j)-u)/delta;    % calculate the two-parameter CFAR detection discriminant
        % Target point discrimination
        if temp > th                
            resultArray(i,j) = 255;
        else resultArray(i,j) = 0;
        end
    end
end
figure;
imshow(resultArray);
title('Detección de CFAR');

%-----------------------------------------------------------------------------
% 5.Target pixel clustering
%-----------------------------------------------------------------------------
% % Density filtering
% [row col] = find(resultArray == 1);     % find the row and column coordinates of the target pixel
% numIndex2 = numel(row);                 % determine the number of target points
% resultArray2 = zeros(size(g));          % resultArray2 is used to store the density filtered matrix
% for k = 1:numIndex2                     % perform density filtering
%     resultArray2(row(k),col(k)) = densfilt(row(k),col(k),width,height,densGate);
% end

% Morphological filtering
se = strel('disk',2);
resultArray2 = imclose(resultArray,se);  % Closing
se = strel('disk',1);
resultArray3 = imerode(resultArray2,se);  % Erosion
se = strel('disk',2);
resultArray4 = imopen(resultArray3,se);  % Opening
% waitbar(1,hWaitbar,'Done');
% close(hWaitbar); 

% Output the result
figure;
imshow(resultArray2);
figure;
imshow(resultArray3);
figure;
imshow(resultArray4);

% End the timer
toc

%-----------------------------------------------------------------------------
% Functions used in this algorithm
%-----------------------------------------------------------------------------

% 1.Density filter function
function value = densfilt(r,c,width,height,densGate)
%   value=densfilt(r,c,width,height,densGate)，
% r, c represent the row and column of the test pixel, respectively
% width and height represent the width and height of the filtering rectangle template, respectively
% densGate represents the filtering threshold, and value is the discrimination result

global resultArray
a = ceil(height/2);
b = ceil(width/2);
% Calculate the position of the filter rectangle template centered on the test pixel
rStart = r - a;
rEnd = r + a;
cStart = c - b;
cEnd = c + b;

% Get the number of target pixels in the rectangular model template
densSection = resultArray(rStart:rEnd,cStart:cEnd);
num = sum(densSection(:));

% Judgment filtering
if num >= densGate
    value = 1;
else
    value = 0;
end

% 2.Get the row and column index values of the four clutter parameter estimation areas
function [csIndex1 csIndex2 csIndex3 csIndex4] = getEstSec(r,c,method)
% r, c represent the row and column of the test pixel, the method is not used

global tMaxLength;
global proLength;
global cLength;
global cfarHalfLength;
global cfarLength;

% csX is a row vector, including the starting index value, length and width of the upper left corner of each CFAR detector area
cs1 = [r-cfarHalfLength c-cfarHalfLength cfarLength cLength];
cs2 = [r+tMaxLength+1 c-cfarHalfLength cfarLength cLength];
cs3 = [r-tMaxLength c-cfarHalfLength cLength proLength];
cs4 = [r-tMaxLength c+tMaxLength+1 cLength proLength];

% csIndexX is a row vector containing the start and end row and column indices of each CFAR detector area
csIndex1 = [cs1(1) cs1(1)+cs1(4)-1 cs1(2) cs1(2)+cs1(3)-1];
csIndex2 = [cs2(1) cs2(1)+cs2(4)-1 cs2(2) cs2(2)+cs2(3)-1];
csIndex3 = [cs3(1) cs3(1)+cs3(4)-1 cs3(2) cs3(2)+cs3(3)-1];
csIndex4 = [cs4(1) cs4(1)+cs4(4)-1 cs4(2) cs4(2)+cs4(3)-1];

% 3.Calculate the mean and standard deviation in the clutter region in the CFAR detector
function [u,delta] = cfarEstPra(csIn1,csIn2,csIn3,csIn4)
% csIn4 represents the four clutter pixel areas, returns the mean and standard deviation

global g;
% Get the pixel value of the clutter area
sec1 = g(csIn1(1):csIn1(2),csIn1(3):csIn1(4));
sec2 = g(csIn2(1):csIn2(2),csIn2(3):csIn2(4));
sec3 = g(csIn3(1):csIn3(2),csIn3(3):csIn3(4));
sec4 = g(csIn4(1):csIn4(2),csIn4(3):csIn4(4));

% Row vector merge
sec1 = sec1(:);
sec2 = sec2(:);
sec3 = sec3(:);
sec4 = sec4(:);
sec = [sec1;sec2;sec3;sec4];

% Get parameters
u = mean(sec);
e2 = mean(sec.^2);
delta = sqrt(e2 - u^2);
% global g_dis;
% g_dis(csIn1(1):csIn1(2),csIn1(3):csIn1(4))=0;    
%
% g_dis(csIn2(1):csIn2(2),csIn2(3):csIn2(4))=0;
%
% g_dis(csIn3(1):csIn3(2),csIn3(3):csIn3(4))=0;
%
% g_dis(csIn4(1):csIn4(2),csIn4(3):csIn4(4))=0;
% imshow(g_dis,[])
