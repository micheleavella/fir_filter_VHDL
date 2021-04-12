import numpy as np
import matplotlib.pyplot as plt
np.random.seed(1234)
#x=70*(np.sin(np.linspace(0,20,100)+0.3*(np.random.randint(-1,1,100))))
#np.savetxt('DATA/in_data.txt',x)
def f(x):
    if x >= 0 : return 1;
    else:       return -1;
f=np.vectorize(f)
x=np.sin(np.linspace(0,20,100))
x=50*f(x)
#plt.plot(np.linspace(0,20,100),x)
#plt.show()

np.savetxt('DATA/in_quadra.txt',x)
