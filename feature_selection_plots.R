
library(ggplot2)
library(ggcorrplot)

models <- read.csv('~/Downloads/models_REV.csv')

# reorder variables by frequency
models_ord <- models[order(models$Frequency),] 

# Plot Frequency by Domain
models_ord$Variable <- factor(models_ord$Variable, levels = models_ord$Variable[order(models_ord$Frequency)])
models_ord$Variable  # notice the changed order of factor levels

ggplot(models_ord, aes(x=Variable,y=Frequency,fill=Domain)) +
  geom_bar(position="dodge",stat="identity") + 
  coord_flip() +
  scale_fill_brewer(palette="Set1") +
  theme_bw() + 
  theme(plot.title = element_text(size=22),
        axis.title = element_text(size=16, face="bold"),
        axis.text=element_text(size=14,color = "black"),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"),
        legend.title = element_text(size=18,face="bold"),
        legend.text = element_text(size=18),
        legend.position = c(0.8, 0.3))

# Frequency by Task
ggplot(models_ord, aes(x=Variable,y=Frequency,fill=Assessment)) +
  geom_bar(position="dodge",stat="identity") + 
  coord_flip() +
  ggtitle("Strategies for Using ")

