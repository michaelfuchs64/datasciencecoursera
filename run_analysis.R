library(data.table)
library(dtplyr)
library(dplyr)

## Set working directory
dirDataRoot = "./UCI HAR Dataset"
if (file.exists(dirDataRoot)) setwd(dirDataRoot)

## Load activities
activities <- read.table("activity_labels.txt")
names(activities) <- c("activity_id", "activity_name")

## Load features
features <- read.table("features.txt")
names(features) <- c("feature_id", "feature_name")

## Find the features we need (means and standard deviations)
required_feature_id <- grep("(mean\\(\\)|std\\(\\))", features$feature_name)


####### Load TRAIN Data ######
subject_train <- read.table("train/subject_train.txt")
activity_train <- read.table("train/y_train.txt")
data_train <- read.table("train/X_train.txt")

if(ncol(data_train) > length(required_feature_id)){
    ## Select just the columns we need (mean and standard deviations)
    data_train <- select(data_train, required_feature_id)
}

## Column namens = Required Features, remove "()" 
names(data_train) <- gsub("\\(\\)", "", features$feature_name[required_feature_id])

## Add Subject and Activity columns, indicate the dataset is "TRAIN"
data_train <- mutate(data_train, subject_id = subject_train[,1], activity_id = activity_train[,1], dataset = "TRAIN")


####### Load TEST Data ######
subject_test <- read.table("test/subject_test.txt")
activity_test <- read.table("test/y_test.txt")
data_test <- read.table("test/X_test.txt")

if(ncol(data_test) > length(required_feature_id)){
    ## Select just the columns we need (mean and standard deviations)
    data_test <- select(data_test, required_feature_id)
}

## Column namens = Required Features, remove "()" 
names(data_test) <- gsub("\\(\\)", "", features$feature_name[required_feature_id])

## Add Subject and Activity columns, indicate the dataset is "TEST"
data_test <- mutate(data_test, subject_id = subject_test[,1], activity_id = activity_test[,1], dataset = "TEST")


####### Merge TEST and TRAIN Data ######
data_combined <- union_all(data_train, data_test)

## Join activity names (by activity_id)
data_combined <- left_join(data_combined, activities)

## Decypher column names
names(data_combined) <- names(data_combined) %>%
    sub("^f","Frequency", .) %>%
    sub("^t","Time", .) %>%
    sub("Acc", "Acceleration", .) %>%
    sub("Gyro", "AngularVelocity", .) %>%
    sub("Mag", "Magnitude", .) %>%
    sub("BodyBody", "Body", .) 
    

## Group By and calculate average
data_average <- data_combined %>%
    mutate(activity_id = NULL, dataset = NULL) %>%
    group_by(activity_name, subject_id) %>%
    summarise_each(funs(mean))

## RESULT
write.table(data_average, "run_analysis.txt", row.names = FALSE)
