import hangul_jamo
import numpy as np
from itertools import groupby
import pandas as pd

# stroke info
choSeong = np.array(
		# [0x3131, 0x3132, 0x3134, 0x3137, 0x3138, 0x3139, 0x3141, 0x3142, 0x3143, 0x3145,
		# 0x3146, 0x3147, 0x3148, 0x3149, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e], 
        [["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ",
		"ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"], #choseong
        [2, 4, 2, 3, 6, 5, 4, 4, 8, 2,
		4, 1, 3, 6, 4, 4, 4, 4, 3], #stroke
		[1, 2, 1, 2, 4, 4, 4, 4, 8, 1,
		2, 0, 2, 4, 2, 2, 3, 4, 0] ]) #junctions

jungSeong = np.array(
		# [0x314f, 0x3150, 0x3151, 0x3152, 0x3153, 0x3154, 0x3155, 0x3156, 0x3157, 0x3158,
		# 0x3159, 0x315a, 0x315b, 0x315c, 0x315d, 0x315e, 0x315f, 0x3160, 0x3161, 0x3162,
		# 0x3163], 
        [["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ",
		"ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ",
		"ㅣ"], #jungseong
        [2, 3, 3, 4, 2, 3, 3, 4, 2, 4,
		5, 3, 3, 2, 4, 5, 3, 3, 1, 2,
		1], #strokes
		[1, 2, 2, 4, 1, 1, 2, 2, 1, 2,
		3, 1, 2, 1, 2, 2, 1, 2, 0, 0]]) #junctions

jongSeong = np.array(
		# [0x0000, 0x3131, 0x3132, 0x3133, 0x3134, 0x3135, 0x3136, 0x3137, 0x3139, 0x313a,
		# 0x313b, 0x313c, 0x313d, 0x313e, 0x313f, 0x3140, 0x3141, 0x3142, 0x3144, 0x3145,
		# 0x3146, 0x3147, 0x3148, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e],
        [["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ",
		"ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ",
		"ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"], #jongseong
        [0, 2, 4, 4, 2, 5, 5, 3, 5, 7,
		9, 9, 7, 9, 9, 8, 4, 4, 6, 2,
		4, 1, 3, 4, 3, 3, 4, 3], #strokes
		[0, 1, 2, 2, 1, 3, 1, 2, 4, 5,
		8, 8, 5, 7, 8, 4, 4, 4, 5, 1,
		2, 0, 2, 2, 2, 3, 4, 0]]) #junctions

smallAlphabet = np.array([["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
		"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "ä", "ü"], 
		[2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 3, 1, 3,
		2, 1, 2, 2, 2, 1, 2, 2, 2, 4, 2, 2, 3, 4, 4], #strokes
		[2, 2, 0, 2, 2, 1, 2, 1, 2, 2, 3, 2, 2,
		1, 0, 2, 2, 1, 0, 1, 1, 1, 2, 1, 1, 1, 2, 1]]) #junctions

bigAlphabet = np.array([["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
		"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"],
		[3, 3, 1, 2, 4, 3, 2, 3, 1, 1, 3, 1, 4,
		3, 1, 2, 2, 3, 1, 2, 1, 2, 4, 2, 3, 3], #strokes
		[3, 4, 0, 2, 3, 2, 2, 2, 2, 2, 3, 1, 3,
		2, 0, 2, 1, 3, 0, 1, 0, 1, 3, 1, 1, 2]]) #junctions
symbol = np.array([["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"], 
		[3, 4, 4, 4, 2, 4, 5, 5, 5, 1],
		[3, 4, 4, 4, 1, 4, 5, 5, 4, 0]])
falseFont = np.array([["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
		"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"],
		[4, 5, 2, 5, 3, 6, 3, 3, 3, 3, 3, 3, 2, 
		2, 3, 4, 4, 5, 3, 3, 2, 1, 3, 4, 4, 3, 2], 
		[4, 4, 1, 6, 3, 4, 2, 3, 2, 2, 2, 1, 1,
		1, 4, 4, 5, 2, 2, 1, 0, 2, 3, 3, 2, 1]])

# combine all sublists
# all = [choSeong, jungSeong, jongSeong, smallAlphabet, bigAlphabet]
# all = [symbol, falseFont]
str_list = []
num_list = []
num_list2 = []
for el in all :
    str_list += list(el[0])
    num_list += list(el[1])
    num_list2 += list(el[2])

# ## Korean
# # read text file
# text = open('/Users/alex/Documents/GitHub/Visual-Similarity/OCR_results/Kor_7.txt', 'r')
# # save original text as a string

# # decompose hangul
# subcharacter = hangul_jamo.decompose(text.read())
# # original text
# ori_text = hangul_jamo.compose(subcharacter)
# ori_text = ori_text.split()

## English/German
# read text file & get subcharactet(letters)
with open('/Users/alex/Documents/GitHub/Visual-Similarity/OCR_results/Ger_4.txt', 'r') as file:
    subcharacter = file.read().rstrip()
# turn into list of strings
ori_text = subcharacter.split()

# subcomponents -> strokes
stroke_list = []
for str_i in subcharacter:
    if str_i in str_list:
        index = str_list.index(str_i)
        stroke = num_list[index]
        stroke_list.append(stroke)
    else:
        stroke_list.append(str_i)

# subcomponents -> junctions
junc_list = []
for str_i in subcharacter:
    if str_i in str_list:
        index = str_list.index(str_i)
        junction = num_list2[index]
        junc_list.append(junction)
    else:
        junc_list.append(str_i)

# turn nparr stroke_list into int list
for i in range(len(stroke_list)):
    if stroke_list[i] == ' ':
        stroke_list[i] = '50'
    elif stroke_list[i] == '空':
        stroke_list[i] = '100'

int_stroke_list = [int(i) for i in stroke_list]
int_stroke_list.append(50) # add an 50 to the last character

# turn nparr junc_list into int list
for i in range(len(junc_list)):
    if junc_list[i] == ' ':
        junc_list[i] = '50'
    elif junc_list[i] == '空':
        junc_list[i] = '100'

int_junc_list = [int(i) for i in junc_list]
int_junc_list.append(50) # add an 50 to the last character

# object info summaries
object_info = [list(v) for k,v in groupby(int_stroke_list, key = lambda x: x != 50) if k != 50]
obj_sum = []
for obj in object_info:
    if obj != [50]:
        obj_sum.append(obj)
obj_num = []
for ii in obj_sum:
    obj_num.append(len(ii))

# get stroke sum of each character
stroke_sum = []
strokesum = 0
for i in range(len(int_stroke_list)):
    if int_stroke_list[i] != 50:
        strokesum += int_stroke_list[i]
    else:
        stroke_sum.append(strokesum)
        strokesum = 0

