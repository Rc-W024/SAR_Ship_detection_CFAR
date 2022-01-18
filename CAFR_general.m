function sar_cfar_6(hObject,eventdata,handles,f)
%SAR图像CFAR目标检测算法，算法采用的是基于瑞利分布的双参数CFAR算法
%   sar_cfar_4(hObject,eventdata,handles,f)，hObject,eventdata,handles分别是
%   图形界面程序传递下来的对象，事件，句柄；在这里，对象和事件均未使用，只使用了
%   句柄，f为输入的SAR图像，此时，SAR图像已经由三维变成了一维
tic

f = imread('G:\TFM\Expermiento\XXX.jpg');
figure;
imshow(f);
title('Original');

Pfa = 0.04;                       %人为设定的恒虚警率
% densGate = 0.01;                %密度滤波阈值
% rad = 1;                        %形态学滤波结构元素半径值

%--图像前期处理
f = double(f);
f_size = size(f);

%--交互的确定目标尺寸 
width = 5;
height = 10;

%--------------------------------------------------------------------------
%        1. 确定CFAR检测器参数，包括窗口尺寸，保护区宽度，杂波区宽度
%--------------------------------------------------------------------------

%--确定CFAR检测器的参数
%--1.取长宽中的最大值
global tMaxLength;
tMaxLength = max(width,height);

%--2.确定保护区的边长
global proLength;
proLength = tMaxLength*2 + 1;                           %为方便计算，取为奇数

%--3.确定杂波区环形宽度
global cLength;
cLength = 1;                                            %厚度一般为1个像素点

%--4.计算用于杂波区域的像素数
numPix = 2*cLength*(2*cLength+proLength+proLength); 

%--5.CFAR检测器边长的一半
global cfarHalfLength;
cfarHalfLength = tMaxLength+cLength;

%--6.CFAR检测器边长
global cfarLength;
cfarLength = proLength + 2*cLength;
str = sprintf('CFAR检测器保护区边长：%f，杂波区环形宽度：%f，用于杂波的像素数：%f'...
              ,proLength,cLength,numPix);               %显示
disp(str);                                              %显示

%--------------------------------------------------------------------------
%         2. 对原图像边界扩充，以消除边界的影响
%--------------------------------------------------------------------------
padLength = cfarHalfLength;           %确定图像填充的边界大小为CFAR滑窗的一半
global g;
g = padarray(f,[padLength padLength],'symmetric');      %g为填充后的图像
% global g_dis;                                           %画图
% g_dis = g;                                              %画图

%--------------------------------------------------------------------------
%         3. 确定CFAR阈值
%--------------------------------------------------------------------------

th = (2*sqrt(-log(Pfa))-sqrt(pi))/(sqrt(4-pi));  %该阈值由认为确定的虚警概率求得

%--------------------------------------------------------------------------
%        4. 利用CFAR检测器，求解局部阈值，执行单个像素点的判断
%--------------------------------------------------------------------------

%--1.定义结果处理矩阵
global resultArray
resultArray = zeros(size(g));

%--2.CFAR检测

%这里将CFAR检测器划分为四个检测区，如下图所示
%
%          |—————————————|
%          |——————-1——————|
%          |   |                |   |
%          |   |                |   |
%          | 3 |                | 4 |
%          |   |                |   |
%          |   |                |   |
%          |   |                |   |
%          |—————————————|  
%          |——————-2——————|
%遍历图像中的每个点

for i = (1+padLength):(f_size(1)+padLength)
    for j = (1+padLength):(f_size(2)+padLength)
        [csIndex1 csIndex2 csIndex3 csIndex4] = getEstSec(i,j,1);
                        %得到(i,j)处像素所对应的4个杂波估计区域，如上图所示
        [u,delta] = cfarEstPra(csIndex1,csIndex2,csIndex3,csIndex4);
                        %由杂波区域得到均值和标准偏差
        temp = (g(i,j)-u)/delta;    %计算双参数CFAR检测判别式
        %目标点判别
        if temp > th                
            resultArray(i,j) = 255;
        else resultArray(i,j) = 0;
        end
    end
end
figure;
imshow(resultArray);
title('Detección de CFAR');
%--------------------------------------------------------------------------
%                         五、目标像素聚类
%--------------------------------------------------------------------------
%--1.密度滤波
% [row col] = find(resultArray == 1);     %找到目标像素点的行列坐标
% numIndex2 = numel(row);                 %确定目标点个数
% resultArray2 = zeros(size(g));          %resultArray2用以存放密度滤波后的矩阵
% for k = 1:numIndex2                     %执行密度滤波
%     resultArray2(row(k),col(k)) = densfilt(row(k),col(k),width,height,...
%                                    densGate);
% end

%--2.形态学滤波
se = strel('disk',2);
resultArray2 = imclose(resultArray,se);
se = strel('disk',1);
resultArray3 = imerode(resultArray2,se);
se = strel('disk',2);
resultArray4 = imopen(resultArray3,se);
% waitbar(1,hWaitbar,'Done');
% close(hWaitbar); 

%--3.展示结果图片
figure;
imshow(resultArray2);
title('Cierre');
figure;
imshow(resultArray3);
title('Erosión');
figure;
imshow(resultArray4);
title('Apertura');

toc

%--------------------------------------------------------------------------
%                            本算法中用到的函数
%--------------------------------------------------------------------------

%------------1. 密度滤波函数-----------------------------------------------
function value = densfilt(r,c,width,height,densGate)
%   value=densfilt(r,c,width,height,densGate)，r、c分别代表测试像素的行和列；
%   width、height分表代表滤波矩形模板的宽和高，densGate代表滤波阈值，value值是判别结果

global resultArray
a = ceil(height/2);
b = ceil(width/2);
%--1.计算以测试像素为中心的滤波矩形模板的位置
rStart = r - a;
rEnd = r + a;
cStart = c - b;
cEnd = c + b;

%--2.得到矩形模型模板中的目标像素数
densSection = resultArray(rStart:rEnd,cStart:cEnd);
num = sum(densSection(:));

%--3.判断滤波
if num >= densGate
    value = 1;
else
    value = 0;
end

%-------------2. 得到四个杂波参数估计区域的行列索引值------------------------
function [csIndex1 csIndex2 csIndex3 csIndex4] = getEstSec(r,c,method)
%   [csIndex1 csIndex2 csIndex3 csIndex4] = getEstSec(r,c,method)，r、c代表
%   测试像素的行和列，method没有采用，保留

global tMaxLength;
global proLength;
global cLength;
global cfarHalfLength;
global cfarLength;
%--1.csX为一个行向量，包括各个CFAR检测器区域的左上角起始索引值，长度和宽度
cs1 = [r-cfarHalfLength c-cfarHalfLength cfarLength cLength];
cs2 = [r+tMaxLength+1 c-cfarHalfLength cfarLength cLength];
cs3 = [r-tMaxLength c-cfarHalfLength cLength proLength];
cs4 = [r-tMaxLength c+tMaxLength+1 cLength proLength];

%--2.csIndexX也是一个行向量，包括各个CFAR检测器区域的起始与结束行列索引
csIndex1 = [cs1(1) cs1(1)+cs1(4)-1 cs1(2) cs1(2)+cs1(3)-1];
csIndex2 = [cs2(1) cs2(1)+cs2(4)-1 cs2(2) cs2(2)+cs2(3)-1];
csIndex3 = [cs3(1) cs3(1)+cs3(4)-1 cs3(2) cs3(2)+cs3(3)-1];
csIndex4 = [cs4(1) cs4(1)+cs4(4)-1 cs4(2) cs4(2)+cs4(3)-1];

%--------------3. 计算CFAR检测器内位于杂波区域的均值、标准偏差---------------
function [u,delta] = cfarEstPra(csIn1,csIn2,csIn3,csIn4)
%   [u,delta] = cfarEstPra(csIn1,csIn2,csIn3,csIn4)，csIn1,csIn2,csIn3,
%   csIn4代表四个杂波像素区域，返回均值和标准偏差

global g;
%--1.以下获得杂波区域的像素值
sec1 = g(csIn1(1):csIn1(2),csIn1(3):csIn1(4));
sec2 = g(csIn2(1):csIn2(2),csIn2(3):csIn2(4));
sec3 = g(csIn3(1):csIn3(2),csIn3(3):csIn3(4));
sec4 = g(csIn4(1):csIn4(2),csIn4(3):csIn4(4));

%--2.行向量合并
sec1 = sec1(:);
sec2 = sec2(:);
sec3 = sec3(:);
sec4 = sec4(:);
sec = [sec1;sec2;sec3;sec4];

%--3.求取参数
u = mean(sec);
e2 = mean(sec.^2);
delta = sqrt(e2 - u^2);
% global g_dis;
% g_dis(csIn1(1):csIn1(2),csIn1(3):csIn1(4))=0;    
%                                                                      %画图
% g_dis(csIn2(1):csIn2(2),csIn2(3):csIn2(4))=0;
%                                                                      %画图
% g_dis(csIn3(1):csIn3(2),csIn3(3):csIn3(4))=0;
%                                                                      %画图
% g_dis(csIn4(1):csIn4(2),csIn4(3):csIn4(4))=0;
% imshow(g_dis,[])                                                     %画图
