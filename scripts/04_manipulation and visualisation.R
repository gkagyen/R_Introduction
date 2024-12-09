library(dplyr)
library(ggplot2)

# Filter patients over the age of 40 who are smokers
smokers_over_40 <- health_data |>  
  filter(age > 40, smoker == TRUE)
head(smokers_over_40)

# Select only the patient_id, age, and bmi columns
selected_columns <- health_data |>  
  select(patient_id, age, bmi)
head(selected_columns)

# Create a new column indicating if a patient is overweight (BMI > 25)
health_data <- health_data |>  
  mutate(overweight = bmi > 25)
names(health_data)
health_data[ ,"overweight"]

# Arrange the data by cholesterol levels in descending order
arranged_data <- health_data |>  
  arrange(desc(cholesterol))
head(arranged_data)

# Summarize the average cholesterol level in the dataset
average_cholesterol <- health_data |>  
  summarise(avg_cholesterol = mean(cholesterol, na.rm = TRUE))
print(average_cholesterol)

# Group by gender and summarize the average BMI for each gender
bmi_by_gender <- health_data |>  
  group_by(gender) |>  
  summarise(avg_bmi = mean(bmi, na.rm = TRUE))
print(bmi_by_gender)


# Visualisation ------------------------------------------------------------------------

# Scatter plot of BMI and cholesterol
ggplot(health_data, aes(x = bmi, y = cholesterol)) +
  geom_point() +
  labs(title = "Scatter Plot of BMI vs Cholesterol",
       x = "BMI",
       y = "Cholesterol") +
  theme_minimal()

# Bar plot of average cholesterol by smoker status
ggplot(health_data, aes(x = smoker, y = cholesterol, fill = gender)) +
  stat_summary(fun = mean, geom = "bar", position = 'dodge', colour = 'black') +
  labs(title = "Average Cholesterol by Smoking Status",
       subtitle = "Both Gender",
       x = "Smoking Status",
       y = "Average Cholesterol") +
  coord_flip()

# Boxplot of BMI by gender
ggplot(health_data, aes(x = gender, y = bmi)) +
  geom_boxplot(aes(fill = gender), show.legend = F) +
  labs(title = "BMI Distribution by Gender",
       x = "Gender",
       y = "BMI") +
  theme_classic() +
  scale_fill_brewer(palette = 'Set2')

# Histogram of BMI
ggplot(health_data, aes(x = bmi)) +
  geom_histogram(binwidth = 2, fill = "blue", color = "white") +
  labs(title = "Distribution of BMI",
       x = "BMI",
       y = "Count") +
  theme_bw()
