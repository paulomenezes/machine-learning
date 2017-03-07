import pylab
import os
import numpy as np
import pandas as pd
from scipy.misc import imread
from scipy.misc import imresize
from sklearn.metrics import accuracy_score

import tensorflow as tf
import keras

seed = 128
rng = np.random.RandomState(seed)

root_dir = os.path.abspath('./')
data_dir = os.path.join(root_dir, 'data')
sub_dir = os.path.join(root_dir, 'sub')

# check for existence
os.path.exists(root_dir)
os.path.exists(data_dir)
os.path.exists(sub_dir)

# reasd csv
train = pd.read_csv(os.path.join(data_dir, 'Train', 'train_node.csv'))
test = pd.read_csv(os.path.join(data_dir, 'test_node.csv'))

# read output csv
sample_submission = pd.read_csv(os.path.join(data_dir, 'Sample_Submission.csv'))

train.head()

# read train images
temp = []
i = 0
print('Start train')
for img_name in train.filename:
  image_path = os.path.join(data_dir, 'Train', 'Images', 'train', img_name)
  img = imread(image_path, flatten=True)
  img = img.astype('float32')
  temp.append(img)

  i += 1
    
print('Train images ' + str(i))

# store all images as numpy array
train_x = np.stack(temp)
# transform images to 0-1
train_x /= 255.0
train_x = train_x.reshape(-1, 22500).astype('float32')

# read test images
temp = []
i = 0
print('Start test')
for img_name in test.filename:
  image_path = os.path.join(data_dir, 'Train', 'Images', 'test', img_name)
  img = imread(image_path, flatten=True)
  img = img.astype('float32')
  temp.append(img)

  i += 1
    
print('Test images ' + str(i))
    
# store all images as numpy array
test_x = np.stack(temp)
# transform images to 0-1
test_x /= 255.0
test_x = test_x.reshape(-1, 22500).astype('float32')

# converter a class vector of integers to binary class matrix
train_y = keras.utils.np_utils.to_categorical(train.label.values)

# divide 70:30
split_size = int(train_x.shape[0] * 0.7)

train_x, val_x = train_x[:split_size], train_x[split_size:]
train_y, val_y = train_y[:split_size], train_y[split_size:]
train.label.ix[split_size:]

# define vars
input_num_units = 22500
hidden_num_units = 50
output_num_units = 6

epochs = 5
batch_size = 128

# import keras modules
from keras.models import Sequential
from keras.layers import Dense

# create model
model = Sequential([
  Dense(output_dim=hidden_num_units, input_dim=input_num_units, activation='relu'),
  Dense(output_dim=output_num_units, input_dim=hidden_num_units, activation='softmax'),
])

# compile the model with necessary attributes
model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

# train our model
trained_model = model.fit(train_x, train_y, nb_epoch=epochs, batch_size=batch_size, validation_data=(val_x, val_y))

pred = model.predict_classes(test_x)

# output to view
'''
img_name = rng.choice(test.filename)
filepath = os.path.join(data_dir, 'Train', 'Images', 'test', img_name)

img = imread(filepath, flatten=True)

print(img_name.split('.')[0])
test_index = 39 # int(img_name.split('.')[0]) - train.shape[0]

print("\nPrediction is: " + str(pred[test_index]))

pylab.imshow(img, cmap='gray')
pylab.axis('off')
pylab.show()
'''
# output to csv
sample_submission.filename = test.filename
sample_submission.label = pred
sample_submission.to_csv(os.path.join(sub_dir, 'sub02.csv'), index=False)