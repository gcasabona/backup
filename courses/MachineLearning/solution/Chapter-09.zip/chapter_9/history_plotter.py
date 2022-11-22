# the import statement for matplotlib
import matplotlib.pyplot as plt

# cost function history plotter
def plot_cost_histories(cost_histories,labels):
    # create figure
    plt.figure(figsize=(9,3))
    
    # loop over cost histories and plot each one
    for j in range(len(cost_histories)):
        history = cost_histories[j]
        label = labels[j]
        plt.plot(history,label = label)
    plt.legend(loc='upper right')
    plt.title('cost function history comparison')
    plt.xlabel('iteration')
    plt.ylabel('cost function value',rotation = 90)
    plt.show()