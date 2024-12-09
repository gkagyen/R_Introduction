
# Creating variables
patient_age <- 45          # Numeric
patient_name <- "John"     # Character
is_smoker <- TRUE          # Logical

# Creating numeric vectors
ages <- c(30, 35, 40, 45, 50)

ages# Creating character vectors
patients <- c("John", "Alice", "Mike", "Sarah")

# Accessing elements of a vector
ages[2]        # Second element of ages
patients[3]    # Third element of patients

patients[2:4]  # 2nd to 4th element of patients
ages[-3]       # Remove 3rd element from ages
ages[ages > 35] #Filter out ages greater than 35

# Arithmetic operations on vector
ages - 10
ages + ages
ages / 5
ages * 2
