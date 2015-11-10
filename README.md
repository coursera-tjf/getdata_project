## Getting and Cleaning Data Project

### Project Details

You should create one R script called run\_analysis.R that does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each
measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set
with the average of each variable for each activity and each subject.

### Data

Original data is available
[here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Data for this project is in the UCI HAR Dataset directory already extracted
fro the .zip file

### Implementation - run\_project.R

This project uses the data.table (for data import, subsetting, and melt+dcast)
as well as plyr (*ply functions) packages.

#### Functions

* get.activity.labels - import the activity labels
* get.features - import the features list
* get.data(type, other.dir, what) - import data by building path from function
arguments
  * type = train or test
  * other.dir = NA (empty) or Inertial Data
  * what = body\_acc\_[xyz], body\_gyro\_[xyz], or total\_acc\_[xyz]

#### Body of code

1. Merges the training and the test sets to create one data set.
  * All function used with ldply function to "merge" training and test data sets
as well as easily import data with similar paths when using the get.data
function.
2. Extracts only the measurements on the mean and standard deviation for each
measurement.
  * Use grep to fund strings mean() and std() in features, the list of column
names for the variable X\_(train|test)
3. Uses descriptive activity names to name the activities in the data set
  * Join activity labels to the variable y\_(train|test)
4. Appropriately labels the data set with descriptive variable names. 
  * When completing #2, assign column names of variable X to those in the
features.txt file.  Put activities, means, and stds together for a complete
annotated data set.
5. From the data set in step 4, creates a second, independent tidy data set
with the average of each variable for each activity and each subject.
  * cbind activities, subjects, and means (drop std variables as not mentioned
in project for #5) into a resulting data.table
  * melt this data.table with activity and subject as id.vars such that all
other variables can be aggregated (using the mean function) when dcast
  * Performed several column name reformatting/substitutions to get easier to
read column names/variable descriptions
  * Write data to an output.txt file - tab delimited


### Output - output.txt

* Contains 180 observations of 30 variables
  * 30 subjects * 6 activities = 180 observations ("tidy data set with the
average of each variable for each activity and each subject")

#### Codebook
* subject - 1 of 30 volunteers within an age bracket of 19-48 years
* activity - 1 of 6 activities (WALKING, WALKING\_UPSTAIRS,
WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung
Galaxy S II) on the waist
* mean-tBodyAcc-X - average body acceleration signal in the x-direction
* mean-tBodyAcc-Y - average body acceleration signal in the y-direction
* mean-tBodyAcc-Z - average body acceleration signal in the z-direction
* mean-tGravityAcc-X - average gravity acceleration signal in the x-direction
* mean-tGravityAcc-Y - average gravity acceleration signal in the y-direction
* mean-tGravityAcc-Z - average gravity acceleration signal in the z-direction
* mean-tBodyAccJerk-X - average body acceleration jerk signal in the x-direction
* mean-tBodyAccJerk-Y - average body acceleration jerk signal in the y-direction
* mean-tBodyAccJerk-Z - average body acceleration jerk signal in the z-direction
* mean-tBodyGyro-X - average body gyroscope signal in the x-direction
* mean-tBodyGyro-Y - average body gyroscope signal in the y-direction
* mean-tBodyGyro-Z - average body gyroscope signal in the z-direction
* mean-tBodyGyroJerk-X - average body gyroscope jerk signal in the x-direction
* mean-tBodyGyroJerk-Y - average body gyroscope jerk signal in the y-direction
* mean-tBodyGyroJerk-Z - average body gyroscope jerk signal in the z-direction
* mean-tBodyAccMag - average magnitude (Euclidean norm) of the body
acceleration signal
* mean-tGravityAccMag - average magnitude (Euclidean norm) of the gravity
acceleration signal
* mean-tBodyAccJerkMag - average magnitude (Euclidean norm) of the body
acceleration jerk signal
* mean-tBodyGyroMag - average magnitude (Euclidean norm) of the body gyroscope
signal
* mean-tBodyGyroJerkMag - average magniture (Euclidean norm) of the body
gyroscope jerk signal
* mean-fBodyAcc-X - average Fast Fourier Transform of the body acceleration
signal in the x-direction
* mean-fBodyAcc-Y - average Fast Fourier Transform of the body acceleration
signal in the y-direction
* mean-fBodyAcc-Z - average Fast Fourier Transform of the body acceleration
signal in the z-direction
* mean-fBodyAccJerk-X - average Fast Fourier Transform of the body
acceleration jerk signal in the x-direction
* mean-fBodyAccJerk-Y - average Fast Fourier Transform of the body
acceleration jerk signal in the y-direction
* mean-fBodyAccJerk-Z - average Fast Fourier Transform of the body
acceleration jerk signal in the z-direction
* mean-fBodyGyro-X - average Fast Fourier Transform of the body gyroscope
signal in the x-direction
* mean-fBodyGyro-Y - average Fast Fourier Transform of the body gyroscope 
signal in the y-direction
* mean-fBodyGyro-Z - average Fast Fourier Transform of the body gyroscope 
signal in the z-direction
* mean-fBodyAccMag - average magnitude of the Fast Fourier Transform of the
body acceleration signal
* mean-fBodyBodyAccJerkMag average magnitude of the Fast Fourier Transform of
the body acceleration jerk signal
* mean-fBodyBodyGyroMag average magnitude of the Fast Fourier Transform of the
body gyroscope signal
* mean-fBodyBodyGyroJerkMag average magnitude of the Fast Fourier Transform of
the body gyroscope jerk signal
