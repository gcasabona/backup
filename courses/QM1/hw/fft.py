import numpy as np
import matplotlib.pyplot as plt

N =20 # 256
t = np.arange(N)

m = 4 
nu = float(m)/N

a = np.sqrt(3)*(np.cos(np.pi*N/6) - np.cos(np.pi*N/3))/N

b = (np.pi - (np.sin(np.pi*N))/N )/2

f = (a/b)*np.sqrt(2/np.pi)*np.sin(nu*N)  #np.sqrt(2 / np.pi) * np.sin(2*np.pi*nu*t)
ft = np.fft.fft(f)
freq = np.fft.fftfreq(N)
plt.plot(freq, ft.real**2 + ft.imag**2)
plt.savefig('fft')
