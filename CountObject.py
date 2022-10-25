from PIL import Image
from numpy import asarray
import matplotlib.pyplot as plt


import cv2
# load the image
example = '/Users/huangkexin/Desktop/MatlabPractice/Visual-Similarity/Data/7_Maurer_inprep_followup/c1.png'
image = Image.open(example)
# convert image to numpy array
data = asarray(image)

data = cv2.cvtColor(data, cv2.COLOR_BGR2GRAY)

print(type(data))
# summarize shape
print(data.shape)

print(data[0][0])

plt.imshow(data, cmap='gray')
plt.show()
