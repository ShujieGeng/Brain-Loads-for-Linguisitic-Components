import numpy as np
import matplotlib.pyplot as plt

from sklearn.svm import SVR
from sklearn.model_selection import cross_val_predict
import scipy.io as sio

data2 = sio.loadmat('svr_y.mat')
data3 = sio.loadmat('svr_feature2.mat')
x2 = data3['svr_feature2']
y = data2['svr_y']

svr_rbf = SVR(kernel='rbf', C=1)
y_pred_fe = np.zeros([153, 90])

for feaEli in range(0, 90):
    x = np.delete(x2, feaEli, axis=1)
    jj = cross_val_predict(svr_rbf, x, y, cv=153)
    y_pred_fe[..., feaEli] = jj

sio.savemat('y_pred_fe.mat', {'y_pred_fe': y_pred_fe})
data = sio.loadmat('y_pred.mat')
data1 = sio.loadmat('y_pred_fe.mat')

ypred_rbf = data['y_pred']
ypred_fe_rbf = data1['y_pred_fe']
y = data2['svr_y']


def rmse_ab(ka, kb):
    sum_k = 0
    for i in range(0, len(kb)):
        diff = ka[i] - kb[i]
        sum_k += diff ** 2
    rmse_ab = (sum_k / len(ka)) ** 0.5
    return rmse_ab


rmse_all_rbf = rmse_ab(ypred_rbf.transpose(), y)
rmse_Nminus1_rbf = rmse_ab(ypred_fe_rbf, y)
sio.savemat('rmse_all_rbf.mat', {'rmse_all_rbf': rmse_all_rbf})
sio.savemat('rmse_Nminus1_rbf.mat', {'rmse_Nminus1_rbf': rmse_Nminus1_rbf})

feaVal_rbf = sum(rmse_Nminus1_rbf > rmse_all_rbf)
feaInd_rbf = np.argsort(-rmse_Nminus1_rbf)

x2 = data3['svr_feature2']
svr_rbf = SVR(kernel='rbf', C=1)
bestK_rbf = np.zeros(90)

for ii in range(1, 90):
    x = x2[..., feaInd_rbf[0:ii]]
    jj = cross_val_predict(svr_rbf, x, y, cv=153)
    bestK_rbf[ii - 1] = rmse_ab(jj, y)
sio.savemat('bestK_rbf.mat', {'bestK_rbf': bestK_rbf})
