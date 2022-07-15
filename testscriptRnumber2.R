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
