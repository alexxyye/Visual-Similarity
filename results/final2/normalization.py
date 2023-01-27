import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statistics



def mean_df(df):
    out = df.mean().to_frame().transpose()
    return out


def read_split_csv(filename: str, loc1: int):
    df = pd.read_csv(filename + '.csv')
    df_1 = df.iloc[:loc1, :]
    df_2 = df.iloc[loc1:, :]
    out1 = df_1.iloc[:, [1, 2, 3, 4, 6]]
    out2 = df_2.iloc[:, [1, 2, 3, 4, 6]]
    return out1, out2


def normalization(df):
    print(df.max()-df.min())
    normalized_df = (df - df.min()) / (df.max()-df.min())
    return normalized_df


def concatenate6(df1, df2, df3, df4, df5, df6):
    out = pd.DataFrame(np.concatenate([df1.values, df2.values, df3.values, df4.values,
                                       df5.values, df6.values], axis=0),
                       columns=symbol1.columns, index=['symbol', 'german', 'english', 'falsefont', 'chinese', 'korean'])
    return out


def concatenate14_experiment(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, df11, df12, df13, df14):
    out = pd.DataFrame(np.concatenate([df1.values, df2.values, df3.values, df4.values,
                                       df5.values, df6.values, df7.values, df8.values,
                                       df9.values, df10.values, df11.values, df12.values,
                                       df13.values, df14.values], axis=0),
                       columns=symbol1.columns,
                       index=['symbol1', 'symbol2', 'symbol3', 'german1', 'german4', 'english2', 'english3',
                              'falsefont4', 'chinese5', 'chinese7', 'chinese8', 'korean5', 'korean7', 'korean8'])
    return out


def concatenate3(df1, df2, df3):
    out = pd.DataFrame(np.concatenate([df1.values, df2.values, df3.values], axis=0),
                       columns=symbol1.columns)
    return out


def concatenate12(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, df11, df12, df13, df14):
    out = pd.DataFrame(np.concatenate([df1.values, df2.values, df3.values, df4.values,
                                       df5.values, df6.values, df7.values, df8.values,
                                       df9.values, df10.values, df11.values, df12.values,
                                       df13.values, df14.values], axis=0),
                       columns=symbol1.columns)
    norm_df = normalization(out)
    print(out.shape)
    symbol, german, english, falsefont, chinese, korean = norm_df.iloc[:180], norm_df.iloc[180:324], \
        norm_df.iloc[324:444], norm_df.iloc[444:528], \
        norm_df.iloc[528:748], norm_df.iloc[748:968]

    return symbol, german, english, falsefont, chinese, korean


def concatenate12_experiment(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, df11, df12, df13, df14):
    out = pd.DataFrame(np.concatenate([df1.values, df2.values, df3.values, df4.values,
                                       df5.values, df6.values, df7.values, df8.values,
                                       df9.values, df10.values, df11.values, df12.values,
                                       df13.values, df14.values], axis=0),
                       columns=df1.columns)
    norm_df = normalization(out)
    print(out.shape)
    symbol1, symbol2, symbol3 = norm_df.iloc[:60], norm_df.iloc[60:120], norm_df.iloc[120:180]
    german1, german4 = norm_df.iloc[180:240], norm_df.iloc[240:324]
    english2, english3 = norm_df.iloc[324:384], norm_df.iloc[384:444]
    falsefont4 = norm_df.iloc[444:528]
    chinese5, chinese7, chinese8 = norm_df.iloc[528:588], norm_df.iloc[588:628], norm_df.iloc[628:748]
    korean5, korean7, korean8 = norm_df.iloc[748:808], norm_df.iloc[808:848], norm_df.iloc[848:968]

    return symbol1, symbol2, symbol3, german1, german4, english2, english3, falsefont4, chinese5, chinese7, chinese8, korean5, korean7, korean8


def lineplot(means):
    means['obj_num'].plot(kind='line', label='obj_num')
    means['disconnected_stroke'].plot(kind='line', label='disconnected_stroke')
    means['stroke_sum'].plot(kind='line', label='stroke_sum')
    means['junc_sum'].plot(kind='line', label='junc_sum')
    means['PC'].plot(kind='line', label='PC')
    plt.legend()
    plt.show()


symbol1, german1 = read_split_csv('1', 60)
symbol2, english2 = read_split_csv('2', 60)
symbol3, english3 = read_split_csv('3', 60)
falsefont4, german4 = read_split_csv('4', 84)
chinese5, korean5 = read_split_csv('5', 60)
chinese7, korean7 = read_split_csv('7', 40)
korean8, chinese8 = read_split_csv('8', 120)
"""
symbol, german, english, falsefont, chinese, korean = concatenate12(symbol1, symbol2, symbol3, german1,
                        german4, english2, english3, falsefont4,
                        chinese5, chinese7, chinese8, korean5, korean7, korean8)

symbolm,germanm,englishm,falsefontm,chinesem,koreanm =mean_df(symbol),mean_df(german),mean_df(english),\
    mean_df(falsefont),mean_df(chinese),mean_df(korean)

means = concatenate6(symbolm,germanm,englishm,falsefontm,chinesem,koreanm )
print(means)

means['sum_of_square'] = means['obj_num']**2+means['disconnected_stroke']**2+means['stroke_sum']**2+means['junc_sum']**2+means['PC']**2
print(means)
"""


def mean_def(outlist: list):
    ms = []
    for frame in outlist:
        m = mean_df(frame)
        ms.append(m)
    means = concatenate14_experiment(ms[0], ms[1], ms[2], ms[3], ms[4], ms[5], ms[6], ms[7], ms[8], ms[9], ms[10],
                                     ms[11], ms[12], ms[13])
    # means['sum_of_square'] = means['obj_num'] ** 2 + means['disconnected_stroke'] ** 2 + means['stroke_sum'] ** 2 + \
    #                          means['junc_sum'] ** 2 + means['PC'] ** 2
    means['sum_of_square'] = (means['obj_num'] + means['disconnected_stroke']  + means['stroke_sum']  + \
                             means['junc_sum']  + means['PC'])/5

    return means


out_list = concatenate12_experiment(symbol1, symbol2, symbol3, german1,
                                    german4, english2, english3, falsefont4,
                                    chinese5, chinese7, chinese8, korean5, korean7, korean8)
print(len(out_list))

mean_df_res = mean_def(out_list)
mean_df_res.to_csv('mean_df_res.csv')


# mean_df_res.DataFrame.hist(column='sum_of_square')
# l_mean = mean_df_res['sum_of_square'].tolist()


modifying_lmean = pd.read_excel('modified_mean.xlsx')
print(modifying_lmean['sum_of_square'])
# modifying_lmean.plot.bar(x="name", y="sum_of_square", rot=70, title="Number of tourist visits - Year 2018");
# plt.show(block=True)
l_values = modifying_lmean['sum_of_square'].tolist()

l_set = []
set_ = []
for item in range(len(l_values)):
    ind = item % 2
    set_.append(l_values[item])
    if ind == 1:
        l_set.append(set_)
        set_ = []

means = []
stds = []
for item in l_set:
    mean = statistics.mean(item)
    std = statistics.stdev(item)
    means.append(mean)
    stds.append(std)

x = modifying_lmean['name']
y = means
plt.errorbar(range(len(y)),y,yerr=stds,fmt='o',ecolor='r',color='b',elinewidth=2,capsize=4)
plt.show()
