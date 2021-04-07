import numpy as np
import matplotlib.pyplot as plt

x=np.loadtxt('in_data.txt')
y=np.loadtxt('out_data.txt')
plt.plot(x)
plt.plot(y)

plt.savefig('plot.png')
