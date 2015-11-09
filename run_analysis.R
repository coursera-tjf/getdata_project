# Getting and Cleaning Data Project
#
# You should create one R script called run_analysis.R that does the following
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for
#    each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

library(data.table)
library(plyr)

##### ----- COMMON VARIABLES ----- #####
data.dir <- 'UCI HAR Dataset'
inertial.dir <- 'Inertial Signals'
types <- c('train', 'test')

##### ------ FUNCTIONS ----- #####

# get activity labels
get.activity.labels <- function() {
  fread(file.path(data.dir, 'activity_labels.txt'))
}

# get features
get.features <- function() {
  fread(file.path(data.dir, 'features.txt'))
}

# get data from data.dir\other.dir\what_type.txt
get.data <- function(type, other.dir=NA, what) {
  if (is.na(other.dir))
    path <- file.path(data.dir, 
                      type, 
                      paste(what, paste0(type, '.txt'), sep='_'))
  else
    path <- file.path(data.dir,
                      type,
                      other.dir,
                      paste(what, paste0(type, '.txt'), sep='_'))
  fread(path)
}




##### ----- RUN BELOW ----- #####

# 0. Import data and
# 1. Merges the training and the test sets to create one data set.
activity.labels <- get.activity.labels()
features <- get.features()
X <- ldply(types, get.data, what='X')
y <- ldply(types, get.data, what='y')
subjects <- ldply(types, get.data, what='subject')
body_acc_x <- ldply(types, get.data, other.dir=inertial.dir, what='body_acc_x')
body_acc_y <- ldply(types, get.data, other.dir=inertial.dir, what='body_acc_y')
body_acc_z <- ldply(types, get.data, other.dir=inertial.dir, what='body_acc_z')
body_gyro_x <- ldply(types, get.data, other.dir=inertial.dir, what='body_gyro_x')
body_gyro_y <- ldply(types, get.data, other.dir=inertial.dir, what='body_gyro_y')
body_gyro_z <- ldply(types, get.data, other.dir=inertial.dir, what='body_gyro_z')
body_acc_x <- ldply(types, get.data, other.dir=inertial.dir, what='body_acc_x')
body_acc_y <- ldply(types, get.data, other.dir=inertial.dir, what='body_acc_y')
body_acc_z <- ldply(types, get.data, other.dir=inertial.dir, what='body_acc_z')


# 2. Extracts only the measurements on the mean and standard deviation for
#    each measurement.
#
# use grep to pull feature indicies that have mean and std in them
# MUST use \\(\\) to ensure only match the mean() or std() features
# first, give X colnames from features
colnames(X) <- features$V2
means <- X[, grepl('mean\\(\\)', colnames(X))]
stds <- X[, grepl('std\\(\\)', colnames(X))]


# 3. Uses descriptive activity names to name the activities in the data set
#
# join y with activity_labels
colnames(activity.labels) <- c('activity.id', 'activity')
colnames(y) <- 'activity.id'
activities <- join(y, activity.labels)
# drop activity.id
activities <- activities[,-grep('id', colnames(activities))]


# 4. Appropriately labels the data set with descriptive variable names.
dat <- data.table(cbind(activity=activities, means, stds))


# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
#
# since only want average, melt on vars that are not std vars
colnames(subjects) <- 'subject'
dat <- data.table(cbind(activity=activities, subject=subjects, means))
datl <- melt(dat, id.vars=c('subject', 'activity'))
output <- dcast(datl, subject + activity ~ variable, mean)
# fix colnames
colnames(output) <- gsub('mean\\(\\)', '', colnames(output))
colnames(output) <- gsub('--', '-', colnames(output))
colnames(output) <- gsub('-$', '', colnames(output))
colnames(output) <- gsub('^t', 'mean-t', colnames(output))
colnames(output) <- gsub('^f', 'mean-f', colnames(output))
# output data
write.table(output, 'output.txt', quote=F, row.names=F, sep='\t')

