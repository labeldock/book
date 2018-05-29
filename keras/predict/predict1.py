import keras
import numpy

x = numpy.array([0,1,2,3,4,5,6,7,8,9,10])
y = x * 2 + 1
# y = array([1, 3, 5, 7, 9])

# compile
model = keras.models.Sequential()
model.add(keras.layers.Dense(1, input_shape=(1,)))
model.compile('SGD','mse')

# learn
print('Learn:', x[:2], '=>' , y[:2])
model.fit(x[:2], y[:2], epochs=1000, verbose=0)

# predicts
predicts = model.predict(x[2:]);
predicts = predicts.flatten()

print('Predictions:', y[2:], '=>' , predicts)

print('\n')
print('exprcts:',y[2:])
print('predict:',predicts)