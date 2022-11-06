import csv
import pandas as pd
import json

def read_csv_toDic(csv):

    # df = pd.read_csv('kangxi-strokecount.csv', encoding='utf8')
    data=pd.read_csv(csv, sep='\t', encoding='utf8')
    # print(data.iloc[[4]])
    data = data.values.tolist()

    # this is the dict with words and number
    dicWord = {}

    for val in data:
        splited = val[0].split(',')
        if len(splited) == 4:
            word, num = splited[-2:]
            dicWord[word] = num
    return dicWord

def read_txt(txt):
    with open(txt) as f:
        lines = f.readlines()
        x = lines[0].replace('\n','').split(' ')
        return x

def find_word_stroke(words, dicWords):
    dic = {}
    # print(dicWords.keys())
    for word in words:
        if word in dicWords.keys():
            dic[word] = int(dicWords[word])
    return dic

def write_json(dic, num):

    with open('words_stroks'+ str(num) +'.json', 'w', encoding="utf-8") as f:
        f.write(json.dumps(dic, ensure_ascii=False))

dicWords = read_csv_toDic("kangxi-strokecount.csv")
words5 = read_txt('Chi_5.txt')
words7 = read_txt('Chi_7.txt')
words8 = read_txt('Chi_8.txt')
words_stroks5 = find_word_stroke(words5,dicWords)
words_stroks7 = find_word_stroke(words7,dicWords)
words_stroks8 = find_word_stroke(words8,dicWords)
write_json(words_stroks5,5)
write_json(words_stroks7,7)
write_json(words_stroks8,8)
