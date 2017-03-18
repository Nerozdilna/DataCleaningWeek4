### Source data described (taken from original text)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ 
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

### Manipulations described (new)

Original data (described above) was split into "test" and "train" sections with volunteer numbers and activity codes/descriptions provided in separate files. This data was merged into one dataset. run_analysis.R has step by step description of this process. 

Raw data originally contained 18 sets of variables. Also, it contained additional vectors obtained by averaging the signals. For the purpose of this analysis, a set of variables that were estimated from recorded signals was litimed only to:

* mean(): Mean value
* std(): Standard deviation

66 variables were left for further analysis. Out of 17 sygnals, 8 sygnals have 6 variables each, and 9 sygnals have 2 variables each. Note: meanFreq() was excluded from this analysis

10299 observations were recorded by 30 volunteers doing 6 different activities.

Summarised data calculated mean values for 10299 ovservations, and the summarising factors were a) activity description, b) volunteer number(code)

Names for summarised dataset were derived from features.txt file with following changes:
* Indices were dropped
* "BodyBody"" for fBodyGyroJerkMag sygnal was changed to "Body" to relate it to name in original info about featurers.

Names of first three columns are:
activitycode - For code of volunteer activities (1 to 6)
act_description - Acitivity described (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
subject - Volunteer number (code)
