# This function cleans up 2 datasets holding information on accelerometers from smartphones.

# Load the dplyr library
library(plyr)
library(dplyr)

# First the training and testing data is read
mydf1 <- read.table("X_test.txt")
mydf2 <- read.table("y_test.txt")
mydf3 <- read.table("subject_test.txt")
mydf4 <- read.table("X_train.txt")
mydf5 <- read.table("y_train.txt")
mydf6 <- read.table("subject_train.txt")
# Transfer into dataframes such that the dplyr package works correctly
testData <- tbl_df(mydf1)
testLabels <- tbl_df(mydf2)
testSubject <- tbl_df(mydf3)
trainingData <- tbl_df(mydf4)
trainingLabels <- tbl_df(mydf5)
trainingSubject <- tbl_df(mydf6)
# Remove the original files from memory
rm("mydf1","mydf2","mydf3","mydf4","mydf5","mydf6")

# Ex. 1 Merge the datasets
myData <- rbind(testData, trainingData, all=TRUE)
mergedData <- tbl_df(myData)
rm("myData")

# Ex. 2 Extract the mean and standard deviation
means <- colMeans(mergedData[1:561])
sds <- sapply(mergedData[1:561], sd)

# Ex.3 Use descriptive activitiy names
activities <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
Subjects <- rbind(testSubject, trainingSubject, all=TRUE)
Labels <- rbind(testLabels, trainingLabels, all=TRUE)
Labels$V1 <- ordered(Labels$V1, levels = 1:6, labels = activities$V2)
mergedData <- cbind(mergedData, Subjects, Labels)
mergedData <- tbl_df(mergedData)

# Ex. 4 Label with descriptive variable names
features <- read.table("features.txt", stringsAsFactors=FALSE)
features$V2 <- make.names(features$V2, unique=TRUE)
names(mergedData) <- c(features$V2, "Subject", "Activity")

# Ex. 5 Create a tidy data set with the average for each variable for eachactivity and subject
# grouping <- group_by(mergedData, Activity, Subject)
# summarize(grouping, mean(names(tBodyAcc.mean...X:angle.Z.gravityMean.))
tidySet <- tbl_df(ddply(mergedData, .(Activity, Subject), numcolwise(mean)))
write.table(tidySet, file = "tidySet.txt", row.name=FALSE)