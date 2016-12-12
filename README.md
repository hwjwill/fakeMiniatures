# Fake Miniature

This project create fake miniatures by simulating the effect of selective focus cameras, also known as [Tilt Shift](https://en.wikipedia.org/wiki/Tilt%E2%80%93shift_photography). Most methods rely on photo editors like GIMP and Photoshop to achieve the effect. A user selects a focus plane by masking a region of interests and applying a blurring filter to the rest of the image. Effectively this narrows the perceived depth of field in the scene and creates the illusion that the lens was really close to the subject. For more information, please visit [here](https://inst.eecs.berkeley.edu/~cs194-26/fa16/upload/files/projFinalUndergrad/cs194-26-acm/).

![Example](https://inst.eecs.berkeley.edu/~cs194-26/fa16/upload/files/projFinalUndergrad/cs194-26-acm/dblurred.jpg)

# To run code
```
main(<name of image file>, <depth of field>, <number of bands to blur above and below depth of field>, <maximum sigma>)
``` 