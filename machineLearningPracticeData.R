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
