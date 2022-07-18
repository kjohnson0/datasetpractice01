library(ggplot2)
library(dplyr)

pokedata = read.csv("Pokemon.csv")

#can compress file so that you can upload to github
#save R object as a file
#do not write the "data/" part because I didn't make a data folder
#saveRDS(pokedata, "data/pokedata_clean.RDS")

View(pokedata)

ggplot(data = pokedata, mapping = aes(x = Type.1, y = Speed,  fill = "red")) +
  geom_violin() + 
  labs(x = "Primary Typing", title = "Pokemon Typing and Speed")

ggplot(data = pokedata, mapping = aes(x = Generation, y = Total)) + 
  geom_histogram(stat = "summary",
                 fun = "mean")

ggplot(data = pokedata, mapping = aes(x = Type.1, y = Type.2, color = Legendary)) + 
  geom_point()

ggplot(data = pokedata, mapping = aes(x = Attack, y = Sp..Atk, color = Legendary)) + 
  geom_point() +
  labs(title = "Pokemon Attack and Special Attack") +
  scale_x_continuous(breaks = seq(from = 0, to = 200))

ggplot(data = pokedata, mapping = aes(x = Attack, y = Sp..Atk, color = Generation)) + 
  geom_point() +
  labs(title = "Pokemon Attack and Special Attack")

ggplot(data = pokedata, mapping = aes(x = Type.1, y = Type.2, color = Total)) + 
  geom_count() +
  labs(title = "Concentraions of Pokemon Typing and Stats")

?pokedata



sixWaters = filter(pokedata, Type.1 == "Water" | Type.2 == "Water", Generation == 6)
sixWaters = mutate(sixWaters, meanTotal = mean(Total))
sixWaters = mutate(sixWaters, toMean = Total-meanTotal)

sixWaters

summarize(sixWaters, meanAtk = mean(Attack),
          meanSpA = mean(Sp..Atk),
          meanDef = mean(Defense),
          meanSpD = mean(Sp..Def),
          meanHP = mean(HP),
          meanSpe = mean(Speed))

ggplot(data = sixWaters, mapping = aes(x = Name, y = Sp..Def, color = Total)) +
  geom_point()

totmean = mean(pokedata$Total)
fires = filter(pokedata, Type.1 == "Fire" | Type.2 == "Fire")
dragons = filter(pokedata, Type.1 == "Dragon" | Type.2 == "Dragon")

t.test(dragons$Total, mu = totmean)
t.test(fires$Total, dragons$Total)


pop_mean = mean(iris$Sepal.Length)
setosa = filter(iris, Species == "setosa")
t.test(setosa$Sepal.Length,mu = pop_mean)

pmean = mean(iris$Petal.Length)
versicolor = filter(iris, Species == "versicolor")
t.test(versicolor$Petal.Length, mu = pmean)


setosa = filter(iris, Species == "setosa")
versicolor = filter(iris, Species == "versicolor")

t.test(versicolor$Sepal.Length, setosa$Sepal.Length)

virginica = filter(iris, Species == "virginica")
t.test(versicolor$Sepal.Length, virginica$Sepal.Length)

install.packages("datarium")
library(datarium)

# alternative = less means is option1 less than option2
t.test(mice2$before, mice2$after, paired = T, alternative = "less")

# "a ~ b" means calculate mean of "a" for each "b"
sepal_len_anova = aov(data = iris, Sepal.Length ~ Species)
sepal_len_anova

summary(sepal_len_anova)
TukeyHSD(sepal_len_anova)

sepal_width_anova = aov(data = iris, Sepal.Width ~ Species)

summary(sepal_width_anova)
TukeyHSD(sepal_width_anova)

diamondPriceColor = aov(data = diamonds, price ~ color)
summary(diamondPriceColor)

signifResults = TukeyHSD(diamondPriceColor)
# convert to dataframe so we can  use dplyr functions
arrange(as.data.frame(signifResults), 'p adj')

