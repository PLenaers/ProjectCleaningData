# This function cleans up 2 datasets holding information on accelerometers from smartphones.

# Load the dplyr library
library(dplyr)

# First the training and testing data is read
mydf1 <- read.table("X_test.txt", stringsAsFactors=FALSE)
mydf2 <- read.table("y_test.txt", stringsAsFactors=FALSE)
mydf3 <- read.table("subject_test.txt", stringsAsFactors=FALSE)
mydf4 <- read.table("X_train.txt", stringsAsFactors=FALSE)
mydf5 <- read.table("y_train.txt", stringsAsFactors=FALSE)
mydf6 <- read.table("subject_train.txt", stringsAsFactors=FALSE)
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

# Ex. 2 Extract the mean and standard deviation
means <- colMeans(myData[1:561])
sds <- sapply(myData[1:561], sd)

# Ex.3 Use descriptive activitiy names
activities <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
Subjects <- rbind(testSubject, trainingSubject, all=TRUE)
Labels <- rbind(testLabels, trainingLabels, all=TRUE)
Labels$V1 <- ordered(Labels$V1, levels = 1:6, labels = activities$V2)
myData <- cbind(myData, Subjects, Labels)
# mergedData <- tbl_df(mergedData)

# Ex. 4 Label with descriptive variable names
features <- read.table("features.txt", stringsAsFactors=FALSE)
names(myData) <- c(features$V2, "Subject", "Activity")
# Remove duplicate columns
myData <- myData[!duplicated(lapply(myData,summary))]
names(myData) <- make.names(names(myData), unique=TRUE)

# Ex. 5 Create a tidy data set with the average for each variable for eachactivity and subject
byActSubj <- group_by(myData, Activity, Subject)
tidyData <- summarise_each(byActSubj, funs(mean))
write.table(tidyData, file = "tidyData.txt", row.name=FALSE)
