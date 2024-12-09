# Install readr and readxl (only needs to be done once)
#install.packages("readr")
#install.packages("readxl")

# Load the packages
library(readr)
library(readxl)


# Reading a CSV file
path_to_file <- "C:/Users/gkagy/OneDrive/Desktop/InciSion Ghana/datasets/health_data.csv"
health_data <- read_csv(path_to_file)

# View the first few rows
head(health_data)

# Reading an Excel file
file_location <- "C:/Users/gkagy/OneDrive/Desktop/InciSion Ghana/datasets/health_data.xlsx"
health_data_excel <- read_excel(file_location)

# View the first few rows
head(health_data_excel)


# Checking the structure of the data
str(health_data)

# Getting a summary of the data
summary(health_data)

# Viewing the first few rows
head(health_data)

# Viewing the last few rows
tail(health_data)
