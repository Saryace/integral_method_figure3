
# Libraries ---------------------------------------------------------------

library(tidyverse)
library(ggtern)

# Data --------------------------------------------------------------------

soil_data <- data.frame(
  soil = c("a","b","c","d"),
  sand_from = c(15, 18, 57, 32),
  silt_from = c(52, 70, 8, 26),
  clay_from = c(33, 12, 35, 42),
  sand_to = c(16, 23, 50, 35),
  silt_to = c(54, 60, 10, 20),
  clay_to = c(30, 17, 40, 45)
)


# USDA triangle -----------------------------------------------------------

data(USDA)

USDA_text <- USDA  %>% group_by(Label) %>%
  summarise_if(is.numeric, mean, na.rm = TRUE)

USDA_text

# ggplot ------------------------------------------------------------------

ggplot(data = USDA, aes(y = Clay,
                        x = Sand,
                        z = Silt)) +
  coord_tern(L = "x", T = "y", R = "z") +
  geom_polygon(aes(fill = Label),
               alpha = 0.0,
               size = 0.5,
               color = "black") +
  geom_text(data = USDA_text,
            aes(label = Label),
            color = 'black',
            size = 2) +
  geom_point(
    data = soil_data,
    aes(
      x = sand_from,
      y = clay_from,
      z = silt_from,
      color = "Method A"
    ),
    size = 2,
    alpha = 0.75
  ) +
  geom_point(
    data = soil_data,
    aes(
      x = sand_to,
      y = clay_to,
      z = silt_to,
      color = "Method B"
    ),
    size = 2,
    alpha = 0.75
  ) +
  geom_segment(
    aes(
      x = sand_from,
      y = clay_from,
      z = silt_from,
      xend = sand_to,
      yend = clay_to,
      zend = silt_to
    ),
    colour = "#636363",
    size = 0.25,
    data = soil_data,
    arrow = arrow(length = unit(0.1, "cm"))
  ) +
  scale_color_discrete(
    name = "Methods",
    labels = c("Analysis A", "Analysis B") 
    ) +
      theme_showarrows() +
      theme_clockwise() +
      theme(
        text = element_text(family = "Helvetica"),
        legend.position = "bottom"
      ) +
      guides(fill = "none")
    


