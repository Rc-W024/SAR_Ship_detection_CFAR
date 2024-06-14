# Detección SAR basado en CFAR
[English](README.md) | [中文](README_CN.md) | Español

![](https://img.shields.io/static/v1?label=%F0%9F%8C%9F&message=If%20Useful&style=flat&color=BC4E99)
![](https://img.shields.io/github/stars/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/forks/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/issues/Rc-W024/SAR_Ship_detection_CFAR.svg)
![](https://img.shields.io/github/license/Rc-W024/SAR_Ship_detection_CFAR.svg)

[**Two-Parameter CFAR Ship Detection Algorithm Based on Rayleigh Distribution in SAR Images**](https://www.preprints.org/manuscript/202112.0280/v1)

*Está disponible en [paperswithcode.com](https://paperswithcode.com/paper/two-parameter-cfar-ship-detection-algorithm).*

La detección de blancos en imágenes de radar de apertura sintética (SAR) es una de las necesidades importantes de la aplicación de interpretación de imágenes de radar. Este proyecto propone un algoritmo mejorado de CFAR basado en distribución de Rayleigh con dos parámetros, combinado con operaciones morfológicas, para la detección y reconocimiento de blancos de barcos en imágenes SAR de alta resolución. En este proyecto, se proporciona algunos códigos simples para ayudar a los principiantes a comprender y aprender las teorías y algoritmos relevantes. Estos no solo son aplicables a experimentos simples, sino también a futuras ampliaciones.

## Tasa Constante de Falsas Alarmas (CFAR)
Las técnicas CFAR son un método de detección de blancos a nivel de píxel que requiere que los objetos, como vehículos, barcos y aviones, tengan un fuerte contraste con el ruido de fondo. La detección se realiza determinando si el valor de gris de cada píxel supera un valor preestablecido. En este caso, el umbral de detección generalmente está relacionado con la tasa de falsas alarmas, el modelo estadístico del ruido de fondo alrededor del blanco y el detector CFAR.

![image](https://user-images.githubusercontent.com/97808991/149919888-7098ff76-ead1-4d0f-9dfd-b47c1d5d6aec.png)

Normalmente, el algoritmo de detección CFAR opera principalmente importando una imagen SAR y reconociendo cada píxel en la imagen completa, y determinando la distribución del clutter del fondo basándose en la imagen. Luego, estima los parámetros de distribución de los píxeles de clutter en una ventana deslizante. Al resolver el umbral CFAR dado una tasa de falsa alarma específica, y compararlo con los valores de píxeles correspondientes, se obtienen los resultados de detección para cada píxel. Este proceso se aplica a todos los píxeles en la imagen SAR de entrada, recorriendo finalmente toda la imagen para obtener los resultados de detección.

## Morfología Matemática
La morfología matemática es una técnica de análisis y procesamiento de estructuras geométricas basada en la teoría de conjuntos, la teoría de retículos, la topología y funciones aleatorias. Es aplicable no solo a imágenes digitales, sino también a gráficos, mallas poligonales, sólidos y muchas otras estructuras espaciales. En el caso de imágenes SAR filtradas, una simple operación de erosión puede eliminar de la imagen los objetos pequeños, irrelevantes y de brillo independiente que se han identificado erróneamente como píxeles del blanco, así como el ruido de speckle; mientras que la operación de dilatación puede rellenar los huecos causados por el ruido de speckle de bajo valor en el área de blanco, completar los píxeles faltantes del blanco y conectar los píxeles de áreas adyacentes que no están conectados.

## Conjunto de Datos Disponible
Se utilizado el conjunto de datos de imágenes satelitales SAR de **Gaofen-3** y **Sentinel-1**, proporcionadas por el Centro de Aplicación de Satélites de Recursos de China y Copernicus Open Access Hub.

GitHub Rep: [`CAESAR-Radi/SAR-Ship-Dataset`](https://github.com/CAESAR-Radi/SAR-Ship-Dataset)

## Introducción de los ficheros
Carpeta `Raw images` --- Slices de imágenes SAR para la detección de barcos, que incluyen la información correspondiente del blanco (archivo XLM).

![image](https://user-images.githubusercontent.com/97808991/149931264-456b8d39-c7f2-423b-ba48-a471109e8844.png)

[`CFAR_ship_detection`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/CAFR_ship_detection.m) --- Código de algoritmo básico con comentarios detallados incluidos.

[`Rayleigh_distribution`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/Rayleigh_distribution.m) --- Para dibujar el gráfico de densidad de probabilidad de la distribución de Rayleigh.

![image](https://user-images.githubusercontent.com/97808991/149931239-b8c9b1b2-2e62-40c5-acec-c2fac02278e4.png)

[`Target_mark`](https://github.com/Rc-W024/SAR_Ship_detection_CFAR/blob/main/Target_mark.m) --- Código simpre de cuadro de blanco para estudiar métodos de marcar blancos.

![gf_hh_01](https://user-images.githubusercontent.com/97808991/149931364-a7f6d9e7-230b-4d32-b9d8-912184051510.png)

## FYI
### Preprint paper...
**Citación:**

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

### TFM...
DETECCIÓN Y RECONOCIMIENTO DE BLANCOS BASADOS EN IMÁGENES SAR<br>http://hdl.handle.net/10251/166986 (Trabajo Fin de Máster - Universitat Politècnica de València)

Wu, R. (2021). Detección y reconocimiento de blancos basados en imágenes SAR. Universitat Politècnica de València. HANDLE: [10251/166986](http://hdl.handle.net/10251/166986)

**Citación:**

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
