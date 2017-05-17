# Coursera Assignment: Getting and Cleaning Data Course Project

Working with data from "Human Activity Recognition Using Smartphones Dataset" project (see "UCI HAR Dataset/README.txt" for information about the source data)


## Files

- All source data files are placed into "UCI HAR Dataset" subdirectory of the working directory
- run_analysis.R: the code performing data manipulations
- run_analysis_codebook.txt: list of variables from output data file 
- UCI HAR Dataset/run_analysis.txt: output data file 
- README.me: this file


### Requirements

Requested Assignment tasks:

- Merge the training and the test sets to create one data set.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Use descriptive activity names to name the activities in the data set
- Appropriately label the data set with descriptive variable names.
- Creates an independent tidy data set with the average of each variable for each activity and each subject

### Code

The folloving steps perforemed by run_analysis.R code:

- Load libraries and ensure the correct working directory is set
- Load activities
- Load features (variable names)
- Determine which of variables are needed for further processing (means and standard deviations only)
- Load training data: subjects, activities, measurments
- Select necessary variables from training data
- Mutate training mesurments, activity, and subjects into a single training dataset
- Load testing data: subjects, activities, measurments
- Select necessary variables from testing data
- Mutate testing mesurments, activity, and subjects into a single testing dataset
- Combine training and testing datasets (union_all)
- Join activity names to combined dataset
- Modify variable names to make them more descriptive
- Group combined dataset by activity and subject (group_by) and find mean of each other variable (summarize_each)
- Write output to run_analysis.txt

The code from run_analysis.R can be ran repeatedly in its entirety. 
