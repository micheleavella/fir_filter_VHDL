import numpy as np
import plotly.graph_objects as go

x=np.loadtxt('DATA/in_data.txt')
y=np.loadtxt('DATA/out_data_fixed.txt')
n=np.arange(len(x))


fig = go.Figure()
fig.add_trace(go.Scatter(x=n, y=x,
                    mode='lines',
                    name='in signal'))

fig.add_trace(go.Scatter(x=n, y=y,
                    mode='lines',
                    name='out signal'))


fig.write_image("plot.jpeg")
fig.show()
