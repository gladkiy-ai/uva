import numpy as np
print('numpy')
import pandas as pd
print('pandas')
import seaborn as sns
print('seaborn')
import matplotlib.pyplot as plt
print('matplotlib')
#%matplotlib.inline
#print('inline')
data = pd.read_csv('weights_heights.csv', index_col='Index')
print('read_csv')
data.plot(y='Height', kind='hist', color='red',  title='Height (inch.) distribution')
print('plot')
