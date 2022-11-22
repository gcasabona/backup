import numpy as np
import matplotlib.pyplot as plt

r = np.linspace(1, 20, 1000)


V1 = 1./(2. * r)

V2 = 3./(2. * r)

V3 = 5./(2. * r)



plt.plot(r, V1, '-', label = "Uncertainty Principle & Coherent State & n = 0")

plt.plot(r, V2, '--', label = "n = 1")

plt.plot(r, V3, ':', label = "n = 2")


plt.ylim(0.0, 1.55)
plt.xlabel('$\sigma_p$')
plt.ylabel('$\sigma_z$')
plt.legend()
plt.title('PS7 Problem 1.e.iii Uncertainties')
plt.savefig('ps7.png')

