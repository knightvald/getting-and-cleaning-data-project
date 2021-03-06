# runAnalysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Clean up workspace
rm(list=ls())

library(plyr)
# Step 1
# Merge the training and test sets to create one data set
#########################################################

x_train <- read.table("./UCIHAR/train/X_train.txt")
y_train <- read.table("./UCIHAR/train/y_train.txt")
subject_train <- read.table("./UCIHAR/train/subject_train.txt")
x_test <- read.table("./UCIHAR/test/X_test.txt")
y_test <- read.table("./UCIHAR/test/y_test.txt")
subject_test <- read.table("./UCIHAR/test/subject_test.txt")

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)

#Merge all that data into one dataset
all_data<- cbind( x_data, y_data, subject_data)

# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################

features <- read.table("./UCIHAR/features.txt")

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
X_data <- x_data[, mean_and_std_features]

# correct the column names
names(X_data) <- features[mean_and_std_features, 2]

# Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################

activities <- read.table("./UCIHAR/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################

# give correct column name
names(subject_data) <- "subject"

# bind all the data in a data set
All_data <- cbind(X_data, y_data, subject_data)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# columns except (activity & subject)
averages_data <- ddply(All_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)