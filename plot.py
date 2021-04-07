import numpy as np
import matplotlib.pyplot as plt

x=np.loadtxt('DATA/in_data.txt')
y=np.loadtxt('DATA/out_data.txt')
plt.plot(x)
plt.plot(y)
plt.show()
#plt.savefig('plot.png')
