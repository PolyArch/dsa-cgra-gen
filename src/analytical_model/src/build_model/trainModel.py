from __future__ import absolute_import, division, print_function

import pathlib

import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers


def plot_history(history):
    hist = pd.DataFrame(history.history)
    hist['epoch'] = history.epoch

    plt.figure()
    plt.xlabel('Epoch')
    plt.ylabel('Mean Abs Error [MPG]')
    plt.plot(hist['epoch'], hist['mean_absolute_error'],
             label='Train Error')
    plt.plot(hist['epoch'], hist['val_mean_absolute_error'],
             label='Val Error')
    plt.ylim([0, 7000])
    plt.legend()

    plt.figure()
    plt.xlabel('Epoch')
    plt.ylabel('Mean Square Error [$MPG^2$]')
    plt.plot(hist['epoch'], hist['mean_squared_error'],
             label='Train Error')
    plt.plot(hist['epoch'], hist['val_mean_squared_error'],
             label='Val Error')
    plt.ylim([0, 20000000])
    plt.legend()
    plt.show()


def trainRegression(target_design, dataset, feature_field, predict_field):

    # CLean Not Avaliable Data
    dataset = dataset.dropna()

    # Convert Categorical Variable to One-Hot Variable
    for k, v in feature_field.items():
        if v is 'Categorical':
            categorical_var = dataset.pop(k)
            cat_oneHot = pd.get_dummies(categorical_var, prefix=k)
            dataset = pd.concat([dataset, cat_oneHot], axis = 1)

    # Select TrainData Set and TestData
    train_dataset = dataset.sample(frac=0.8, random_state=0)
    test_dataset = dataset.drop(train_dataset.index)

    # Visualize
    """
    num_var = [k for k, v in feature_field.items() if v is not 'Categorical']
    sns.pairplot(train_dataset[num_var + predict_field], diag_kind="kde")
    plt.show()
    """

    # Statistic
    train_stats = train_dataset.describe()
    for pred in predict_field:
        train_stats.pop(pred)
    train_stats = train_stats.transpose()

    #Split Feature from Label
    train_labels = pd.concat([train_dataset.pop(pred) for pred in predict_field], 1)
    test_labels = pd.concat([test_dataset.pop(pred) for pred in predict_field], 1)

    # Data Normalize
    def norm(x):
        return (x - train_stats['mean']) / train_stats['std']
    normed_train_data = norm(train_dataset)
    normed_test_data = norm(test_dataset)

    # Build Model
    def build_model():
        model = keras.Sequential([
            layers.Dense(64, activation=tf.nn.relu, input_shape=[len(train_dataset.keys())]),
            layers.Dense(64, activation=tf.nn.relu),
            layers.Dense(1)
        ])
        optimizer = tf.keras.optimizers.RMSprop(0.001)
        model.compile(loss='mean_squared_error',
                      optimizer=optimizer,
                      metrics=['mean_absolute_error', 'mean_squared_error'])
        return model

    # Train the Model
    Models = {}
    early_stop = keras.callbacks.EarlyStopping(monitor='val_loss', patience=10)
    for pred in predict_field:
        TrainedResult = {}
        # Initialize Model
        model = build_model()
        class PrintDot(keras.callbacks.Callback):
            def on_epoch_end(self, epoch, logs):
                if epoch % 100 == 0: print('')
                print('.', end='')
        # Set Train Parameter
        EPOCHS = 1000
        # Train Model
        history = model.fit(normed_train_data, train_labels[pred],
                            epochs=EPOCHS, validation_split=0.2, verbose=0, callbacks=[early_stop, PrintDot()])
        # Visual History
        # plot_history(history)
        # Collect Trained Result
        loss, mae, mse = model.evaluate(normed_test_data, test_labels[pred], verbose=0)
        TrainedResult['loss'] = loss
        TrainedResult['mae'] = mae
        TrainedResult['mse'] = mse
        TrainedResult['model'] = model
        TrainedResult['history'] = history
        # Visual Predict
        test_prediction = model.predict(normed_test_data).flatten()
        plt.scatter(test_labels[pred], test_prediction)
        plt.xlabel('True Values ' + target_design + "-" + pred)
        plt.ylabel('Predictions ' + target_design + "-" +pred)
        plt.axis('equal')
        plt.axis('square')
        plt.xlim([0, plt.xlim()[1]])
        plt.ylim([0, plt.ylim()[1]])
        _ = plt.plot([-100, 100], [-100, 100])
        plt.show()
        # Collect All Results
        Models[pred] = TrainedResult
        print(target_design + "-" + pred  + " is Finished")
    return Models
