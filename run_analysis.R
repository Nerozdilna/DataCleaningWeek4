### Step_1
### Preparation of dataset folder
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#Downloading dataset zip from provided url
download.file(fileurl, "./assignment.zip") 
### Unzipping provided files/folders
unzip("assignment.zip", exdir = ".") 
# Folder "UCI HAR Dataset" is ready for data cleaning  

### Step_2
### Reading subject codes, activity labels and observation files from "test" subfolder, and merging three pieces into one dataset

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header= FALSE) ### Subjects vary from 1 to 30, dimention of this set is 2947 by 1
### Subject codes vary from 1 to 30, dimention of this set is 2947 by 1
label_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header= FALSE)
### Activity labels vary from 1 to 6, dimention of this set is also 2947 by 1
obs_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header= FALSE)
### This is a set of observations with dimentions 2947 by 561

### We will now merge above datasets

test <- cbind(subject_test, label_test, obs_test)

### Step_3
### Steps described in Step_2 are now repeated for "train" subfolder, and then "test" and "train" subsets are merged (vertical binding)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header= FALSE)
label_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header= FALSE)
obs_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header= FALSE)
train <- cbind(subject_train, label_train, obs_train)

### Merging two subsets

completedataset <- rbind(test, train)
### This resulting dataset has dimentions of 10299 by 563.


### Step_4
### Providing variable names for completedataset, selecting the columns with mean() and std() variables

### features.txt is converted into string of characters with a length of 561
library(stringi)
features <- stri_read_lines("./UCI HAR Dataset/features.txt")
### To make header look tidier, we will remove 1:561 indices from variable names 
features_string <- c(stri_sub(features[1:9], 3), stri_sub(features[10:99], 4), stri_sub(features[100:561], 5))

### We will now provide headers to completedataset
names(completedataset) <- c("subject", "activitycode", features_string)

### Search is applied on features_string to find variables that contain mean() and std(). 
### Note: this search eliminates variables that contain meanFreq().
### The resulting object is an integer vector  
string_filtered <- sort(c(grep("\\bmean()\\b", features_string), grep("\\bstd()\\b", features_string))) + 2 

### completedataset table gets filter applied.
filterdataset <- completedataset[ ,c(1:2, string_filtered)]
### Now filterdataset contains only the measurements on the mean and std for each measurement

### Step_5
### Preparing summarized data table

summarised <- aggregate(filterdataset[ ,3:66], list(filterdataset$subject, filterdataset$activitycode), mean)
### Note: [3:69] subsetting is conducted because first two columns of dataset are summarizing factors for this data summary

summarised <- dplyr::rename(summarised, subject = Group.1, activitycode = Group.2)

### Renaming gives titles to first two columns.

### Step_6
### Adding activity names to activity codes in summarised dataset

activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header= FALSE)
summarised <- merge(activitylabels, summarised, by.x = "V1", by.y = "activitycode")
### Giving names to first two columns
summarised <- dplyr::rename(summarised, activitycode = V1, act_description = V2)

### Step_7
### Writing txt file from "summarised" object
write.table(summarised, "./summarised_done.txt", row.name=FALSE)
