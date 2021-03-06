# SAR Ship detection based on CFAR
SAR image targets detection is one of the main needs of radar image interpretation applications. In this project, an improved two-parameter CFAR algorithm based on Rayleigh distribution and morphological processing is proposed to perform ship detection and recognition in high resolution SAR images. In this project, I will provide a few simple template codes to help beginners understand and learn related theories and algorithms. They are not only suitable for simple experiments, but also suitable for later expansion. 

Hope it helps you!

SAR图像目标检测是雷达图像解译应用的重要需求之一，该项目提出了一种改进的基于瑞利分布的双参数CFAR算法，并将其与形态学处理相结合，应用于高分辨率合成孔径雷达图像舰船检测与识别。在本项目中，我将提供一些简单的模板代码，帮助初学者理解和学习相关的理论和算法。它们不仅适用于简单的实验，也适用于以后的扩展。希望对你有帮助！

## Constant False Alarm Rate (CFAR)
CFAR is a pixel-level target detection algorithm. For targets such as vehicles, ships, and aircrafts, they are generally required to have a strong contrast to the background clutter. Target detection is achieved by judging whether the gray value of each pixel exceeds a certain preset value. In this case, the detection threshold is generally related to the false alarm rate, the statistical model of the background clutter around the target and the CFAR detector.

恒虚警算法是一种像素级的目标检测算法，对于车辆、舰船、飞机等目标来说，一般要求与背景杂波有强烈的对比。通过判断每个像素的灰度值是否超过某个预设值，来实现木目标的检测。在这种情况下，检测阈值一般与虚警率、目标周围背景杂波的统计模型和CFAR检测器有关。

![image](https://user-images.githubusercontent.com/97808991/149919888-7098ff76-ead1-4d0f-9dfd-b47c1d5d6aec.png)

In general, the CFAR detection algorithm consists of importing a SAR image and discerning each pixel in the entire image. Determine the background distribution of the clutter based on the SAR image and then estimate the distribution parameters of the clutter pixels in the sliding window. In the case of a given false alarm probability, the CFAR threshold is resolved and compared with the corresponding pixel value to obtain the pixel detection result. This process will work with all the pixels in the input SAR image, eventually traversing the entire image to get the detection result.

通常，CFAR检测算法包括导入SAR图像并识别整个图像中的每个像素，根据SAR图像确定背景的杂波分布，然后估计滑动窗口中杂波像素的分布参数。在给定虚警率的情况下，求解CFAR阈值并与对应的像素值进行比较，得到每个像素的检测结果。这个过程将对输入SAR图像中的所有像素进行处理，最终遍历整个图像得到检测结果。

## Mathematical Morphology (MM)
MM is a technique for the analysis and treatment of geometric structures, based on set theory, lattice theory, topology and random functions. It not only applies to digital images, but can be used for graphics, polygon meshes, solids, and many other spatial structures.

For the filtered SAR image, a simple erosion operation can remove small nonsensical objects and speckle noises with independent high brightness that is erroneously judged as the target pixel in the image. And the dilation operation can fill the black hole caused by the low value speckle noises in the target area, and it can also fill in the missing target pixels and connect the adjacent unconnected target area pixels.

数学形态学是一种基于集合论、格论、拓扑和随机函数的几何结构分析和处理技术，它不仅适用于数字图像，还可用于图形、多边形网格、实体和许多其他空间结构。对于滤波后的SAR图像，简单的腐蚀操作可以去除图像中被误判为目标像素的、具有独立高亮度的、小的、无意义的物体和散斑噪声；而膨胀运算可以填充目标区域中低值散斑噪声造成的空隙，也可以填充缺失的目标像素，连接相邻的未连接的目标区域像素。

## Introduction for files
Folder "Raw images" --- Some slices of SAR images are provided to perform ship detection. It also contains target information, which is in the XLM file.

文件夹“Raw images”：提供了一些SAR图像切片来执行船舶检测，其中还包含了对应的XLM文件中的目标信息

![image](https://user-images.githubusercontent.com/97808991/149931264-456b8d39-c7f2-423b-ba48-a471109e8844.png)

CFAR_ship_detection --- Algorithm code, which has a detailed explanation.

CFAR_ship_detection：基础算法代码，里面有详细的解释

Rayleigh_distribution --- Plot the probability density of the Rayleigh distribution.

Rayleigh_distribution：绘制瑞利分布的概率密度图

![image](https://user-images.githubusercontent.com/97808991/149931239-b8c9b1b2-2e62-40c5-acec-c2fac02278e4.png)

Target_mark --- A simple target box code that can be used to study marking the target.

Target_mark：一个简单的目标框代码，可以用来研究标记目标的方法

![gf_hh_01](https://user-images.githubusercontent.com/97808991/149931364-a7f6d9e7-230b-4d32-b9d8-912184051510.png)

## One more thing...
If you are interested in this project, you can also study my preprint paper: https://www.preprints.org/manuscript/202112.0280/v1

Wu, R. Two-Parameter CFAR Ship Detection Algorithm Based on Rayleigh Distribution in SAR Images. Preprints 2021, 2021120280 (doi: 10.20944/preprints202112.0280.v1).

如果你对这个项目感兴趣，也可以了解研究一下我的预印本论文！（当然还有下面的硕士论文，但是西班牙语版本的！

## Relevant Master's Thesis...
Detección y reconocimiento de blancos basados en imágenes SAR: http://hdl.handle.net/10251/166986 (TRABAJO FIN DE MÁSTER - UNIVERSITAT POLITÈCNICA DE VALÈNCIA)

引用格式 Citation format：Wu, R. (2021). Detección y reconocimiento de blancos basados en imágenes SAR. Universitat Politècnica de València. http://hdl.handle.net/10251/166986
