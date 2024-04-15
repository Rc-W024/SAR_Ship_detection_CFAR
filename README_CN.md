# 基于CFAR的SAR舰船检测算法
[English](README.md) | 中文

![](https://img.shields.io/static/v1?label=%F0%9F%8C%9F&message=If%20Useful&style=flat&color=BC4E99)
![](https://img.shields.io/github/stars/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/forks/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/issues/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/license/Rc-W024/SAR_Ship_detection_CFAR.svg)

[**Two-Parameter CFAR Ship Detection Algorithm Based on Rayleigh Distribution in SAR Images**](https://www.preprints.org/manuscript/202112.0280/v1)

*可在[paperswithcode.com](https://paperswithcode.com/paper/two-parameter-cfar-ship-detection-algorithm)中查看.*

合成孔径雷达（SAR）影像目标检测是雷达图像解译应用的重要需求之一，该项目提出了一种改进的基于瑞利分布的双参数恒虚警率（CFAR）算法，并将其与形态学处理相结合，用于高分辨率SAR图像舰船目标检测与识别。在本项目中，将提供一些简单的模板代码，以帮助初学者理解和学习相关的理论和算法。它们不仅适用于简单的实验，也适用于今后的扩展。

## 恒虚警率
CFAR算法是一种像素级的目标检测算法，对于车辆、舰船、飞机等目标来说，一般要求目标本身与背景杂波有强烈的对比。通过判断每个像素的灰度值是否超过某个预设值来实现目标检测。在这种情况下，检测阈值一般与虚警率、目标周围背景杂波的统计模型和CFAR检测器有关。

![image](https://user-images.githubusercontent.com/97808991/149919888-7098ff76-ead1-4d0f-9dfd-b47c1d5d6aec.png)

通常，CFAR检测算法主要通过导入SAR图像并识别整个图像中的每个像素，并根据图像确定背景的杂波分布，然后估计滑动窗口中杂波像素的分布参数。在给定虚警率的情况下求解CFAR阈值，并与对应的像素值进行比较，从而得到每个像素的检测结果。这个过程将对输入SAR图像中的所有像素进行处理，最终遍历整个图像得到检测结果。

## 数学形态学
数学形态学是一种基于集合论、格论、拓扑和随机函数的几何结构分析与处理技术。它不仅适用于数字图像，还可用于图形、多边形网格、实体和许多其他空间结构。对于滤波后的SAR图像，简单的腐蚀操作可以去除图像中被误判为目标像素的、具有独立高亮度的、小的、无意义的物体和散斑噪声；而膨胀运算可以填充目标区域中低值散斑噪声造成的空隙，也可以补全缺失的目标像素，连接相邻的未连接的目标区域像素。

## 可用数据集
实验数据集使用了中国资源卫星应用中心和哥白尼开放数据访问中心提供的**高分三号**和**哨兵一号**SAR卫星影像。

GitHub Rep: [`CAESAR-Radi/SAR-Ship-Dataset`](https://github.com/CAESAR-Radi/SAR-Ship-Dataset)

## 文件简介
Folder `Raw images` --- 用于船舶检测的SAR图像切片，其中包含了对应的目标信息（XLM文件）

![image](https://user-images.githubusercontent.com/97808991/149931264-456b8d39-c7f2-423b-ba48-a471109e8844.png)

[`CFAR_ship_detection`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/CAFR_ship_detection.m) --- 基础算法代码，内附详细注释

[`Rayleigh_distribution`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/Rayleigh_distribution.m) --- 绘制瑞利分布的概率密度图

![image](https://user-images.githubusercontent.com/97808991/149931239-b8c9b1b2-2e62-40c5-acec-c2fac02278e4.png)

[`Target_mark`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/Target_mark.m) --- 简单的目标框代码，研究标记目标的方法

![gf_hh_01](https://user-images.githubusercontent.com/97808991/149931364-a7f6d9e7-230b-4d32-b9d8-912184051510.png)

## 参考信息
### 预印本论文...
**引用：**

```bibtex
@article{wu2021cfar,
 title={Two-Parameter CFAR Ship Detection Algorithm Based on Rayleigh Distribution in SAR Images},
 author={Wu, Ruochen},
 year={2021},
 number={2021120280},
 journal={Preprints},
 issn={2310-287X},
 url={https://doi.org/10.20944/preprints202112.0280.v1},
 doi={10.20944/preprints202112.0280.v1},
}
```

### 硕士论文（西班牙语）...
DETECCIÓN Y RECONOCIMIENTO DE BLANCOS BASADOS EN IMÁGENES SAR (Spainsh Version)<br>http://hdl.handle.net/10251/166986 (Trabajo Fin de Máster - Universitat Politècnica de València)

Wu, R. (2021). Detección y reconocimiento de blancos basados en imágenes SAR. Universitat Politècnica de València. HANDLE: [10251/166986](http://hdl.handle.net/10251/166986)

**引用：**

```bibtex
@masterthesis{wu2021sar,
  title={Detección y reconocimiento de blancos basados en imágenes SAR},
  author={Wu, Ruochen},
  year=2021,
  month={May},
  address={València, Spain},
  note={Available at \url{http://hdl.handle.net/10251/166986}},
  school={Universitat Politècnica de València},
  type= {Master's thesis}
}
```
