from sklearn.svm import SVR
from sklearn.model_selection import cross_val_predict
import scipy.io as sio

fname2 = 'svr_feature2.mat'
fname3 = 'svr_y.mat'
data2 = sio.loadmat(fname2)
data3 = sio.loadmat(fname3)

x2 = data2['svr_feature2']
y = data3['svr_y']

svr_rbf = SVR(kernel='rbf', C=1)
svr_rbf.fit(x2, y)
y_pred = cross_val_predict(svr_rbf, x2, y, cv=153)
sio.savemat('y_pred.mat', {'y_pred': y_pred})

svr_rbf = SVR(kernel='rbf', C=1)
svr_rbf.fit(x2[..., 0:30], y)
y_pred_logo = cross_val_predict(svr_rbf, x2[..., 0:30], y, cv=153)
sio.savemat('y_pred_logo.mat', {'y_pred_logo': y_pred_logo})

svr_rbf = SVR(kernel='rbf', C=1)
svr_rbf.fit(x2[..., 30:60], y)
y_pred_pho = cross_val_predict(svr_rbf, x2[..., 30:60], y, cv=153)
sio.savemat('y_pred_pho.mat', {'y_pred_pho': y_pred_pho})

svr_rbf = SVR(kernel='rbf', C=1)
svr_rbf.fit(x2[..., 60:90], y)
y_pred_sem = cross_val_predict(svr_rbf, x2[..., 60:90], y, cv=153)
sio.savemat('y_pred_sem.mat', {'y_pred_sem': y_pred_sem})