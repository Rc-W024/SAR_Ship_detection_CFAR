# SAR Ship detection based on CFAR
SAR image targets detection is one of the main needs of radar image interpretation applications. In this project, an improved two-parameter CFAR algorithm based on Rayleigh distribution and morphological processing is proposed to perform ship detection and recognition in high resolution SAR images. In this project, I will provide a few simple template codes to help beginners understand and learn related theories and algorithms. They are not only suitable for simple experiments, but also suitable for later expansion. 

Hope it helps you！

## Constant False Alarm Rate (CFAR)
CFAR is a pixel-level target detection algorithm. For targets such as vehicles, ships, and aircrafts, they are generally required to have a strong contrast to the background clutter. Target detection is achieved by judging whether the gray value of each pixel exceeds a certain preset value. In this case, the detection threshold is generally related to the false alarm rate, the statistical pattern of the background disorder around the target and the CFAR detector.

![image](https://user-images.githubusercontent.com/97808991/149919888-7098ff76-ead1-4d0f-9dfd-b47c1d5d6aec.png)

In general, the CFAR detection algorithm consists of importing a SAR image and discerning each pixel in the entire image. Determine the background distribution of the clutter based on the SAR image and then estimate the distribution parameters of the clutter pixels in the sliding window. In the case of a given false alarm probability, the CFAR threshold is resolved and compared with the corresponding pixel value to obtain the pixel detection result. This process will work with all the pixels in the input SAR image, eventually traversing the entire image to get the detection result.

## Mathematical Morphology (MM)
MM is a technique for the analysis and treatment of geometric structures, based on set theory, lattice theory, topology and random functions. It not only applies to digital images, but can be used for graphics, polygon meshes, solids, and many other spatial structures.

For the filtered SAR image, a simple erosion operation can remove small nonsensical objects and speckle noises with independent high brightness that is erroneously judged as the target pixel in the image. And the dilation operation can fill the black hole caused by the low value speckle noises in the target area, and it can also fill in the missing target pixels and connect the adjacent unconnected target area pixels.

## Introduction for files
Folder "Raw images" --- Some slices of SAR images are provided to perform ship detection. It also contains target information, which is in the XLM file.

CFAR_ship_detection --- Algorithm code, which has a detailed explanation.

Rayleigh_distribution --- Plot the probability density of the Rayleigh distribution.

Target_mark --- A simple target box code that can be used to study marking the target.

## One more thing...
If you are interested in this project, you can also study my preprint paper: https://www.preprints.org/manuscript/202112.0280/v1

Wu, R. Two-Parameter CFAR Ship Detection Algorithm Based on Rayleigh Distribution in SAR Images. Preprints 2021, 2021120280 (doi: 10.20944/preprints202112.0280.v1).
