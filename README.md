# SAR Ship detection based on CFAR
![](https://img.shields.io/static/v1?label=%F0%9F%8C%9F&message=If%20Useful&style=flat&color=BC4E99)
![](https://img.shields.io/github/stars/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/forks/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/issues/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/license/Rc-W024/SAR_Ship_detection_CFAR.svg)

SAR image targets detection is one of the main needs of radar image interpretation applications. In this project, an improved two-parameter CFAR algorithm based on Rayleigh distribution and morphological processing is proposed to perform ship detection and recognition in high resolution SAR images. In this project, I will provide a few simple template codes to help beginners understand and learn related theories and algorithms. They are not only suitable for simple experiments, but also suitable for later expansion. 

Hope it helps you! ¡Ahora vamos!

合成孔径雷达（SAR）影像目标检测是雷达图像解译应用的重要需求之一，该项目提出了一种改进的基于瑞利分布的双参数恒虚警率（CFAR）算法，并将其与形态学处理相结合，用于高分辨率SAR图像舰船目标检测与识别。在本项目中，将提供一些简单的模板代码，以帮助初学者理解和学习相关的理论和算法。它们不仅适用于简单的实验，也适用于今后的扩展。

## Constant False Alarm Rate (CFAR)
CFAR is a pixel-level target detection algorithm. For targets such as vehicles, ships, and aircrafts, they are generally required to have a strong contrast to the background clutter. Target detection is achieved by judging whether the gray value of each pixel exceeds a certain preset value. In this case, the detection threshold is generally related to the false alarm rate, the statistical model of the background clutter around the target and the CFAR detector.

CFAR算法是一种像素级的目标检测算法，对于车辆、舰船、飞机等目标来说，一般要求目标本身与背景杂波有强烈的对比。通过判断每个像素的灰度值是否超过某个预设值来实现目标检测。在这种情况下，检测阈值一般与虚警率、目标周围背景杂波的统计模型和CFAR检测器有关。

![image](https://user-images.githubusercontent.com/97808991/149919888-7098ff76-ead1-4d0f-9dfd-b47c1d5d6aec.png)

In general, the CFAR detection algorithm consists of importing a SAR image and discerning each pixel in the entire image. Determine the background distribution of the clutter based on the SAR image and then estimate the distribution parameters of the clutter pixels in the sliding window. In the case of a given false alarm probability, the CFAR threshold is resolved and compared with the corresponding pixel value to obtain the pixel detection result. This process will work with all the pixels in the input SAR image, eventually traversing the entire image to get the detection result.

通常，CFAR检测算法主要通过导入SAR图像并识别整个图像中的每个像素，并根据图像确定背景的杂波分布，然后估计滑动窗口中杂波像素的分布参数。在给定虚警率的情况下求解CFAR阈值，并与对应的像素值进行比较，从而得到每个像素的检测结果。这个过程将对输入SAR图像中的所有像素进行处理，最终遍历整个图像得到检测结果。

## Mathematical Morphology (MM)
MM is a technique for the analysis and treatment of geometric structures, based on set theory, lattice theory, topology and random functions. It not only applies to digital images, but can be used for graphics, polygon meshes, solids, and many other spatial structures.

For the filtered SAR image, a simple erosion operation can remove small nonsensical objects and speckle noises with independent high brightness that is erroneously judged as the target pixel in the image. And the dilation operation can fill the black hole caused by the low value speckle noises in the target area, and it can also fill in the missing target pixels and connect the adjacent unconnected target area pixels.

数学形态学是一种基于集合论、格论、拓扑和随机函数的几何结构分析与处理技术。它不仅适用于数字图像，还可用于图形、多边形网格、实体和许多其他空间结构。对于滤波后的SAR图像，简单的腐蚀操作可以去除图像中被误判为目标像素的、具有独立高亮度的、小的、无意义的物体和散斑噪声；而膨胀运算可以填充目标区域中低值散斑噪声造成的空隙，也可以补全缺失的目标像素，连接相邻的未连接的目标区域像素。

## Available Data
China Center for Resources Satellite Data and Application, Copernicus Open Access Hub - Gaofen-3 & Sentinel-1

实验数据集使用了中国资源卫星应用中心和哥白尼开放数据访问中心提供的**高分三号**和**哨兵一号**SAR卫星影像。

GitHub Rep: [`CAESAR-Radi/SAR-Ship-Dataset`](https://github.com/CAESAR-Radi/SAR-Ship-Dataset)

## Introduction for Files
Folder `Raw images` --- Some slices of SAR images are provided to perform ship detection. It also contains target information, which is in the *XLM* file. 用于船舶检测的SAR图像切片，其中包含了对应的目标信息（XLM文件）

![image](https://user-images.githubusercontent.com/97808991/149931264-456b8d39-c7f2-423b-ba48-a471109e8844.png)

[`CFAR_ship_detection`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/CAFR_ship_detection.m) --- Algorithm code, which has a detailed explanation. 基础算法代码，内附详细注释

[`Rayleigh_distribution`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/Rayleigh_distribution.m) --- Plot the probability density of the Rayleigh distribution. 绘制瑞利分布的概率密度图

![image](https://user-images.githubusercontent.com/97808991/149931239-b8c9b1b2-2e62-40c5-acec-c2fac02278e4.png)

[`Target_mark`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/Target_mark.m) --- A simple target box code that can be used to study marking the target. 简单的目标框代码，研究标记目标的方法

![gf_hh_01](https://user-images.githubusercontent.com/97808991/149931364-a7f6d9e7-230b-4d32-b9d8-912184051510.png)

## One more thing...
### FYI:
### Preprint paper...
Wu, R. Two-Parameter CFAR Ship Detection Algorithm Based on Rayleigh Distribution in SAR Images. Preprints 2021, 2021120280. DOI: [10.20944/preprints202112.0280.v1](https://doi.org/10.20944/preprints202112.0280.v1)

### Master's thesis...
DETECCIÓN Y RECONOCIMIENTO DE BLANCOS BASADOS EN IMÁGENES SAR (Spainsh Version)<br>http://hdl.handle.net/10251/166986 (Trabajo Fin de Máster - Universitat Politècnica de València)

Wu, R. (2021). Detección y reconocimiento de blancos basados en imágenes SAR. Universitat Politècnica de València. HANDLE: [10251/166986](http://hdl.handle.net/10251/166986)
