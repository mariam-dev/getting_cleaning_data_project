---
title: "README"
output: html_document
---
****

# Files in this directory
* README
* CodeBook.md
* run_analysis.R
* tidyset.txt


## Project objectives and description
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

## About the data used

The data presents data from experiments carried out with a group of 30 volunteers where each person performed six activities wearing a smartphone on the waist. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

[Data used link](<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>)

****

## How the script works

run_analysis.R is a script that performs the following actions:
  
  1. Merges the training and the test sets to create one data set.
  2.  Extracts only the measurements on the mean and standard deviation for each measurement.
  3.  Uses descriptive activity names to name the activities in the data set
  4.  Appropriately labels the data set with descriptive variable names.
  5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  

### Line by line explanation

Lines 1-45 deal with downloading the data from the link and reading the different files into different tables.

Lines 56 - 58 show the Merge of the training and the test sets to create one data set. 
```{r}
actSet <- rbind(testSet, trainSet)
actSet <- cbind(actSet, x_data)
```
Lines 50 - 54  Extract only the measurements on the mean and standard deviation for each measurement and format the data using the names of the lables in the file "features.txt"
```{r}
columnNumbers <- grepl("-(std|mean).*", as.character(features[,2]))
filtercolNames<- features[columnNumbers,2]
filtercolNames <- gsub("-mean", "Mean", filtercolNames)
filtercolNames <- gsub("-std", "Std", filtercolNames)
filtercolNames <- gsub("[-()]", "", filtercolNames)
```
Line 74 sets the  descriptive activity names to name the activities in the data set
```{r}
actSet$activity <- activities[actSet$activity,2]
```

Finally, lines 56 - 84 show how a second, independent tidy data set is created, with the average of each variable for each activity and each subject. The output set is written in a text file without the column names.

****

## Tidy data criteria 
- Each variable forms a column
- Each observation forms a row
- Each observational unit forms a table

For this data, the following criteria was also considered:
- Each subject is identified with an ID
- Each activity is listed using categorical data as described on "activities.txt"
- The tidyset file does not include titles

## References used

1. [Tidy data Paper](<http://www.stat.wvu.edu/~jharner/courses/stat623/docs/tidy-dataJSS.pdf>)
2. [Tidyr infromation from CRAN](<https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html>)
3. [Data Sharing](<https://github.com/jtleek/datasharing>)
4. [Additional information about Human Activity Recognition](<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>)
5. [Project Tips](<https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/>)


