library(ggplot2)

traindata = read.csv("train.csv")
testdata = read.csv("test.csv")
pokedata = read.csv("Pokemon.csv")

View(testdata)
View(traindata)
View(pokedata)

ggplot(data = pokedata, mapping = aes(x = Type.1, y = Speed)) +
  geom_violin() + 
  labs(x = "Primary Typing", title = "Pokemon Typing and Speed")

ggplot(data = pokedata, mapping = aes(x = Generation, y = Total)) + 
  geom_histogram(stat = "summary",
                 fun = "mean")

ggplot(data = pokedata, mapping = aes(x = Type.1, y = Type.2, color = Legendary)) + 
  geom_point()

?pokedata
