# GETTING AND CLEANING COURSE PROJECT

# 1. Merges the training and the test sets to create one data set.

# 1.a Read the separated "test" tables and assign them to specific objects
testX = read.table("UCI HAR Dataset/test/X_test.txt")
testY = read.table("UCI HAR Dataset/test/y_test.txt")
testSub = read.table("UCI HAR Dataset/test/subject_test.txt")

# 1.b Merge all the "test" tables into one, test
test = cbind(testX, testY, testSub)

# 1.c Read the separated "train" tables and assign them to specific objects
trainX = read.table("UCI HAR Dataset/train/X_train.txt")
trainY = read.table("UCI HAR Dataset/train/y_train.txt")
trainSub = read.table("UCI HAR Dataset/train/subject_train.txt")

# 1.d Merge all the "train" tables into one, train
train = cbind(trainX, trainY, trainSub)

# 1.e Merge the train and test tables together, data
data = rbind(train, test)

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# 2. Extracts only the measurements on the mean and standard deviation for each
# measurement.

# 2.a Read the "features" dataset and set stringsAsFactors to "FALSE"
features <- read.table("UCI HAR Dataset/features.txt", 
                       stringsAsFactors = FALSE)

# 2.b Isolate the mean and standard deviation variable name for each 
# measurements, which is found in the second column (features[, "V2"]) of the 
# features dataset. Next, assign the selected values to meanstd
meanstd = grep("mean\\(\\)|std\\(\\)", 
               features[, "V2"])

# 2.d Subset the values from data to get only the mean and standard deviation
# values.
data = data[meanstd]

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Steps 3-4 will be mixed into one step

# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names 

# 3.a Create a separate data frame for "activity" and "subject", this will be 
# useful later on
testsubact = cbind(y_test, subject_test)
trainsubact = cbind(y_train, subject_train)
subact = rbind(trainsubact, testsubact)
colnames(subact) = c("activity", "subject")

# 3.b Create the variable names for the measurements

# 3.b.i Assign to "var" the subset of all the names of the measurements
var <- features[, "V2"]

# 3.b.ii Assign to "variablenames" the subset of all the names of the mean and 
# standard deviation measurements
variablenames <- var[meanstd]

# 3.c Rename all the variables names using the gsub() so that they will be 
# readable
variablenames <- gsub("\\(\\)", "", variablenames)
variablenames <- gsub("Acc", "-acceleration", variablenames)
variablenames <- gsub("Mag", "-Magnitude", variablenames)
variablenames <- gsub("^t(.*)$", "\\1-time", variablenames)
variablenames <- gsub("^f(.*)$", "\\1-frequency", variablenames)
variablenames <- gsub("(Jerk|Gyro)", "-\\1", variablenames)
variablenames <- gsub("BodyBody", "Body", variablenames)
variablenames <- tolower(variablenames)

# 4.a Apply to the measurements the appropriate variable names
colnames(data) <- variablenames

# 4.b cbind the "subact" which contains values for "activity" and "subject" with
# the data. Assign to "data2"
data2 = cbind(subact, data)

# 4.c Read the "activity_labels" dataset which contains the labels for the 
# activities
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                             stringsAsFactors = FALSE)

# 4.d Change the activity label names from uppercase into lowercase
activity_labels$V2 <- tolower(activity_labels$V2)

# 4.e Merge "data2", which has the measurements, with the "activity_labels"
data3 <- merge(data2, 
                     activity_labels, 
                     by.x = "activity", by.y = "V1")

# 4.f Transfer the values in the column "V2" to column "activity" so that the 
# the activity labels will be aligned with their assigned number
data3$activity <- data3$V2

# 4.g Delete the now empty "V2" column from the "data3" dataset
data3$V2 <- NULL

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# 5.a Load the "reshape2" package
library(reshape2)

# 5.b Melt "data3" using activity and subject as the IDs
data3.melt <- melt(data3, id=c("activity", "subject"))

# 5.c Cast "data3" using mean as aggregator function
data3.cast <- dcast(data3.melt, subject + activity ~ variable, mean)

# 5.d Save the tidy dataset as "tidydata.txt" with row.names as FALSE
write.table(data.cast, file = "./tidydata.txt", row.names = FALSE)

