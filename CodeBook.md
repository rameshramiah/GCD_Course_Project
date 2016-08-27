**Getting and Cleaning Data Course Project**
================

**Overview**
------------

This codebook provides additional information about the source data, transformations and variables used for this project.

**Source Data**
---------------

A full description of the data used in this project can be found at [The UCI Machine Learning Repository.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The source data can be fond on this [link.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

**Dataset Information**
-----------------------

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the experiment captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### *Signals*

The 3-axial time domain signals from accelerometer and gyroscope were captured at a constant rate of 50 Hz. Then they were filtered to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another filter. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. Finally a Fast Fourier Transform (FFT) was applied to some of these time domain signals to obtain frequency domain signals.

The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window at 50 Hz). From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The set of variables that were estimated from these signals are,

-   mean(): Mean value
-   std(): Standard deviation
-   mad(): Median absolute deviation
-   max(): Largest value in array
-   min(): Smallest value in array
-   sma(): Signal magnitude area
-   energy(): Energy measure. Sum of the squares divided by the number of values.
-   iqr(): Interquartile range
-   entropy(): Signal entropy
-   arCoeff(): Autoregression coefficients with Burg order equal to 4
-   correlation(): Correlation coefficient between two signals
-   maxInds(): Index of the frequency component with largest magnitude
-   meanFreq(): Weighted average of the frequency components to obtain a mean frequency
-   skewness(): Skewness of the frequency domain signal
-   kurtosis(): Kurtosis of the frequency domain signal
-   bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
-   angle(): Angle between some vectors.

**Files in the UCI HAR Dataset**
--------------------------------

The dataset includes the following files,

-   'README.txt'
-   'features\_info.txt': Shows information about the variables used on the feature vector.
-   'features.txt': List of all features.
-   'activity\_labels.txt': Links the class labels with their activity name.
-   'subject\_train.txt': Subject who performed the activity.
-   'X\_train.txt': Training set.
-   'y\_train.txt': Training labels.
-   'subject\_test.txt': Subject who performed the activity.
-   'X\_test.txt': Test set.
-   'y\_test.txt': Test labels.

The following files in the Inertial Signals folders are available for the train and test data. Their descriptions are the same for both,

-   'train/Inertial Signals/total acc x train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total acc x train.txt' and 'total acc z train.txt' files for the Y and Z axis.
-   'train/Inertial Signals/body acc x train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
-   'train/Inertial Signals/body gyro x train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

**For the purposes of this project, the files in the Inertial Signals folders are not used.**

**Data transformation**
-----------------------

The raw data sets are processed with run\_analisys.R script to create a tidy data set

### *Merge training and test sets*

Test and training data (X train.txt, X test.txt), subject ids (subject train.txt, subject test.txt) and activity ids (y train.txt, y test.txt) are merged to obtain a single data set. Variables are labelled with the names assigned by original collectors (features.txt).

### *Extract mean and standard deviation variables*

From the merged data set is extracted and intermediate data set with **only** the values of estimated **mean** (variables with labels that contain "mean") and **standard deviation** (variables with labels that contain "std").

### *Use descriptive activity names*

A new column is added to intermediate data set with the activity description. Activity id column is used to look up descriptions in activity\_labels.txt.

### *Label variables appropriately*

Labels given from the original collectors were changed: to obtain valid R names without parentheses, dashes and commas to obtain more descriptive labels.

### *Create a tidy data set*

From the intermediate data set is created a final tidy data set where numeric variables are averaged for each activity and each subject.

The tidy data set contains 180 observations with 21 variables divided in,

-   an identifier of the subject who carried out the experiment (Subject): 1 to 30
-   an activity label (Activity): WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING
-   an activity ID for the Activity label: 1-WALKING, 2-WALKING UPSTAIRS, 3-WALKING DOWNSTAIRS, 4-SITTING, 5-STANDING, 6-LAYING
-   18 features vector with time and domain signal variables (numeric).

For variables derived from mean and standard deviation estimation, the previous labels are augmented with the terms "Mean" or "StandardDeviation".

The data set is written to the file tidy\_data.txt.
