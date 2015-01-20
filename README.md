# ProjectCleaningData
The run_analysis.R script shows how to collect, work with, and clean a dataset.

## Reading libraries
First some libraries are loaded.

## Load the data
Then the data is loaded in and converted to tables that dplyr can work with.

The databases are then merged into one big database.
Consequently the mean and standard deviation of the experiments are calculated.
In the third part, the numeric values describing the type of activity are changed into actual descriptions as defined in activity_labels.txt.
In ex.4, the variable names are changed according to the labels in features.txt. Originally these hold some non-allowed characters so the function make.names has to be called to clean this up.
Lastly, the data is grouped by activity and subject, and the mean for each if the variables in each of these groups is calculated
