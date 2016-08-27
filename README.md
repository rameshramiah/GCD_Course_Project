## Overview
This project serves to demonstrate the collection and cleaning of a tidy data set that can be used for subsequent analysis. A full description of the data used in this project can be found at [The UCI Machine Learning Repository.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The source data for this project can be found [here.] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## What you find in this repository
1. CodeBook.md: describes the source data, datasets, variables and any transformations or work that was performed to clean up the data
2. README.md: this file, which describes the project, repository, and R script.
3. run_analysis.R: R script to transform raw data set in a tidy dataset.
4. tidy_data.txt: tidy data set with the average of each variable for each activity and each subject

## How to create the tidy data set?
1. Clone this repository
2. Download compressed raw data
3. Unzip raw data and copy the directory UCI HAR Dataset to the R working directory
4. Open a R console and open the run_analisys script from the cloned repository
5. Then source run_analysis.R to run the script.
6. The tidy data will be saved in a text file called tidy_data.txt in the working directory

## How the run_analysis script works?
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names.
5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Additional Information
You can find additional information about the variables, data and transformations in the CodeBook.MD file.
