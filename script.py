from tqdm import tqdm
import numpy as np
from time import sleep
import serial
ser = serial.Serial('/dev/ttyUSB15', baudrate=115200)

data=np.loadtxt('DATA/in_data.txt').astype(int)
out_data =[] 

for i in tqdm(data):
    #print(i)    
    ser.write(chr(i))

    sleep(0.01)
        
    d = ser.read()
    out_data.append(ord(d))


np.savetxt('DATA/out_data.txt',np.array(out_data))
ser.close()
