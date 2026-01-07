#============================================================
#  THESIS SCRIPT: EU CLIMATE POLICY & BANK PERFORMANCE
#============================================================
#  East vs West Europe — Difference-in-Differences Panel Analysis

# 1. CLEAN SESSION (GOOD PRACTICE FOR PERFECT LAYOUT)

  

rm(list = ls()) # Remove all objects from memory
graphics.off() # Close all open plots
cat("\014") # Clear console


#  2. LOAD REQUIRED PACKAGES

  install.packages(c(
    "tidyverse",
    "lubridate",
    "fixest",
    "zoo",
    "stringr"
  ))

library(tidyverse) # Data manipulation + plotting
library(lubridate) # Date handling
library(stringr) # String manipulation
library(fixest) # Fixed effects & DiD regressions
library(zoo) # Quarterly date handling

# 3.SET WORKING DIRECTORY 

setwd("~/climate_banks_eu")

#  4. LOAD AND PREPARE CET1 DATA (CAPITAL ADEQUACY)

# Load raw CET1 data from ECB

cet1_raw <- read_csv("Raw data/ECB Data CET1.csv")

# Inspect structure (we always do this with raw data)

head(cet1_raw)
glimpse(cet1_raw)


# Convert CET1 from wide to long format
# Each row = country × quarter

# ---------------------------------------------------
# Transform CET1 data from wide to long format
# ---------------------------------------------------
# 1. Reshape ECB series into panel structure
# 2. Extract country codes from series names
# 3. Drop EU aggregate
# 4. Keep consistent sample period
# ---------------------------------------------------

cet1_long <- cet1_raw %>%
  
  # Convert wide ECB format into long panel format
  pivot_longer(
    cols = -c(DATE, `TIME PERIOD`),   # All country-level series
    names_to = "series",
    values_to = "cet1"
  ) %>%
  
  mutate(
    # Extract 2-letter country code from ECB series
    # Example: "CBD2.Q.DE...." → "DE"
    country = str_extract(series, "\\.([A-Z0-9]{2})\\.") %>%
      str_remove_all("\\."),
    
    # Convert date and keep quarter label
    date    = as.Date(DATE),
    quarter = `TIME PERIOD`
  ) %>%
  
  # Drop EU aggregate (B0 is not a country)
  filter(country != "B0") %>%
  
  # Keep consistent post-2014 sample
  filter(date >= as.Date("2014-10-01")) %>%
  
  # Keep only variables needed for analysis
  select(country, date, quarter, cet1)


# Check result

head(cet1_long)
unique(cet1_long$country)


#  5. LOAD AND PREPARE ROE DATA (PROFITABILITY)

  
  roe_raw <- read_csv("Raw data/ECB Data ROE.csv")

head(roe_raw)
glimpse(roe_raw)

# Convert ROE from wide to long format

# ---------------------------------------------------
# Transform ROE data from wide to long format
# ---------------------------------------------------
# 1. Reshape ECB ROE series into panel structure
# 2. Extract country codes from series names
# 3. Drop EU aggregate
# 4. Keep consistent sample period
# ---------------------------------------------------

roe_long <- roe_raw %>%
  
  # Convert wide ECB format into long panel format
  pivot_longer(
    cols = -c(DATE, `TIME PERIOD`),   # All country-level series
    names_to = "series",
    values_to = "roe"
  ) %>%
  
  mutate(
    # Extract 2-letter country code from ECB series
    # Example: "CBD2.Q.FR...." → "FR"
    country = str_extract(series, "\\.([A-Z0-9]{2})\\.") %>%
      str_remove_all("\\."),
    
    # Convert date and keep quarter label
    date    = as.Date(DATE),
    quarter = `TIME PERIOD`
  ) %>%
  
  # Drop EU aggregate (B0 is not a country)
  filter(country != "B0") %>%
  
  # Keep same time window as CET1
  filter(date >= as.Date("2014-10-01")) %>%
  
  # Keep only variables needed for analysis
  select(country, date, quarter, roe)


head(roe_long)
unique(roe_long$country)


#  6. MERGE CET1 AND ROE INTO PANEL DATASET

# This creates a balanced country–time panel

bank_panel <- cet1_long %>%
  inner_join(
    roe_long,
    by = c("country", "date", "quarter")
  )

glimpse(bank_panel)


#  7. PANEL STRUCTURE & KEY VARIABLES

  
  bank_panel <- bank_panel %>%
  mutate(
    country = factor(country),) %>%
  arrange(country, date)

# Panel dimensions

n_distinct(bank_panel$country) # 8 countries
n_distinct(bank_panel$quarter) # time periods

# Missing values check

colSums(is.na(bank_panel))

names(bank_panel)

# ---------------------------------------------------
# Create EU climate policy timing variable
# ---------------------------------------------------
# post_policy = 1 for quarters from 2019 on wards 
# (from the implementation phase of the European Green Deal)
# post_policy = 0 before 2019
# ---------------------------------------------------

bank_panel <- bank_panel %>%
  mutate(
    year = lubridate::year(date),         # Extract year from date
    post_policy = ifelse(year >= 2019, 1, 0)
  )

#  8. DESCRIPTIVE BENCHMARK: SIMPLE OLS (NOT CAUSAL)

# These regressions ignore panel structure and serve only
#  as a baseline comparison

lm_cet1 <- lm(cet1 ~ post_policy, data = bank_panel)
summary(lm_cet1)

lm_roe <- lm(roe ~ post_policy, data = bank_panel)
summary(lm_roe)

# These OLS results show a positive association between EU climate policy 
# timing and bank capital and profitability.
# However, they do not imply causality, as they ignore country heterogeneity 
# and common time shocks.


#  9. MAIN EMPIRICAL STRATEGY: DIFFERENCE-IN-DIFFERENCES

#  Core identification:
# Compare East vs West banks BEFORE and AFTER EU climate policy

#  9.1 CET1 — DiD with Country Fixed Effects

# Create East vs West dummy variable
# East = 1 → Eastern Europe
# East = 0 → Western Europe

bank_panel <- bank_panel %>%
  mutate(
    east = ifelse(country %in% c("PL", "HU", "LT", "HR"), 1, 0)
  )

  did_cet1 <- feols(
    cet1 ~ post_policy * east | country,
    data = bank_panel,
    se = "hetero"
  )

summary(did_cet1)

# Interpretation:
# - post_policy:Change in CET1 after climate policy for Western European banks
# Result: Not significant → no meaningful change for Western banks

# - post_policy:east:Additional change in CET1 for Eastern banks
# relative to Western banks after policy.
# Result:  +3.96 percentage points
# Highly significant (p < 0.001)


#  9.2 ROE — DiD with Country Fixed Effects

  did_roe <- feols(
    roe ~ post_policy * east | country,
    data = bank_panel,
    cluster = ~country
  )

summary(did_roe)

did_roe <- feols(
  roe ~ post_policy * east | country,
  data = bank_panel,
  cluster = ~country
)

summary(did_roe)


#  10. VISUALISATION (EXPLANATORY, NOT REGRESSION EVIDENCE)

#  Average ROE over time: East vs West

library(zoo)

bank_panel <- bank_panel %>%
  mutate(
    quarter_date = as.Date(as.yearqtr(quarter))
  )


bank_panel %>%
  group_by(quarter_date, east) %>%
  summarise(mean_roe = mean(roe, na.rm = TRUE), .groups = "drop") %>%
  ggplot(aes(x = quarter_date, y = mean_roe,
             color = factor(east), group = east)) +
  geom_line(linewidth = 1) +
  geom_vline(xintercept = as.Date("2019-12-31"),
             linetype = "dashed") +
  labs(
    x = "Quarter",
    y = "Average ROE",
    color = "East (1) vs West (0)"
  ) +
  theme_minimal()

# Average CET1 over time: East vs West

bank_panel %>%
  group_by(quarter_date, east) %>%
  summarise(mean_cet1 = mean(cet1, na.rm = TRUE), .groups = "drop") %>%
  ggplot(aes(x = quarter_date, y = mean_cet1,
             color = factor(east), group = east)) +
  geom_line(linewidth = 1) +
  geom_vline(xintercept = as.Date("2019-12-31"),
             linetype = "dashed") +
  labs(
    x = "Quarter",
    y = "Average CET1",
    color = "East (1) vs West (0)"
  ) +
  theme_minimal()


#  11. NOTES ON OMITTED ANALYSES

  #  - EU-level aggregate indicators were excluded as they conceal substantial 
  #  cross-country heterogeneity and are unsuitable for identifying 
  #  differential policy effects.
  #  - Country-by-country regressions were intentionally excluded
  #  - They are highly collinear with fixed effects
  #  - They will be moved to appendix if needed
  #  - Residual plots are used only for intuition, not inference
  
#============================================================
#                 END OF SCRIPT
#============================================================


