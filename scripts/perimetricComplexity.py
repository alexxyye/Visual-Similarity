from PIL import Image, ImageChops, ImageStat
import itertools, functools, os, fnmatch, re, pickle, math
import cv2
# image = cv2.imread('2.png')

#PIL can be difficult to install with pip. Try pip install Pillow instead.
def read_dic(mypath:str)-> list:
    onlyfiles = [mypath + '/'+f for f in listdir(mypath) if isfile(join(mypath, f)) and f != ".DS_Store"]
    return onlyfiles

def perimetricComplexity(image_file):

    img = Image.open(image_file)
    offsets1 = [x for x in itertools.product([-1,1,0], repeat=2) if x != (0,0)]
    offsets2 = [x for x in offsets1 if abs(x[0]-x[1]) == 1]

    offsets = []
    offsets.append(img)
    for x_offset, y_offset in offsets1:
        offsets.append(ImageChops.offset(img, x_offset, y_offset))
    composite = functools.reduce(lambda x,y: ImageChops.darker(x, y), offsets)
    perimeter = ImageChops.subtract(img,composite)
    perimeter = ImageChops.invert(perimeter)

    offsets = []
    for x_offset, y_offset in offsets2:
        offsets.append(ImageChops.offset(perimeter, x_offset, y_offset))
    composite = functools.reduce(lambda x,y: ImageChops.darker(x, y), offsets)
    composite = ImageChops.invert(composite)
    perimeter = ImageStat.Stat(composite).sum[0]/(255*3)

    # Calculate ink area
    img = ImageChops.invert(img)
    inkArea = ImageStat.Stat(img).sum[0]/255
    PC = perimeter**2/(inkArea*4*math.pi)

    return(PC,inkArea,perimeter)

print(perimetricComplexity('c2.png'))
