# SAR Ship detection based on CFAR
English | [中文](README_CN.md) | [Español](README_ES.md)

![](https://img.shields.io/static/v1?label=%F0%9F%8C%9F&message=If%20Useful&style=flat&color=BC4E99)
![](https://img.shields.io/github/stars/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/forks/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/issues/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/license/Rc-W024/SAR_Ship_detection_CFAR.svg)

[**Two-Parameter CFAR Ship Detection Algorithm Based on Rayleigh Distribution in SAR Images**](https://www.preprints.org/manuscript/202112.0280/v1)

*It is available on [paperswithcode.com](https://paperswithcode.com/paper/two-parameter-cfar-ship-detection-algorithm).*

SAR image targets detection is one of the main needs of radar image interpretation applications. In this project, an improved two-parameter CFAR algorithm based on Rayleigh distribution and morphological processing is proposed to perform ship detection and recognition in high resolution SAR images. In this project, I will provide a few simple template codes to help beginners understand and learn related theories and algorithms. They are not only suitable for simple experiments, but also suitable for later expansion. 

Hope it helps you! ¡Ahora vamos!

## Constant False Alarm Rate (CFAR)
CFAR is a pixel-level target detection algorithm. For targets such as vehicles, ships, and aircrafts, they are generally required to have a strong contrast to the background clutter. Target detection is achieved by judging whether the gray value of each pixel exceeds a certain preset value. In this case, the detection threshold is generally related to the false alarm rate, the statistical model of the background clutter around the target and the CFAR detector.

![image](https://user-images.githubusercontent.com/97808991/149919888-7098ff76-ead1-4d0f-9dfd-b47c1d5d6aec.png)

In general, the CFAR detection algorithm consists of importing a SAR image and discerning each pixel in the entire image. Determine the background distribution of the clutter based on the SAR image and then estimate the distribution parameters of the clutter pixels in the sliding window. In the case of a given false alarm probability, the CFAR threshold is resolved and compared with the corresponding pixel value to obtain the pixel detection result. This process will work with all the pixels in the input SAR image, eventually traversing the entire image to get the detection result.

## Mathematical Morphology (MM)
MM is a technique for the analysis and treatment of geometric structures, based on set theory, lattice theory, topology and random functions. It not only applies to digital images, but can be used for graphics, polygon meshes, solids, and many other spatial structures.

For the filtered SAR image, a simple erosion operation can remove small nonsensical objects and speckle noises with independent high brightness that is erroneously judged as the target pixel in the image. And the dilation operation can fill the black hole caused by the low value speckle noises in the target area, and it can also fill in the missing target pixels and connect the adjacent unconnected target area pixels.

## Available Dataset
China Center for Resources Satellite Data and Application, Copernicus Open Access Hub - Gaofen-3 & Sentinel-1

GitHub Rep: [`CAESAR-Radi/SAR-Ship-Dataset`](https://github.com/CAESAR-Radi/SAR-Ship-Dataset)

## Introduction for Files
Folder `Raw images` --- Some slices of SAR images are provided to perform ship detection. It also contains target information, which is in the *XLM* file.

![image](https://user-images.githubusercontent.com/97808991/149931264-456b8d39-c7f2-423b-ba48-a471109e8844.png)

[`CFAR_ship_detection`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/CAFR_ship_detection.m) --- Algorithm code, which has a detailed explanation.

[`Rayleigh_distribution`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/Rayleigh_distribution.m) --- Plot the probability density of the Rayleigh distribution.

![image](https://user-images.githubusercontent.com/97808991/149931239-b8c9b1b2-2e62-40c5-acec-c2fac02278e4.png)

[`Target_mark`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/Target_mark.m) --- A simple target box code that can be used to study marking the target.

![gf_hh_01](https://user-images.githubusercontent.com/97808991/149931364-a7f6d9e7-230b-4d32-b9d8-912184051510.png)

## FYI
### Preprint paper...
**Citation:**

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

### Master's thesis...
DETECCIÓN Y RECONOCIMIENTO DE BLANCOS BASADOS EN IMÁGENES SAR (Spainsh Version)<br>http://hdl.handle.net/10251/166986 (Trabajo Fin de Máster - Universitat Politècnica de València)

Wu, R. (2021). Detección y reconocimiento de blancos basados en imágenes SAR. Universitat Politècnica de València. HANDLE: [10251/166986](http://hdl.handle.net/10251/166986)

**Citation:**

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
## ⭐ Starchart
![star](https://starchart.cc/Rc-W024/SAR_Ship_detection_CFAR.svg)
