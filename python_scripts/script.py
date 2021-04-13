from tqdm import tqdm
import numpy as np
from time import sleep
import serial

'''
Positive numbers go from 0 to 128
Negative numbers go from -1 to - 127  that is (255 to 129)

'''

def conv_1(n):
    if n<0:
        n = 256 + n
    return n 

def conv_2(n):
    if n>128:
        n = -256 + n
    return n 
    
conv_1 = np.vectorize(conv_1)
conv_2 = np.vectorize(conv_2)

ser = serial.Serial('/dev/ttyUSB15', baudrate=115200)

data=np.loadtxt('DATA/in_quadra.txt').astype(int)
data=conv_1(data)
out_data =[] 

for i in tqdm(data):
    #print(i)    
    ser.write(chr(i))

    sleep(0.01)
        
    d = ser.read()
    out_data.append(ord(d))

out_data=conv_2(np.array(out_data))
np.savetxt('DATA/out_quadra.txt',out_data)
ser.close()
