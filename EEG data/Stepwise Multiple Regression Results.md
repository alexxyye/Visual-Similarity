Stepwise Multiple Regression Results

## PC

Mixed-Effects Model (k = 7; tau^2 estimator: REML)

tau^2 (estimated amount of residual heterogeneity):     0.9601 (SE = 0.9508)
tau (square root of estimated tau^2 value):             0.9799
I^2 (residual heterogeneity / unaccounted variability): 64.16%
H^2 (unaccounted variability / sampling variability):   2.79
R^2 (amount of heterogeneity accounted for):            0.00%

Test for Residual Heterogeneity:
QE(df = 5) = 13.9528, p-val = 0.0159

Test of Moderators (coefficient 2):
QM(df = 1) = 0.1247, p-val = 0.7240

Model Results:

         estimate      se    zval    pval     ci.lb    ci.ub    
intrcpt    0.1680  0.4647  0.3615  0.7177   -0.7428   1.0787    
PC         2.6583  7.5293  0.3531  0.7240  -12.0987  17.4154    

---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## PC + Obj_Num

Mixed-Effects Model (k = 7; tau^2 estimator: REML)

tau^2 (estimated amount of residual heterogeneity):     0.4504 (SE = 0.7033)
tau (square root of estimated tau^2 value):             0.6711
I^2 (residual heterogeneity / unaccounted variability): 45.38%
H^2 (unaccounted variability / sampling variability):   1.83
R^2 (amount of heterogeneity accounted for):            37.65%

Test for Residual Heterogeneity:
QE(df = 4) = 7.3135, p-val = 0.1202

Test of Moderators (coefficients 2:3):
QM(df = 2) = 3.6266, p-val = 0.1631

Model Results:

         estimate      se     zval    pval     ci.lb    ci.ub    
intrcpt   -0.1868  0.4216  -0.4431  0.6577   -1.0132   0.6395    
PC        -9.2747  8.7208  -1.0635  0.2875  -26.3672   7.8178    
obj_num    8.7323  4.6804   1.8657  0.0621   -0.4411  17.9058  . 

---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## PC + Obj_Num + Disc_Strk

Mixed-Effects Model (k = 7; tau^2 estimator: REML)

tau^2 (estimated amount of residual heterogeneity):     0 (SE = 0.4359)
tau (square root of estimated tau^2 value):             0
I^2 (residual heterogeneity / unaccounted variability): 0.00%
H^2 (unaccounted variability / sampling variability):   1.00
R^2 (amount of heterogeneity accounted for):            100.00%

Test for Residual Heterogeneity:
QE(df = 3) = 0.9513, p-val = 0.8130

Test of Moderators (coefficients 2:4):
QM(df = 3) = 13.1113, p-val = 0.0044

Model Results:

           estimate       se     zval    pval     ci.lb     ci.ub      
intrcpt      0.2568   0.3565   0.7202  0.4714   -0.4420    0.9555      
PC         -30.8616  10.5037  -2.9382  0.0033  -51.4485  -10.2747   ** 
obj_num     20.0045   5.6010   3.5716  0.0004    9.0267   30.9823  *** 
disc_strk  -10.1781   4.0352  -2.5223  0.0117  -18.0870   -2.2693    * 

---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## PC + Obj_Num + Disc_Strk + Strk_Sum

Mixed-Effects Model (k = 7; tau^2 estimator: REML)

tau^2 (estimated amount of residual heterogeneity):     0 (SE = 0.5282)
tau (square root of estimated tau^2 value):             0
I^2 (residual heterogeneity / unaccounted variability): 0.00%
H^2 (unaccounted variability / sampling variability):   1.00
R^2 (amount of heterogeneity accounted for):            100.00%

Test for Residual Heterogeneity:
QE(df = 2) = 0.9499, p-val = 0.6219

Test of Moderators (coefficients 2:5):
QM(df = 4) = 13.1128, p-val = 0.0107

Model Results:

           estimate       se     zval    pval     ci.lb    ci.ub      
intrcpt      0.2622   0.3836   0.6835  0.4943   -0.4896   1.0139      
PC         -30.6845  11.4816  -2.6725  0.0075  -53.1880  -8.1810   ** 
obj_num     20.0073   5.6015   3.5718  0.0004    9.0286  30.9861  *** 
disc_strk  -10.1129   4.3818  -2.3079  0.0210  -18.7010  -1.5247    * 
strk_sum    -0.2076   5.4338  -0.0382  0.9695  -10.8577  10.4425      

---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## PC + Obj_Num + Disc_Strk + Strk_Sum + Junction

Mixed-Effects Model (k = 7; tau^2 estimator: REML)

tau^2 (estimated amount of residual heterogeneity):     0 (SE = 0.8034)
tau (square root of estimated tau^2 value):             0
I^2 (residual heterogeneity / unaccounted variability): 0.00%
H^2 (unaccounted variability / sampling variability):   1.00
R^2 (amount of heterogeneity accounted for):            100.00%

Test for Residual Heterogeneity:
QE(df = 1) = 0.3092, p-val = 0.5782

Test of Moderators (coefficients 2:6):
QM(df = 5) = 13.7535, p-val = 0.0173

Model Results:

           estimate       se     zval    pval     ci.lb    ci.ub      
intrcpt      0.0227   0.4864   0.0467  0.9628   -0.9307   0.9761      
PC         -42.0121  18.2237  -2.3054  0.0211  -77.7299  -6.2944    * 
obj_num     21.1050   5.7669   3.6597  0.0003    9.8021  32.4080  *** 
disc_strk   -8.0435   5.0877  -1.5810  0.1139  -18.0151   1.9282      
strk_sum    -0.3908   5.4386  -0.0719  0.9427  -11.0504  10.2687      
junc_sum    -8.9467  11.1773  -0.8004  0.4235  -30.8537  12.9604      

---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## Writing Syetem

Mixed-Effects Model (k = 7; tau^2 estimator: REML)

tau^2 (estimated amount of residual heterogeneity):     0 (SE = 0.3346)
tau (square root of estimated tau^2 value):             0
I^2 (residual heterogeneity / unaccounted variability): 0.00%
H^2 (unaccounted variability / sampling variability):   1.00
R^2 (amount of heterogeneity accounted for):            100.00%

Test for Residual Heterogeneity:
QE(df = 5) = 3.9813, p-val = 0.5521

Test of Moderators (coefficient 2):
QM(df = 1) = 10.0814, p-val = 0.0015

Model Results:

                estimate      se     zval    pval    ci.lb   ci.ub     
intrcpt          -0.5935  0.3632  -1.6339  0.1023  -1.3053  0.1184     
writing.system    1.7617  0.5548   3.1751  0.0015   0.6742  2.8492  ** 

---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## wd_sym_early_mod
Number of studies combined: k = 7
Number of observations: o = 274

                          MD             95%-CI     z p-value
Common effect model  -1.0816 [-1.7075; -0.4556] -3.39  0.0007
Random effects model -1.0816 [-1.7075; -0.4556] -3.39  0.0007

Quantifying heterogeneity:
 tau^2 = 0 [0.0000; 0.9700]; tau = 0 [0.0000; 0.9849]
 I^2 = 0.0% [0.0%; 70.8%]; H = 1.00 [1.00; 1.85]

Test of heterogeneity:
    Q d.f. p-value
 3.17    6  0.7871

Details on meta-analytical method:
- Inverse variance method
- Restricted maximum-likelihood estimator for tau^2
- Q-Profile method for confidence interval of tau^2 and tau

## wd_sym_late_mod
Number of studies combined: k = 7
Number of observations: o = 274

                          MD             95%-CI     z p-value
Common effect model  -0.8686 [-1.4404; -0.2967] -2.98  0.0029
Random effects model -0.8259 [-2.0142;  0.3625] -1.36  0.1732

Quantifying heterogeneity:
 tau^2 = 1.9147 [0.4086; 12.3044]; tau = 1.3837 [0.6392; 3.5078]
 I^2 = 74.2% [44.9%; 87.9%]; H = 1.97 [1.35; 2.87]

Test of heterogeneity:
     Q d.f. p-value
 23.24    6  0.0007

Details on meta-analytical method:
- Inverse variance method
- Restricted maximum-likelihood estimator for tau^2
- Q-Profile method for confidence interval of tau^2 and tau

### wd_sym_late_mod moderator analysis
Mixed-Effects Model (k = 7; tauA2 estimator: REML)

tau^2 (estimated amount of residual heterogeneity):     0.0839 (SE = 0.7126)
tau (square root of estimated tauA2 value):             0.2897
I^2 (residual heterogeneity / unaccounted variability): 9.60%
H^2 (unaccounted variability / sampling variability):   1.11
R^2 (amount of heterogeneity accounted for):            95.34%

Test for Residual Heterogeneity: 
QE(df = 3) = 3.3508, p-val = 0.3406 

Test of Moderators (coefficients 2:4): 
QM(df = 3) = 14.4344, p-val = 0.0024 

Model Results: 

            estimate    se      zval    pval    ci.lb       ci.ub 
intrcpt     -0.4947     0.5010  -0.9875 0.3234  -1.4766     0.4872 
PC          -42.3097    14.9328 -2.8333 0.0046  -71.5773    -13.0420    ** 
obj_num     27.4348     7.6107  3.6048  0.0003  12.5181     42.3515     *** 
disc_strk   -15.3988    5.7660  -2.6706 0.0076  -26.6999    -4.0978     ** 

---
Signif. codes: 0 `***' 0.001 "4" 0.01 `4" 0.05 " 0.1 " 1 
