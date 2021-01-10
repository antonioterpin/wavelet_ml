# Wavelet preprocessing for deep learning based computer vision applications.

##### Table of Contents
1. [Introduction](#intro)
2. [Contributing](#contribute)
3. [Credits](#credits)

<a name="intro"></a>
## Introduction
This project started to try out the theoretical notions learnt within the "Advanced mathematical methods class for Electronic Engineering" class at the [École Normal of the University di Udine](https://scuolasuperiore.uniud.it), taught by Prof. Riccardo Bernardini. 

The applications of Wavelet are explored in the preprocessing step, to extract plausible regions to be classified afterwards. A multi-column CNN is then used to classify the proposals.

The wavelet approach seemed to be a promising approach, and the filter was tuned with bayesian optimization. The shape of the defect is further reconstructed with the alpha-shape algorithm, and finally the bounding box is determined.
| Some examples of region proposals |  | Step description |
|:-----|:-----|:-----|
|![3-1](https://github.com/antonioterpin/wavelet_ml/blob/master/images/detector-result-class3-1.jpg) | ![4-1](https://github.com/antonioterpin/wavelet_ml/blob/master/images/detector-result-class4-1.jpg) | Input image (defect marked for clarity) |
|![3-2](https://github.com/antonioterpin/wavelet_ml/blob/master/images/detector-result-class3-2.jpg) | ![4-2](https://github.com/antonioterpin/wavelet_ml/blob/master/images/detector-result-class4-2.jpg) | Preprocessing step |
|![3-3](https://github.com/antonioterpin/wavelet_ml/blob/master/images/detector-result-class3-3.jpg) | ![4-3](https://github.com/antonioterpin/wavelet_ml/blob/master/images/detector-result-class4-3.jpg) | Wavelet filtering & Alpha shape reconstruction |
|![3-4](https://github.com/antonioterpin/wavelet_ml/blob/master/images/detector-result-class3-4.jpg) | ![4-4](https://github.com/antonioterpin/wavelet_ml/blob/master/images/detector-result-class4-4.jpg) | Bounding boxes extraction |

Since the extracted proposal region was centered in a black image for convenience, we needed to teach the network how to learn from input with different amount of information. To this aim we designed the convolutional layers interpreting the dilation factor in an unconventional (probably) way, but we did not studied further whether this actually was really a good idea. However, in our first experiments it resulted in a slight improvement of the classification performance.
The idea was mainly to use the first convolutional layers to spread the information over the all image, so that the consecutive downsampling did not reduce too much the resolution. This could be done statically, but with a convolutional layer the network learnt how to properly do this to adapt to the shape of the different defect classes.

Below, you can see the final output of two architectures. Although they carry the same amount of information, the right one (with this usage of the dilation factor) has much less dimensions and thus, it was possible to train it easily even in our resource constrained environment.

| Traditional approach | With dilation factor |
|:-----|:-----|
|![Traditional](https://github.com/antonioterpin/wavelet_ml/blob/master/images/act_net_out.jpg)|![Dilation factor](https://github.com/antonioterpin/wavelet_ml/blob/master/images/act_net_hope_out.jpg)|

Please, have a look at the detailed (and slightly ambitious) [report](https://github.com/antonioterpin/wavelet_ml/blob/master/defect_detection.pdf) if you are curious about our first experiments. This was the corresponding semester thesis at the École normale of Udine, but it is not that innovative after all. It was fun and interesting though to learn all of these stuff. After all, everybody starts somewhere 😁

<a name="contributors"><a/>
## Contribute
We still need to connect the classification module to the segmentation one to make the pipeline work properly, and we would like to try and compare different architectures now that we have a bit more experience. However, this project is currently in stash. If someone would be interesting in helping and improving it, feel free to drop an [email](mailto:terpin.antonio@spes.uniud.it).

### Contributors
+ [Antonio Terpin](https://github.com/antonioterpin) - BSc Electronic Engineering École normale of Udine (Italy)
+ [Claudio Verardo](https://github.com/claudioverardo) - BSc Electronic Engineering École normale of Udine (Italy)

<a name="credits"><a/>
## Credits
The project and the sample images are from the [Kaggle challenge of Severstal](https://www.kaggle.com/c/severstal-steel-defect-detection). Whenever we are missing some credits acknowledgements, please let us know and we will fix it.
