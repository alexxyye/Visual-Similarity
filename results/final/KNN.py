import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA


def read_split_csv(filename: str, loc1: int):
    df = pd.read_csv(filename + '.csv')
    df_1 = df.iloc[:loc1, :]
    df_2 = df.iloc[loc1:, :]
    out1 = df_1.iloc[:, [1, 2, 3, 4, 6]]
    out2 = df_2.iloc[:, [1, 2, 3, 4, 6]]
    return out1, out2


def concatenate3(df1, df2, df3):
    out = pd.DataFrame(np.concatenate([df1.values, df2.values, df3.values], axis=0),
                       columns=symbol1.columns)
    return out


def concatenate2(df1, df2):
    out = pd.DataFrame(np.concatenate([df1.values, df2.values], axis=0),
                       columns=symbol1.columns)
    return out


symbol1, german1 = read_split_csv('1', 60)
symbol2, english2 = read_split_csv('2', 60)
symbol3, english3 = read_split_csv('3', 60)
falsefont4, german4 = read_split_csv('4', 84)
chinese5, korean5 = read_split_csv('5', 60)
chinese7, korean7 = read_split_csv('7', 40)
korean8, chinese8 = read_split_csv('8', 120)

# symbol1, german1 = select_columns(read_split_csv('1', 60))
# symbol2, english2 = select_columns(read_split_csv('2', 60))
# symbol3, english3 = select_columns(read_split_csv('3', 60))
# falsefont4, german4 = select_columns(read_split_csv('4', 84))
# chinese5, korean5 = select_columns(read_split_csv('5', 60))
# chinese7, korean7 = select_columns(read_split_csv('7', 40))
# korean8, chinese8 = select_columns(read_split_csv('8', 120))
# symbol = pd.concat([symbol1, symbol2, symbol3], axis=1)
# chinese = pd.concat([chinese5, chinese7, chinese8], axis=1)
# korean = pd.concat([korean5, korean7, korean8], axis=1)

symbol = concatenate3(symbol1, symbol2, symbol3)
chinese = concatenate3(chinese5, chinese7, chinese8)
korean = concatenate3(korean5, korean7, korean8)
german = concatenate2(german1, german4)
english = concatenate2(english2, english3)
falsefont = falsefont4


print(chinese8.iloc[60:, :])
# fig = plt.figure()

# for frame in [symbol, chinese, german]:
#     # plt.scatter(frame['obj_num'], frame['PC'],alpha = 0.5)
#     pca = PCA(n_components=2)
#     pca.fit(frame)
#     print(pca.components_)
# plt.show()

# print(symbol.columns)
