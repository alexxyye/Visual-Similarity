from PIL import Image
import cv2
import pytesseract
from os import listdir
from os.path import isfile, join
import random


def read_dic(mypath:str)-> list:
    onlyfiles = [mypath + '/'+f for f in listdir(mypath) if isfile(join(mypath, f)) and f != ".DS_Store"]
    return onlyfiles


loc = 'Data/8_Maurer_inprep_repsup'

imgs = read_dic(loc)


flag = 0
for img in imgs:
    try:
        img_cv = Image.open(img)
        width, height = img_cv.size
        # By default OpenCV stores images in BGR format and since pytesseract assumes RGB format,
        left = width /2 - 100
        right = width /2 + 100

        top = height / 2 - 100
        bottom = height / 2 + 100


        # Cropped image of above dimension
        # (It will not change original image)
        im1 = img_cv.crop((left, top, right, bottom))
        im1.save('out/'+img.split('/')[-1])

    except:
        print(img)
        pass


    # # OR
    # img_rgb = Image.frombytes('RGB', img_cv.shape[:2], img_cv, 'raw', 'BGR', 0, 0)
    # print(pytesseract.image_to_string(img_rgb, lang = 'chi_sim', config = '--psm 9'))
