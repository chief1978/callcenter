from tensorflow.keras.datasets import fashion_mnist
from tensorflow.keras.layers import Dense
from tensorflow.keras.models import Sequential
import numpy as np

def load_train(path):
    features_train = np.load(path + 'train_features.npy', allow_pickle=True)
    target_train = np.load(path + 'train_target.npy', allow_pickle=True)
    features_train = features_train.reshape(features_train.shape[0], 28 * 28) / 255.
    return features_train, target_train

def load_test(path):
    features_train = np.load(path + 'test_features.npy', allow_pickle=True)
    target_train = np.load(path + 'test_target.npy', allow_pickle=True)
    features_train = features_train.reshape(features_train.shape[0], 28 * 28) / 255.
    return (features_train, target_train)

def create_model(input_shape):
    model = Sequential()
    model.add(Dense(10, input_dim=input_shape, activation='relu'))
    model.add(Dense(8, activation='relu'))
    model.add(Dense(4, activation='relu'))
    model.add(Dense(8, activation='relu'))
    model.add(Dense(10, activation='softmax'))
    
    model.compile(optimizer='sgd', loss='sparse_categorical_crossentropy',
                  metrics=['acc'])

    return model 

def train_model(model, train_data, test_data, batch_size=32, epochs=20,
                steps_per_epoch=None, validation_steps=None):

    features_train, target_train = train_data
    features_test, target_test = test_data
    model.fit(features_train, target_train, 
              validation_data=(features_test, target_test),
              batch_size=batch_size, epochs=epochs,
              steps_per_epoch=steps_per_epoch,
              validation_steps=validation_steps,
              verbose=2, shuffle=True)

    return model 

if __name__ == "__main__":
    path = '/datasets/fashion_mnist/'
    features_train, target_train = load_train(path)
    features_test, target_test = load_train(path)
    
    model = create_model(features_train.shape[1])
    
    train_model(model,(features_train, target_train),(features_test, target_test))
    loss, acc = model.evaluate(features_test, target_test)
    print("Model accuracy: {:5.2f}%".format(100 * acc))