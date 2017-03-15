# Step_1
# Preparation of dataset folder
setwd("datacleaning") # This is a folder to save my project in
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#Downloading dataset zip from provided url
download.file(fileurl, "./assignment.zip") 
#unzipping provided files/folders
unzip("assignment.zip", exdir = ".") 
# Folder "UCI HAR Dataset" is ready for data cleaning  

# Step_2
# Reading observation files from "test" and "train" subfolders

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header= FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header= FALSE)
# Both tables have equal number of variables (561)

# Merging training and test sets to create one data set (TASK 1 of this assignment)
X <- rbind(X_test, X_train)

# Step_3
# Providing variable names for X, selecting the columns with mean() and std() variables

# features.txt is converted into string of chracters with a length of 561
library(stringi)
features <- stri_read_lines("./UCI HAR Dataset/features.txt")
# Removing 1:561 indices from variable names 
features_string <- c(stri_sub(features[1:9], 3), stri_sub(features[10:99], 4), stri_sub(features[100:561], 5))

# X table gets headers
names(X) <- features_string

# Search is applied on features_string to find variables that contain mean() and std(). 
# Note: this search eliminates variables that contain meanFreq().
# The resulting object is an integer vector  
string_filtered <- sort(c(grep("\\bmean()\\b", features_string), grep("\\bstd()\\b", features_string)))  

# X table gets filter applied.
X_filtered <- X[, string_filtered]
# Now X_filtered contains only the measurements on the mean and std for each measurement (TASK 2 of this assignment)

# Step_4
# Reading test/train labels

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header= FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header= FALSE)
# Test/train labels have values 1-6 and have to be matched with activity names
# Rows in y_test/y_train tables correspond to observations in X_test/X_train (number of rows is equal)

# Step_5
# Associating test/train labels (obtained in Step #4) with activity names

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header= FALSE)
# Activity names are now orginazed in data frame where each activity lable(code) has corresponding description

y_test_merged <- merge(y_test, activity_labels, by.x = "V1", by.y = "V1")
y_train_merged <- merge(y_train, activity_labels, by.x = "V1", by.y = "V1")
# Test/train labels now have associated descriptions

# Step_6
# Reading subject codes and combining data with test/train labels plus descriptions

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header= FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header= FALSE)
y_test_complete <- cbind(y_test_merged, subject_test)
y_train_complete <- cbind(y_train_merged, subject_train)

# Step_7
# Combining y_test_complete/y_train_complete datasets

Y <- rbind(y_test_complete, y_train_complete)
# Creating header for this dataset
names(Y) <- c("Activity_label", "Activity_name", "Subject_code")

# Step_8
# Merging previously prepared Y dataset with filtered variables table (X_filtered)

dataset <- cbind(Y, X_filtered)
# Column #2 of this dataset contains descriptive activity names (TASK 3 of this assignment)
# This dataset has descriptive variable names (previously pulled from features.txt) (TASK 4 of this assignment)

# Step_9
# Preparing summarized data table

summarised_data <- aggregate(dataset[4:69], list(dataset$Activity_name, dataset$Subject_code), mean)
summarised_data <- dplyr::rename(summarised_data, Activity_name = Group.1, Subject_code = Group.2)
# Note: [4:69] subsetting is conducted because first three columns of dataset are not interesting for this data summary
# Renaming gives titles to first two columns (which are our summarizing factors).
# (TASK 5 of this assignment)