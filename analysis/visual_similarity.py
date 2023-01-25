import pandas as pd
from scipy.stats import ttest_ind

df = pd.read_csv('/Users/alex/Documents/GitHub/Visual-Similarity/analysis/mean_df_res.csv')

print(df)


# #define samples
# group1 = df[df['method']=='A']
# group2 = df[df['method']=='B']
#
# #perform independent two sample t-test
# ttest_ind(group1['score'], group2['score'])
#
# Ttest_indResult(statistic=-2.6034304605397938, pvalue=0.017969284594810425)