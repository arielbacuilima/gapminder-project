library(dplyr)
library(ggplot2)

#Q1: How many adults in the world say they can read?
# this question peaked a curiosity to find out if literacy rate correlated with 
# GDP per capita across different countries?

#please download datasets

# Read in the datasets
literacy <- read.csv("literacy_rate_adult_total_percent_of_people_ages_15_and_above.csv")
gdp_per_capita <- read.csv("gdp_pcap.csv")

# Filter the datasets to include only the year 2011
literacy_2011 <- literacy[, c("country", "X2011")]
gdp_per_capita_2011 <- gdp_per_capita[, c("country", "X2011")]

# Merge the 2 datasets by country
literacy_gdp <- merge(literacy_2011, gdp_per_capita_2011, by = "country")

# Rename columns
colnames(literacy_gdp) <- c('country', 'literacy', 'gdp')

# Convert 'literacy' and 'gdp' columns to numeric
literacy_gdp$literacy <- as.numeric(literacy_gdp$literacy)
literacy_gdp$gdp <- as.numeric(literacy_gdp$gdp)

# Remove missing values if any
literacy_gdp <- na.omit(literacy_gdp)

# Convert 'country' to factor
literacy_gdp$country <- as.factor(literacy_gdp$country)

# Plot
ggplot(literacy_gdp, aes(x = literacy, y = gdp, color = country)) +
  geom_point() +
  scale_color_discrete() +  # Use discrete color scale for categorical variable
  theme_minimal()           # Clean appearance
