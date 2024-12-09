# Load necessary packages
library(medicaldata)
library(tidyverse)
library(skimr)


# Load the covid_testing data
data("covid_testing")
covid_testing <- as_tibble(covid_testing) 

# Explore the data
head(covid_testing)
glimpse(covid_testing)
summary(covid_testing)

skim(covid_testing) # create a tabular summary of data

sum(is.na(covid_testing)) # check total number of missing number
colSums(is.na(covid_testing)) # check missing numbers by column

unique(covid_testing$result)  # test results
unique(covid_testing$demo_group) # patient groups
unique(covid_testing$payor_group) # payor groups
unique(covid_testing$test_id) # type of test performed
unique(covid_testing$patient_class) # patients' classifications

# Clean data
# filter out 'invalid' test results and remove missing values for PC range results
covid_test_clean <- covid_testing |> 
  filter(result != "invalid") |> drop_na(ct_result)

# Data Manipulation
# filter for tests conducted at drive through sites
drive_thru_tests <- covid_test_clean |> 
  filter(drive_thru_ind == 1)

#group by demographic groups and summarise positivity rate
demo_summary <- covid_test_clean |> 
  group_by(demo_group) |> 
  summarise(total_tests = n(),
            positive_tests = sum(result == "positive"),
            positivity_rate = round(positive_tests/total_tests, 2))

#find average ct_result for positive cases
avg_ct_result <- covid_test_clean |> 
  filter(result == "positive") |> 
  summarise(mean_ct = mean(ct_result, na.rm=T))

#turnaround time summary by patient class
turnaround_summary <- covid_test_clean |> 
  group_by(patient_class) |> drop_na() |> 
  summarise(mean_col_rec_tat = mean(col_rec_tat, na.rm=T),
            mean_rec_ver_tat = mean(rec_ver_tat, na.rm=T))

# Group by demo_group and calculate average ct_result for positive cases
positive_cases <- covid_test_clean %>%
  filter(result == "positive") %>%
  group_by(demo_group) %>%
  summarise(avg_ct_result = mean(ct_result, na.rm = TRUE))

# Data Visualisation
# bar plot of positivity rate v demo group
ggplot(data = demo_summary, aes(x = demo_group, y = positivity_rate)) +
  geom_col(fill = "turquoise", colour = 'black') +
  labs(title = "Positivity Rate by Demographic Group",
       x = "Demographic Group",
       y = "Positivity Rate") +
  theme_bw()

#distribution of ct_result for positive cases
covid_test_clean |> filter(result == "positive") |> 
  ggplot(aes(x = ct_result)) +
  geom_histogram(binwidth = 1.5, fill = "orange", colour = 'black') +
  labs(x="Cycle threshold (ct_result)",
       y="Count") +
  theme_classic()

#trend of positive cases over time
ggplot(covid_test_clean %>% filter(result == "positive"), aes(x = pan_day)) +
  geom_line(stat = 'count') +
  labs(title = "Trend of Positive COVID-19 Cases Over Time",
       x = "Collection Date",
       y = "Count of Positive Results") +
  theme_classic()

ggplot(covid_test_clean %>% filter(result == "positive"), aes(x = demo_group, y = age)) +
  geom_boxplot(aes(fill = demo_group), show.legend = F) +
  labs(title = "Distribution of Ages (ct_result) by Demographic Group",
       x = "Demographic Group",
       y = "Age") +
  theme_bw()
