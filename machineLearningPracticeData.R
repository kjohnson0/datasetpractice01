library(ggplot2)
library(dplyr)

## unsupervised learning: k-means clustering

# remove categoricals
iris_numerics = select(iris, -Species)
# notice how the variables are "uneven", some categories vary more than others
summary(iris_numerics)

# scales each number based on distance to the mean
iris_numerics = scale(iris_numerics)
summary(iris_numerics)

iris_clusters = kmeans(iris_numerics, centers = 3)
iris_clusters # our results

iris_clusters$cluster # vector designating a cluster for each row
iris$cluster = iris_clusters$cluster # add cluster column to original dataset
iris_numerics

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point(aes(color = as.factor(cluster)))

# species are actually MORE mixed than what the AI thought
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point(aes(color = Species))

## supervised learning
# visualizing data

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()
cor(iris$Sepal.Length, iris$Sepal.Width) # gives correlation
cor(iris$Petal.Length, iris$Sepal.Width)
cor(iris$Petal.Length, iris$Petal.Width) # heavily correlated, see graph
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) + 
  geom_point()

# choose features
# petal width, sepal length, sepal width

# split into training, test, and validation sets
greetings = c(rep("hello", 5),rep("goodbye", 3)) %>%
  sample(8, replace = TRUE)
greetings

irisLen = nrow(iris)

iris$label = c(rep("training", ceiling(.6*irisLen)),
               rep("test", ceiling(.2*irisLen)),
               rep("validation", ceiling(.2*irisLen))) %>%
  sample(irisLen, replace = FALSE)

head(iris)
iris

### choosing a model

irisTrain = filter(iris, label == "training")
irisTest = filter(iris, label == "test")
irisValid = filter(iris, label == "validation")

## linear model
# only uses numeric data, limited to linear relationships
# can have multiple x values (y=mx+b)



# creating the model
# to decide right order, look at the correlations (~ line 34)
# smallet p value first
#             y           =     m1  x1  +   m2  x2    +   b
irisLM = lm(Petal.Length ~ Petal.Width + Sepal.Length, data = irisTrain)
irisLM

# select out only the x values we use (petal width and sepal length)
irisLMPredictions = select(irisTest, Petal.Width, Sepal.Length) %>%
  predict(object = irisLM)
irisTestLM

# evaluate answers, add or change variables to get a more accurate picture
irisTrain$lmPred = irisLMPredictions
head(irisTrain)
