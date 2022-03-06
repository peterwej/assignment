Code book - Description of the variables

Features: A 561-feature vector with time and frequency domain variables
Activities: Labels of 6 different activities, walking, walking up
stairs, walking down stairs, sitting, standing, laying. Subject
train/test: An identifier of the subject who carried out the experiment.
X-train/test: Measurement data. Y-train/test: Activity label.

-   The data

train: train test/subject/label merged with cbind. test: test
train/subject/label merged with cbind. merged: train and test merged
into one data set with rbind.

meanstd: find measurements containing mean and std with the grepl
function and assign it to meanstd. merged: choose only the values with
mean and std to create new data set called merged. The value of activity
in the merged data set is replaced with the corresponding activity from
the activities data set.

-   Transformation/work to clean up the data

Cleaned up the columnnames, removed -, (, ), clarified abbriviations and
made them all lowercase using the function gsub().

Created a tidy data set by grouping the merged data set by subject and
activity and then took the mean from all variables.

Exported a tidy data set into a .txt called tidy.txt.using the function
write.table()
