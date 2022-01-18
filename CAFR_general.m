function sar_cfar_6(hObject,eventdata,handles,f)
%SARͼ��CFARĿ�����㷨���㷨���õ��ǻ��������ֲ���˫����CFAR�㷨
%   sar_cfar_4(hObject,eventdata,handles,f)��hObject,eventdata,handles�ֱ���
%   ͼ�ν�����򴫵������Ķ����¼�������������������¼���δʹ�ã�ֻʹ����
%   �����fΪ�����SARͼ�񣬴�ʱ��SARͼ���Ѿ�����ά�����һά
tic

f = imread('G:\TFM\Expermiento\XXX.jpg');
figure;
imshow(f);
title('Original');

Pfa = 0.04;                       %��Ϊ�趨�ĺ��龯��
% densGate = 0.01;                %�ܶ��˲���ֵ
% rad = 1;                        %��̬ѧ�˲��ṹԪ�ذ뾶ֵ

%--ͼ��ǰ�ڴ���
f = double(f);
f_size = size(f);

%--������ȷ��Ŀ��ߴ� 
width = 5;
height = 10;

%--------------------------------------------------------------------------
%        1. ȷ��CFAR������������������ڳߴ磬��������ȣ��Ӳ������
%--------------------------------------------------------------------------

%--ȷ��CFAR������Ĳ���
%--1.ȡ�����е����ֵ
global tMaxLength;
tMaxLength = max(width,height);

%--2.ȷ���������ı߳�
global proLength;
proLength = tMaxLength*2 + 1;                           %Ϊ������㣬ȡΪ����

%--3.ȷ���Ӳ������ο��
global cLength;
cLength = 1;                                            %���һ��Ϊ1�����ص�

%--4.���������Ӳ������������
numPix = 2*cLength*(2*cLength+proLength+proLength); 

%--5.CFAR������߳���һ��
global cfarHalfLength;
cfarHalfLength = tMaxLength+cLength;

%--6.CFAR������߳�
global cfarLength;
cfarLength = proLength + 2*cLength;
str = sprintf('CFAR������������߳���%f���Ӳ������ο�ȣ�%f�������Ӳ�����������%f'...
              ,proLength,cLength,numPix);               %��ʾ
disp(str);                                              %��ʾ

%--------------------------------------------------------------------------
%         2. ��ԭͼ��߽����䣬�������߽��Ӱ��
%--------------------------------------------------------------------------
padLength = cfarHalfLength;           %ȷ��ͼ�����ı߽��СΪCFAR������һ��
global g;
g = padarray(f,[padLength padLength],'symmetric');      %gΪ�����ͼ��
% global g_dis;                                           %��ͼ
% g_dis = g;                                              %��ͼ

%--------------------------------------------------------------------------
%         3. ȷ��CFAR��ֵ
%--------------------------------------------------------------------------

th = (2*sqrt(-log(Pfa))-sqrt(pi))/(sqrt(4-pi));  %����ֵ����Ϊȷ�����龯�������

%--------------------------------------------------------------------------
%        4. ����CFAR����������ֲ���ֵ��ִ�е������ص���ж�
%--------------------------------------------------------------------------

%--1.�������������
global resultArray
resultArray = zeros(size(g));

%--2.CFAR���

%���ｫCFAR���������Ϊ�ĸ������������ͼ��ʾ
%
%          |��������������������������|
%          |������������-1������������|
%          |   |                |   |
%          |   |                |   |
%          | 3 |                | 4 |
%          |   |                |   |
%          |   |                |   |
%          |   |                |   |
%          |��������������������������|  
%          |������������-2������������|
%����ͼ���е�ÿ����

for i = (1+padLength):(f_size(1)+padLength)
    for j = (1+padLength):(f_size(2)+padLength)
        [csIndex1 csIndex2 csIndex3 csIndex4] = getEstSec(i,j,1);
                        %�õ�(i,j)����������Ӧ��4���Ӳ�������������ͼ��ʾ
        [u,delta] = cfarEstPra(csIndex1,csIndex2,csIndex3,csIndex4);
                        %���Ӳ�����õ���ֵ�ͱ�׼ƫ��
        temp = (g(i,j)-u)/delta;    %����˫����CFAR����б�ʽ
        %Ŀ����б�
        if temp > th                
            resultArray(i,j) = 255;
        else resultArray(i,j) = 0;
        end
    end
end
figure;
imshow(resultArray);
title('Detecci��n de CFAR');
%--------------------------------------------------------------------------
%                         �塢Ŀ�����ؾ���
%--------------------------------------------------------------------------
%--1.�ܶ��˲�
% [row col] = find(resultArray == 1);     %�ҵ�Ŀ�����ص����������
% numIndex2 = numel(row);                 %ȷ��Ŀ������
% resultArray2 = zeros(size(g));          %resultArray2���Դ���ܶ��˲���ľ���
% for k = 1:numIndex2                     %ִ���ܶ��˲�
%     resultArray2(row(k),col(k)) = densfilt(row(k),col(k),width,height,...
%                                    densGate);
% end

%--2.��̬ѧ�˲�
se = strel('disk',2);
resultArray2 = imclose(resultArray,se);
se = strel('disk',1);
resultArray3 = imerode(resultArray2,se);
se = strel('disk',2);
resultArray4 = imopen(resultArray3,se);
% waitbar(1,hWaitbar,'Done');
% close(hWaitbar); 

%--3.չʾ���ͼƬ
figure;
imshow(resultArray2);
title('Cierre');
figure;
imshow(resultArray3);
title('Erosi��n');
figure;
imshow(resultArray4);
title('Apertura');

toc

%--------------------------------------------------------------------------
%                            ���㷨���õ��ĺ���
%--------------------------------------------------------------------------

%------------1. �ܶ��˲�����-----------------------------------------------
function value = densfilt(r,c,width,height,densGate)
%   value=densfilt(r,c,width,height,densGate)��r��c�ֱ����������ص��к��У�
%   width��height�ֱ�����˲�����ģ��Ŀ�͸ߣ�densGate�����˲���ֵ��valueֵ���б���

global resultArray
a = ceil(height/2);
b = ceil(width/2);
%--1.�����Բ�������Ϊ���ĵ��˲�����ģ���λ��
rStart = r - a;
rEnd = r + a;
cStart = c - b;
cEnd = c + b;

%--2.�õ�����ģ��ģ���е�Ŀ��������
densSection = resultArray(rStart:rEnd,cStart:cEnd);
num = sum(densSection(:));

%--3.�ж��˲�
if num >= densGate
    value = 1;
else
    value = 0;
end

%-------------2. �õ��ĸ��Ӳ����������������������ֵ------------------------
function [csIndex1 csIndex2 csIndex3 csIndex4] = getEstSec(r,c,method)
%   [csIndex1 csIndex2 csIndex3 csIndex4] = getEstSec(r,c,method)��r��c����
%   �������ص��к��У�methodû�в��ã�����

global tMaxLength;
global proLength;
global cLength;
global cfarHalfLength;
global cfarLength;
%--1.csXΪһ������������������CFAR�������������Ͻ���ʼ����ֵ�����ȺͿ��
cs1 = [r-cfarHalfLength c-cfarHalfLength cfarLength cLength];
cs2 = [r+tMaxLength+1 c-cfarHalfLength cfarLength cLength];
cs3 = [r-tMaxLength c-cfarHalfLength cLength proLength];
cs4 = [r-tMaxLength c+tMaxLength+1 cLength proLength];

%--2.csIndexXҲ��һ������������������CFAR������������ʼ�������������
csIndex1 = [cs1(1) cs1(1)+cs1(4)-1 cs1(2) cs1(2)+cs1(3)-1];
csIndex2 = [cs2(1) cs2(1)+cs2(4)-1 cs2(2) cs2(2)+cs2(3)-1];
csIndex3 = [cs3(1) cs3(1)+cs3(4)-1 cs3(2) cs3(2)+cs3(3)-1];
csIndex4 = [cs4(1) cs4(1)+cs4(4)-1 cs4(2) cs4(2)+cs4(3)-1];

%--------------3. ����CFAR�������λ���Ӳ�����ľ�ֵ����׼ƫ��---------------
function [u,delta] = cfarEstPra(csIn1,csIn2,csIn3,csIn4)
%   [u,delta] = cfarEstPra(csIn1,csIn2,csIn3,csIn4)��csIn1,csIn2,csIn3,
%   csIn4�����ĸ��Ӳ��������򣬷��ؾ�ֵ�ͱ�׼ƫ��

global g;
%--1.���»���Ӳ����������ֵ
sec1 = g(csIn1(1):csIn1(2),csIn1(3):csIn1(4));
sec2 = g(csIn2(1):csIn2(2),csIn2(3):csIn2(4));
sec3 = g(csIn3(1):csIn3(2),csIn3(3):csIn3(4));
sec4 = g(csIn4(1):csIn4(2),csIn4(3):csIn4(4));

%--2.�������ϲ�
sec1 = sec1(:);
sec2 = sec2(:);
sec3 = sec3(:);
sec4 = sec4(:);
sec = [sec1;sec2;sec3;sec4];

%--3.��ȡ����
u = mean(sec);
e2 = mean(sec.^2);
delta = sqrt(e2 - u^2);
% global g_dis;
% g_dis(csIn1(1):csIn1(2),csIn1(3):csIn1(4))=0;    
%                                                                      %��ͼ
% g_dis(csIn2(1):csIn2(2),csIn2(3):csIn2(4))=0;
%                                                                      %��ͼ
% g_dis(csIn3(1):csIn3(2),csIn3(3):csIn3(4))=0;
%                                                                      %��ͼ
% g_dis(csIn4(1):csIn4(2),csIn4(3):csIn4(4))=0;
% imshow(g_dis,[])                                                     %��ͼ
