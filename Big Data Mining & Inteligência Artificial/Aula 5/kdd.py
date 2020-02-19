# -*- coding: utf-8 -*-
"""KDD.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1mpk_sj75RTQVGzHRlrjxGuGgeUBn7dU-
"""

from sklearn import datasets 
import pandas as pd 
import numpy as np 
import seaborn as sns

iris = datasets.load_iris()

df = pd.DataFrame(data = np.c_[iris['data'], iris['target']], columns = iris['feature_names'] + ['target'])

df.head()

df.target.replace(df['target'].unique(), iris['target_names'], inplace=True)

df.columns = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width', 'target']

df.head()

df['sepal_length'].plot(kind='hist', color='red')

y = df['sepal_length'].plot(kind='hist', color='red') 
y.set_title('Distribuição sepal_length')

df.plot.scatter(x='sepal_length', y='sepal_width')

x = sns.scatterplot(x='petal_length', y='petal_width', data=df, hue='target') 
x.set_title("Relação entre atributos") 
x.set_xlabel("Petal Length") 
x.set_ylabel("Petal Width")