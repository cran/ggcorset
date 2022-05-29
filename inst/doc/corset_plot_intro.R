## ----setup, echo=FALSE, message=FALSE, results='hide'-------------------------
knitr::opts_chunk$set(fig.width = 15, fig.height = 9, fig.align = "center")

## ---- fig.show='hide'---------------------------------------------------------

library(ggcorset)
library(ggplot2)

# LOAD "drinkdays" data from the ggcorset package
data("drinkdays")

# Magnitude of change: Subtract T1 from T2
drinkdays$change <- drinkdays$time2-drinkdays$time1

# Direction of Change
drinkdays$direction <- ifelse(drinkdays$change<0,"Decrease",
                              ifelse(drinkdays$change>0,"Increase","No Change"))
drinkdays$direction <- factor(drinkdays$direction, 
                              levels = c("Increase","No Change","Decrease"))

# CORSET PLOT: Basic plot + theme_ggcorset()
plot <- gg_corset(drinkdays, y_var1 = "time1", y_var2 = "time2", 
                  c_var = "direction", group = "id", eyelets = T) + 
        theme_ggcorset()

# ADDITIONAL ggplot2 commands
plot + 
  # Changes legend title, and selects a colour-palette
  scale_colour_manual("Direction of Change",
                    values = MetBrewer::met.brewer("Ingres",3)) +
  # Changes the plot title
  ggtitle("Change in Drinking Days") + 
  # Changes the y-axis title
  ylab("Number of Drinking Days per Week") + 
  # Changes the x-axis title (removes in favour of the 2 time point labels below)
  xlab("") +
  # Changes the labels of the 2 time points (on the x-axis)
  scale_x_discrete(labels = c("Pre","Post")) +
  # Makes the legend lines thicker
  guides(colour = guide_legend(override.aes = list(size = 3)))


## ----out.width=650------------------------------------------------------------

gg_corset(drinkdays, y_var1 = "time1", y_var2 = "time2",
          c_var = "direction", group = "id", faceted = T) + 
  theme_ggcorset() +  
  scale_colour_manual("Direction of Change",
                      values = MetBrewer::met.brewer("Troy",3))  +
  ggtitle("Change in Drinking Days") + 
  ylab("Number of Drinking Days per Week") + xlab("") +
  scale_x_discrete(labels = c("Pre","Post")) +
  guides(colour = guide_legend(override.aes = list(size = 3)))


## ---- out.width=650-----------------------------------------------------------

gg_corset(drinkdays, y_var1 = "time1", y_var2 = "time2", 
          c_var = "change", group = "id", line_size = 0.5) + 
  theme_ggcorset() +
  viridis::scale_colour_viridis(
    option = "cividis", direction = -1,
    breaks = c(-7,0,7),  # can set the legend limits here (min and max)
    name = "") +         # can rename the legend title here or omit
  ggtitle("Change in Drinking Days") +
  ylab("Number of Drinking Days per Week") + xlab("") +
  scale_x_discrete(labels = c("Pre","Post"))


