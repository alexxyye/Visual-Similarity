import matplotlib.pyplot as plt
import cv2
import numpy as np
import pdb
img = cv2.imread('c2.png')
new = img.copy()

imagem = cv2.bitwise_not(img)
gray = cv2.cvtColor(imagem, cv2.COLOR_BGR2GRAY)

corners = cv2.goodFeaturesToTrack(gray, 4, 0.01, 10, blockSize = 5)
corners = np.int0(corners)
for i in corners:
    x, y = i.ravel()
    cv2.circle(imagem, (x,y),3,255,-1)
    print(x,y)
cv2.imwrite('hough_img.png',imagem)
print(corners)
print(len(corners))
