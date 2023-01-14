import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA
from numpy import corrcoef


def read_split_csv(filename: str, loc1: int):
    df = pd.read_csv(filename + '.csv')
    df_1 = df.iloc[:loc1, :]
    df_2 = df.iloc[loc1:, :]
    out1 = df_1.iloc[:, [2, 3, 4, 6]]
    out2 = df_2.iloc[:, [2, 3, 4, 6]]
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


def plot_3D(chinese, german, english, korean):
    ax = plt.axes(projection="3d")

    colors = ['blue', 'green', 'yellow', 'purple']
    pds = [chinese, german, english, korean]
    names = ['chinese', 'german', 'english', 'korean']
    zip_color_pd = list(zip(colors, pds, names))

    for ziped in zip_color_pd:
        frame = ziped[1]
        c = ziped[0]
        lab = ziped[2]

        pca = PCA(n_components=3)
        pca.fit_transform(frame.transpose())
        comp = pca.components_
        print(comp)

        # plt.scatter(comp[0], comp[1], alpha=0.5, color=c, label=lab)
        ax.scatter3D(comp[0], comp[1], comp[2], color=c, label=lab, alpha=0.5)
        plt.legend()

    plt.show()


plot_3D(chinese, german, english, korean)