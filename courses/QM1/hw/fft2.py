from scipy.fftpack import fft
import numpy as np
import matplotlib.pyplot as plt

N = 200.

T = 1.0 / 800.0

x = np.linspace(0.0, N*T, N)

a = (np.sqrt(3.)*(np.cos(np.pi*x/6.) - np.cos(np.pi*x/3.)))/x

b = (np.pi - (np.sin(np.pi*x))/x )*0.5

y = (a/b)*np.sqrt(2./np.pi)*np.sin(x)

plt.plot(x, y) 
plt.savefig('fft2')
