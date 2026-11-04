here::i_am(
  "code/03_create_figure.R"
)

library(ggplot2)

df_final <- read.csv("data/derived/project_data.csv")

figure <- ggplot(df_final, aes(year, number_primary_care_physicians.x, color = area)) +
  stat_summary(fun = mean, geom = "line", linewidth = 0.53) +
  stat_summary(fun = mean, geom = "point") +
  scale_x_continuous(breaks = 2016:2025) +
  labs(title = "Number of PCPs, rural vs. urban counties",
       x = "CHR&R release year", y = "Number of primary care physicians") +
  theme_minimal()

ggsave("output/figure.png", figure, width = 7, height = 4.5, dpi = 300)