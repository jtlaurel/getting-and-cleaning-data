library(read.table)
library(dplyr)


activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
use_activity_labels <- activity_labels[,2]

features <- read.table("./UCI HAR Dataset/features.txt")
use_features <- features[,2]

extractedfeatures <- grep("mean\\(\\)|std\\(\\)",use_features)

values_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=c(use_features))
values_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=c(use_features))
values <- rbind(values_test, values_train)
values <- values[extractedfeatures]


activities_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
activities_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

activities <- rbind(activities_test, activities_train)
activities <- cbind(activities, activities)

activities[,2] <- gsub("1", activity_labels[1,2], activities[,2])
activities[,2] <- gsub("2", activity_labels[2,2], activities[,2])
activities[,2] <- gsub("3", activity_labels[3,2], activities[,2])
activities[,2] <- gsub("4", activity_labels[4,2], activities[,2])
activities[,2] <- gsub("5", activity_labels[5,2], activities[,2])
activities[,2] <- gsub("6", activity_labels[6,2], activities[,2])

colnames(activities) <- c("Activity_Label","Activity_Name")


subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names=c("Subject"))
subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names=c("Subject"))

subjects <- rbind(subjects_test, subjects_train)


data_set <- cbind(subjects, activities, values)


grouped_data <- group_by(data_set, Subject, Activity_Label, Activity_Name)
summarized_data <- summarise_each(grouped_data, funs(mean))

write.table(summarized_data, file = "./tidy_dataset.txt", row.names = FALSE,)

