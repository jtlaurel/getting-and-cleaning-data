# Getting and Cleaning Data
A repository containing files for the 'Getting and Cleaning Data' course project.

## Project Summary
The goal of this project was to create an R script 'run_analysis.R' that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Repository Contents
This reposity contains the following:
1. A Codebook that describes the variables, the data, and any transformations or work that were performed.
2. An R script 'run_analysis.R' that takes the data provided in the UCI Har Dataset and constructs the summarized tidy data set by utilizing the libraries ```{r}read.table``` and ```{r}dplyr```.
3. The final independent tidy data set with the average of each variable with respect to each activity and each subject.
