library(tidycensus)

median_income <- get_acs(
  geography = "county",
  variables = "B19013_001",  # Median household income variable
  year = 2020,  # You can change the year
  survey = "acs5"  # ACS 5-Year survey data
)

median_house <- get_acs(
  geography = "county",
  variables = "B25077_001",
  year = 2020,
  survey = "acs5"
)

colnames(median_house)[4] = "Housing Price"
colnames(median_house)[2] = "County"

median_house <- median_house[,-3]
median_house <- median_house[,-4]

colnames(median_income)[4] = "Median Income"
colnames(median_income)[2] = "County"

median_income <- median_income[,-3]
median_income <- median_income[,-4]

merged_data <- merge(x = median_house, y = median_income)

data <- merged_data %>%
  mutate("Affordability Index" = round(`Housing Price`/`Median Income`,2) )

data <- data %>%
  separate(County, into = c("County", "State"), sep = ", ")

write.csv(data, "C:/Users/Hojung Yu/Downloads/tableau2.csv")
