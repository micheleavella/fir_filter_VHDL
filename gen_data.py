import numpy as np
x=50+20*np.sin(np.linspace(0,20,100)+0.3*(np.random.randint(-1,1,100)))
np.savetxt('DATA/in_data.txt',x)