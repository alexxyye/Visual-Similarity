import cv2

image = cv2.imread('c2.png')
invert = cv2.bitwise_not(image) # OR
cv2.imwrite('Bc2.png', invert)
