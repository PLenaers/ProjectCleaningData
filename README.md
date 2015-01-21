# ProjectCleaningData
The run_analysis.R script shows how to collect, work with, and clean a dataset.

## Reading libraries
First some libraries are loaded.

## Load the data
Then the data is loaded in and converted to tables that dplyr can work with.

## Ex.1 Merging
The databases are then merged into one big database.

## Ex.2 Calculate mean and standard deviation
Consequently the mean and standard deviation of the experiments are calculated.

## Ex. 3 Use descriptive names
The numeric values describing the type of activity are changed into actual descriptions as defined in activity_labels.txt.

## Ex. 4 Change variable names
The variable names are changed according to the labels in features.txt. There are duplicate entries indicating that there are duplicate columns. These are removed. The names also hold some non-allowed characters so the function make.names has to be called to clean this up.

## Ex. 5 Create a tidy dataset
Lastly, the data is grouped by activity and subject, and the mean for each if the variables in each of these groups is calculated with the function summarise_each. Lastly the dataset is written to file.
