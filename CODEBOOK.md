# CODEBOOK for UCI HAR Dataset
***
## Data Information
>The experiments have been carried out with a group of 30 volunteers within an 
>age bracket of 19-48 years. Each person performed six activities (WALKING, 
>WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
>smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
>and gyroscope, we captured 3-axial linear acceleration and 3-axial angular 
>velocity at a constant rate of 50Hz. The experiments have been video-recorded 
>to label the data manually. The obtained dataset has been randomly partitioned 
>into two sets, where 70% of the volunteers was selected for generating the 
>training data and 30% the test data.
        

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying 
>noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 
>50% overlap (128 readings/window). The sensor acceleration signal, which has 
>gravitational and body motion components, was separated using a Butterworth 
>low-pass filter into body acceleration and gravity. The gravitational force is 
>assumed to have only low frequency components, therefore a filter with 0.3 Hz 
>cutoff frequency was used. From each window, a vector of features was obtained 
>by calculating variables from the time and frequency domain.

**Source:** [Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

***
## Downloading the dataset
The data can be retrieved from the UCI [website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) or downloaded directly through this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) provided by Coursera. Load the dataset using RStudio.

Alternatively, you can also use the `download.file()` function to download the zip file.

***
## Merging the datasets into one
First, all the text files inside both the train and test folder are read using the `read.table()`

Second, the all the "test" text files are merged into one, the same goes with the "train" files.

Finally, train and test will be merged into one dataset, **data**

***
## Isolating the measurement variable names from `features.txt`
Read `features.txt` using `read.table()` and set `stringsAsFactors = FALSE`. Isolate the mean and standard deviation variable name for each measurements, which is found in the second column of the features dataset. Next, assign the selected values to **meanstd**. Subset the values from **data** to get only the mean and standard deviation values.

***
## Assigning of variable names to the measurements, activity and subject
Create a separate data frame for "activity" and "subject", this will be useful later on.

Extract the variable names for the measurements. Assign to **var** the subset of all the names of the measurements from the features dataset. Assign to **variablenames** the subset of all the names of the mean and standard deviation measurements.

Rename all the measurement variables names using the `gsub()` so that they will be readable.

Apply to the measurements the appropriate variable names. Bind the separate dataset which contains values for "activity" and "subject" with the **data**. Assign to **data**"

Read the `activity_labels.txt` dataset which contains the labels for the activities and set `stringsAsFactors = FALSE`. Change the activity label names from uppercase into lowercase.

**data2**, which has the measurements, with the **activity_labels**. Transfer the values in the column "V2" to column "activity" so that the the activity labels will be aligned with their id number. Assign to **data3**. Delete the now empty "V2" column from the **data3** dataset

***
## Reshaping to tidy data
Load the "reshape2" package. Melt (`melt()`) **data3** using activity and subject as the ids. Cast (`dcast()`) **data3** using mean as the aggregator function. Save the tidy dataset as `tidydata.txt` using `write.table()` with `row.names=FALSE`

***
## Mean and Standard Deviation Variable Name Transformation (Clean Up)
`variablenames <- gsub("\\(\\)", "", variablenames)`
`variablenames <- gsub("Acc", "-acceleration", variablenames)`
`variablenames <- gsub("Mag", "-Magnitude", variablenames)`
`variablenames <- gsub("^t(.*)$", "\\1-time", variablenames)`
`variablenames <- gsub("^f(.*)$", "\\1-frequency", variablenames)`
`variablenames <- gsub("(Jerk|Gyro)", "-\\1", variablenames)`
`variablenames <- gsub("BodyBody", "Body", variablenames)`

This code cleans the default names for the measurement variables found inside the `features.txt`

`variablenames <- tolower(variablenames)`

Turns all the names into lowercase

***
## Activity Labels Transformation (Clean Up)
`activity_labels$V2 <- tolower(activity_labels$V2)`

Turns all six (6) of the activity labels into lowercase

***
## Variables
The following are the 68 variables found in the final dataset, `tidydata.txt`:

* subject

        Thirty 30 subjects `[1-30]` were involved in the study. All the subjects were made to perform six (6) kinds of activities

* activity

        Six (6) kinds of activities performed by the the subjects, namely: `laying, sitting, standing, walking, walking_downstairs, walking_upstairs`

* body-acceleration-jerk-magnitude-mean-frequency
* body-acceleration-jerk-magnitude-mean-time
* body-acceleration-jerk-magnitude-std-frequency
* body-acceleration-jerk-magnitude-std-time
* body-acceleration-jerk-mean-x-frequency
* body-acceleration-jerk-mean-x-time
* body-acceleration-jerk-mean-y-frequency
* body-acceleration-jerk-mean-y-time
* body-acceleration-jerk-mean-z-frequency
* body-acceleration-jerk-mean-z-time
* body-acceleration-jerk-std-x-frequency
* body-acceleration-jerk-std-x-time 
* body-acceleration-jerk-std-y-frequency
* body-acceleration-jerk-std-y-time
* body-acceleration-jerk-std-z-frequency
* body-acceleration-jerk-std-z-time
* body-acceleration-magnitude-mean-frequency
* body-acceleration-magnitude-mean-time
* body-acceleration-magnitude-std-frequency
* body-acceleration-magnitude-std-time
* body-acceleration-mean-x-frequency
* body-acceleration-mean-x-time
* body-acceleration-mean-y-frequency
* body-acceleration-mean-y-time
* body-acceleration-mean-z-frequency
* body-acceleration-mean-z-time
* body-acceleration-std-x-frequency
* body-acceleration-std-x-time
* body-acceleration-std-y-frequency
* body-acceleration-std-y-time
* body-acceleration-std-z-frequency
* body-acceleration-std-z-time
* body-gyro-jerk-magnitude-mean-frequency
* body-gyro-jerk-magnitude-mean-time
* body-gyro-jerk-magnitude-std-frequency
* body-gyro-jerk-magnitude-std-time
* body-gyro-jerk-mean-x-time
* body-gyro-jerk-mean-y-time
* body-gyro-jerk-mean-z-time
* body-gyro-jerk-std-x-time
* body-gyro-jerk-std-y-time
* body-gyro-jerk-std-z-time
* body-gyro-magnitude-mean-frequency
* body-gyro-magnitude-mean-time
* body-gyro-magnitude-std-frequency
* body-gyro-magnitude-std-time
* body-gyro-mean-x-frequency
* body-gyro-mean-x-time
* body-gyro-mean-y-frequency
* body-gyro-mean-y-time
* body-gyro-mean-z-frequency
* body-gyro-mean-z-time
* body-gyro-std-x-frequency
* body-gyro-std-x-time
* body-gyro-std-y-frequency
* body-gyro-std-y-time
* body-gyro-std-z-frequency
* body-gyro-std-z-time
* gravity-acceleration-magnitude-mean-time
* gravity-acceleration-magnitude-std-time
* gravity-acceleration-mean-x-time
* gravity-acceleration-mean-y-time
* gravity-acceleration-mean-z-time
* gravity-acceleration-std-x-time
* gravity-acceleration-std-y-time
* gravity-acceleration-std-z-time

        All 66 of these variables were measured for each activity performed by a subject. Means for each variable were calculated.

***
## Creation of the tidy dataset
The final dataset, `tidydata.txt`, can now be considered a "tidy data" because (1) each variable (subject, activity, body-acceleration-jerk-magnitude-mean-frequency, etc.) has its own column, (2) each observation (i.e subjects) forms a row, and (3) it is only one observation, the human activity recognition of Samsung Galaxy II.

***







