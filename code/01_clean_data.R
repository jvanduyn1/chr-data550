here::i_am(
  "code/01_clean_data.R"
)

library(dplyr)
library(janitor)

twenty16ranked <- read.csv("data/raw/2016 County Health Rankings Data - v3 (Ranked).csv")
twenty16add <- read.csv("data/raw/2016 County Health Rankings Data - v3 (Additional).csv")
twenty17ranked <- read.csv("data/raw/2017CountyHealthRankingsData (Ranked).csv")
twenty17add <- read.csv("data/raw/2017CountyHealthRankingsData (Additional).csv")
twenty18ranked <- read.csv("data/raw/2018 County Health Rankings Data - v2 (Ranked).csv")
twenty18add <- read.csv("data/raw/2018 County Health Rankings Data - v2 (Additional).csv")
twenty19ranked <- read.csv("data/raw/2019 County Health Rankings Data - v3 (Ranked).csv")
twenty19add <- read.csv("data/raw/2019 County Health Rankings Data - v3 (Additional).csv")
twenty20ranked <- read.csv("data/raw/2020 County Health Rankings Data - v2 (Ranked).csv")
twenty20add <- read.csv("data/raw/2020 County Health Rankings Data - v2 (Additional).csv")
twenty21ranked <- read.csv("data/raw/2021 County Health Rankings Data - v1 (Ranked).csv")
twenty21add <- read.csv("data/raw/2021 County Health Rankings Data - v1 (Additional).csv")
twenty22ranked <- read.csv("data/raw/2022 County Health Rankings Data - v1 (Ranked Measures).csv")
twenty22add <- read.csv("data/raw/2022 County Health Rankings Data - v1 (Additional Measures).csv")
twenty23ranked <- read.csv("data/raw/2023 County Health Rankings Data - v2 (Ranked).csv")
twenty23add <- read.csv("data/raw/2023 County Health Rankings Data - v2 (Additional).csv")
twenty24ranked <- read.csv("data/raw/2024 County Health Rankings Data - v1 (Ranked).csv")
twenty24add <- read.csv("data/raw/2024 County Health Rankings Data - v1 (Additional).csv")
twenty25ranked <- read.csv("data/raw/2025 County Health Rankings Data - v4 (Ranked).csv")
twenty25add <- read.csv("data/raw/2025 County Health Rankings Data - v4 (Additional).csv")

years <- 16:25

merged <- bind_rows(lapply(years, function(y) {
  df <- get(paste0("twenty", sprintf("%02d", y), "ranked"))
  
  colnames(df) <- as.character(unlist(df[1, ]))
  colnames(df) <- janitor::make_clean_names(colnames(df))
  
  df <- df[-1, ]
  
  df$year <- 2000 + y
  
  df
}))

merged1 <- bind_rows(lapply(years, function(y) {
  
  df <- get(paste0("twenty", sprintf("%02d", y), "add"))
  
  headers <- as.character(unlist(df[1, ]))
  
  keep <- !(is.na(headers) | headers == "")
  df <- df[, keep]
  headers <- headers[keep]
  
  colnames(df) <- make_clean_names(headers)
  
  df <- df[-1, ]
  
  df$year <- 2000 + y
  
  df
}))

df_merged <- merged %>%
  select(-population) %>%
  left_join(
    merged1,
    by = c("fips", "state", "county", "year")
  )

keep_cols <- c(
  "fips",
  "state",
  "county",
  "year",
  "population.x",
  "infant_mortality_rate",
  "percent_children_in_poverty.x",
  "percent_rural",
  "years_of_potential_life_lost_rate.x",
  "number_primary_care_physicians.x"
)

df_final <- df_merged |>
  select(any_of(keep_cols))

df_final <- df_final %>%
  mutate(across(-c(fips, county, year), as.numeric))

df_final <- df_final %>%
  group_by(fips) %>%
  mutate(area = ifelse(median(percent_rural, na.rm = TRUE) >= 50, "Rural", "Urban")) %>%
  ungroup() %>%
  filter(!is.na(area))

dir.create("data/derived", showWarnings = FALSE, recursive = TRUE)
write.csv(df_final, "data/derived/project_data.csv", row.names = FALSE)
