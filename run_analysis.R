## 1 - Merge the training and the test sets to create one data set.

# download zip-file

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "data.zip", method = "curl")

# open zip-file

unzip("data.zip")
file.remove("data.zip")

## loading data
# train

trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainLabels <- read.table("./UCI HAR Dataset/train/y_train.txt")

# test

testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Reading features data and activity labels

features <- read.table("./UCI HAR Dataset/features.txt")
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merging into single data table using cbind and rbind. 

train <- cbind(trainSubject, trainSet, trainLabels)
test <- cbind(testSubject, testSet, testLabels)
merged <- rbind(train, test)

## 2 - Extract only the measurements on the mean and standard deviation 
## for each measurement. 

colnames(merged) <- c("subject", features[, 2], "activity")

# Find the right measurements

meanstd <- grepl("subject|activity|mean|std", colnames(merged))

# Save the selected columns

merged <- merged[, meanstd]

## 3 - Uses descriptive activity names to name the activities in the data set

merged$activity <- factor(merged$activity, levels = activity[, 1], labels = activity[, 2])

## 4 - Appropriately labels the data set with descriptive variable names. 

# Find column names

mergednames <- colnames(merged)

# Clean up names 

mergednames <- gsub("[\\(\\)-]", "", mergednames) #removes -,( and ) 
mergednames <- gsub("^f", "frequency", mergednames) #clarify abbreviation
mergednames <- gsub("^t", "time", mergednames) #clarify abbreviation
mergednames <- gsub("Acc", "accelerometer", mergednames) #clarify abbreviation
mergednames <- gsub("std", "standarddeviation", mergednames) #clarify abbreviation
mergednames <- gsub("Mag", "magnitude", mergednames) #clarify abbreviation
mergednames <- gsub("Gyro", "gyroscope", mergednames)
mergednames <- gsub("BodyBody", "body", mergednames)
mergednames <- tolower(mergednames)

colnames(merged) <- mergednames # use new colnames

## 5 From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

tidy <- merged %>% group_by(subject, activity) %>% summarise_all(mean)

write.table(tidy, "tidy.txt", row.names = FALSE, quote = FALSE)
