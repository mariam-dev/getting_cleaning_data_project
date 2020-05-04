
# The following R script called run_analysis.R should do the following.
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

#Start with setting where the files are located
if(!file.exists("./data")){dir.create("./data")}

#Set the URLs
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "./data/project4data.zip"

#download and unzip the downloaded files
if (!file.exists(filename)){
  download.file(dataUrl, filename, method="curl")
  unzip(filename, exdir="./data")
}  

###############################################################################
# 1 and 2. Merge training and Test sets and extract mean and std dev
# 3 Use descriptive names for activities
# 4. Use appropriate lables
##############################################################################

#Training information
set_train <- read.table("./data/project4data/UCI HAR Dataset/train/X_train.txt")
labels_train <- read.table("./data/project4data/UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("./data/project4data/UCI HAR Dataset/train/subject_train.txt")

#Test information
set_test <- read.table("./data/project4data/UCI HAR Dataset/test/X_test.txt")
labels_test <- read.table("./data/project4data/UCI HAR Dataset/test/y_test.txt")
sub_test <-read.table("./data/project4data/UCI HAR Dataset/test/subject_test.txt")

#Features
features <- read.table("./data/project4data/UCI HAR Dataset/features.txt")

#Activities
activities <- read.table("./data/project4data/UCI HAR Dataset/activity_labels.txt")


#  Create a subset that has: activities, subject mean and std dev.
#  Substract only measurements for mean and standard deviation, not angles.
columnNumbers <- grepl("-(std|mean).*", as.character(features[,2]))
filtercolNames<- features[columnNumbers,2]
filtercolNames <- gsub("-mean", "Mean", filtercolNames)
filtercolNames <- gsub("-std", "Std", filtercolNames)
filtercolNames <- gsub("[-()]", "", filtercolNames)

#Extract data we don't want
set_data <- rbind(set_test, set_train)
set_data <- set_data[columnNumbers]

#Combine into train and test sets
testSet <- cbind(sub_test, labels_test)
trainSet <- cbind(sub_train, labels_train)
actSet <- rbind(testSet, trainSet)
actSet <- cbind(actSet, set_data)


#Free some memory
rm(set_train, labels_train, sub_train, set_test, labels_test, sub_test)

#Set column names (#3) Including the appropriate labels for mean and stddev
colnames(actSet)<-c("subjectID", "activity", filtercolNames)

#Change activities to their names
actSet$activity <- activities[actSet$activity,2]


#################################################################################
#5. Create and write tidy data set without the column names
# Each variable forms a column
# Each Observation forms a row
# Each Observational unit forms a table
#################################################################################

write.table(actSet, file = "./data/tidyset.txt", col.names = FALSE)

