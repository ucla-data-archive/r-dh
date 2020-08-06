library(tidyverse)

#read in the data
emperors <- read_csv(file.path("data", "emperors.csv"))
#emperors <- read_csv('data/emperors.csv')

emperors

emperors %>%
  count(cause) %>%
  ggplot(aes(x = n, y = cause)) +
  geom_col() +
  geom_text(aes(label = n, x = n - .25), color = "white", size = 5, hjust = 1) +
  cowplot::theme_minimal_vgrid(16) +
  theme(axis.title.y = element_blank(),legend.position = "none") +
  xlab("number of emperors")
