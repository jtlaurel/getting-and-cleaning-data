##The function of this script is to:
##1. Merges the training and the test sets to create one data set.
##2. Extracts only the measurements on the mean and standard deviation for each measurement.
##3. Uses descriptive activity names to name the activities in the data set
##4. Appropriately labels the data set with descriptive variable names.
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Load necessary libraries.
library(read.table)
library(dplyr)

##Begin by loading the activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
use_activity_labels <- activity_labels[,2]

##Load the features
features <- read.table("./UCI HAR Dataset/features.txt")
use_features <- features[,2]

##Find the desired measurements for the Step 2 by filtering 'mean' and 'std'
extractedfeatures <- grep("mean\\(\\)|std\\(\\)",use_features)

##Load the X_test and X_train and combine into one data set using feature names (Step 1)
values_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=c(use_features))
values_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=c(use_features))
values <- rbind(values_test, values_train)

##Extract the desired measurements in the combined data set (Step 2)
values <- values[extractedfeatures]

##Load the y_test and y_train and combine into one data set (Step 1)
activities_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
activities_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
activities <- rbind(activities_test, activities_train)

##Clone activities in order to properly label activities 
activities <- cbind(activities, activities)

##Substitute descriptive activity names for labels (Step 3)
activities[,2] <- gsub("1", activity_labels[1,2], activities[,2])
activities[,2] <- gsub("2", activity_labels[2,2], activities[,2])
activities[,2] <- gsub("3", activity_labels[3,2], activities[,2])
activities[,2] <- gsub("4", activity_labels[4,2], activities[,2])
activities[,2] <- gsub("5", activity_labels[5,2], activities[,2])
activities[,2] <- gsub("6", activity_labels[6,2], activities[,2])

##Label dataset (Step 4)
colnames(activities) <- c("Activity_Label","Activity_Name")

##Load the subject_test and subject_train and combine into one data set (Step 1)
subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names=c("Subject"))
subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names=c("Subject"))
subjects <- rbind(subjects_test, subjects_train)

##Combine data set using descriptive labels for variables (Step 4)
data_set <- cbind(subjects, activities, values)

##Summarize data using dplyr in order to sort by activity and subject (Step 5)
grouped_data <- group_by(data_set, Subject, Activity_Label, Activity_Name)
summarized_data <- summarise_each(grouped_data, funs(mean))

##Create a new tidy data set with summarized data (Step 5)
write.table(summarized_data, file = "./tidy_dataset.txt", row.names = FALSE)
