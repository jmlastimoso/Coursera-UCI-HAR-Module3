# UCI HAR Dataset Clean Up (Module 3 Course Project)
***
## Dataset
First, download the required dataset [zip file] from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), this dataset originated from the [Human Activity Recognition Using Smartphones Data Set of UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

***
## R Script Requirements
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

***
The contents of the zip file are:

* test[**folder**]    
    + Inertial Signal [**folder**]
    + X_test.txt
    + y_test.txt
    + subject_test.txt    
* train[**folder**]    
    + Inertial Signal[**folder**]
    + X_train.txt
    + y_test.txt
    + subject_test.txt
* activity_labels.txt
* features.txt
* feaures_info.txt
* README.txt

***
The **Inertial Signal** folder inside of both the test and train folders are the raw data, therefore they will not be used in tidying this dataset.


`X_test.txt` contains the measurement values for the six tests

`y_test.txt` contains the ids for the six tests

`X_train.txt` contains the measurement values for the six trainings

`y_train.txt` contains the ids for the six trainings

`subject_test/train.txt` are the ids for the thirty correspondents

`activity_labels.txt` contains the labels/variable names for the activities found in `y_test.txt` and `y_train.txt` and also the id number for each.

`features.txt` contains the variable names for the measurements 

`features_info.txt` contains general information about the measurements 

`README.txt` contains general information about the dataset

***
## R Code
The code needed for the analysis of the dataset is called `run_analysis.R` 
After running `run_analysis.R`, the resulting tidy data was saved, `tidydata.txt`. The tidy dataset can be viewed using the read.table()

***
## Codebook
The Codebook can also be accessed in this repository.

***
