{
    
# Download the UCI HAR Dataset from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Extract UCI HAR Dataset directory to your working directory.
    
    # Clean up workspace
    rm(list=ls())
    
    # Load the required packages
    library(plyr)
    library(data.table)
    
    # 1. Merge the training and the test sets to create one data set.
    
    # Read the train data
    subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
    x_train <- read.table('./UCI HAR Dataset/train/x_train.txt')
    y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
    
    # Read the test data
    subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
    x_test <- read.table('./UCI HAR Dataset/test/x_test.txt')
    y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
    
    # Read the activities and features data
    features <- read.table('./UCI HAR Dataset/features.txt')
    activity_type <- read.table('./UCI HAR Dataset/activity_labels.txt')
    
    # Assign column names to train and activities data
    colnames(subject_train) <- "subjectId"
    colnames(x_train) <- features[,2] 
    colnames(y_train) <- "activityId"
    colnames(activity_type) <- c('activityId','activityType')
    
    # Assign column names to the test data
    colnames(subject_test) <- "subjectId"
    colnames(x_test) <- features[,2]
    colnames(y_test) <- "activityId"
    
    # Create the complete training dataset by merging x_train, y_train and 
    # subject_train
    training_data <- cbind(x_train, y_train, subject_train)
    
    # Create complete test dataset by merging the x_test, y_test and 
    # subject_test
    test_data <- cbind(x_test, y_test, subject_test)
    
    # Combine training and test dataset to create a overall dataset
    all_data <- rbind(training_data,test_data)
    
    
    # 2. Extract only the measurements on the mean and standard deviation 
    #    for each measurement. 
    
    # Create a vector for the column names from all_data, which will be used
    # to select the desired mean and standard deviation columns
    col_names <- colnames(all_data)
    
    # Create a logicalVector that contains TRUE values for the ID, mean & 
    # standard deviation columns and FALSE for others
    id_mean_stddev <- (grepl("activity..",col_names) |
                       grepl("subject..",col_names) |
                       grepl("-mean..",col_names) &
                       !grepl("-meanFreq..",col_names) &
                       !grepl("mean..-",col_names) |
                       grepl("-std..",col_names) &
                       !grepl("-std()..-",col_names));
    
    # Subset overall table (all_data) based on the logicalVector to keep only
    # desired columns
    all_data <- all_data[id_mean_stddev==TRUE];
    
    # 3. Use descriptive activity names to name the activities in the data set
    
    # Merge the overall dataset (all_data) with the acitivityType table to 
    # include descriptive activity names
    all_data <- merge(all_data, activity_type, by = 'activityId', all.x = TRUE)
    
    # Updating the col_names vector to include the new column names after merge
    col_names <- colnames(all_data)
    
    # 4. Appropriately label the data set with descriptive activity names. 
    
    # Cleaning up the variable names
    
    for (i in 1:length(col_names))
    {
        col_names[i] <- gsub("\\()" ,"" , col_names[i])
        col_names[i] <- gsub("-std$","StdDev", col_names[i])
        col_names[i] <- gsub("-mean","Mean", col_names[i])
        col_names[i] <- gsub("^(t)","time",col_names[i])
        col_names[i] <- gsub("^(f)","freq",col_names[i])
        col_names[i] <- gsub("([Gg]ravity)","Gravity",col_names[i])
        col_names[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",col_names[i])
        col_names[i] <- gsub("[Gg]yro","Gyro",col_names[i])
        col_names[i] <- gsub("AccMag","AccMagnitude",col_names[i])
        col_names[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",col_names[i])
        col_names[i] <- gsub("JerkMag","JerkMagnitude",col_names[i])
        col_names[i] <- gsub("GyroMag","GyroMagnitude",col_names[i])
    }
    
    # Reassigning the new descriptive column names to the overall 
    # dataset (all_data)
    colnames(all_data) <- col_names
    
    # 5. Create a second, independent tidy data set with the average of each 
    #    variable for each activity and each subject. 
    
    # Create a new table, without the activityType column
    all_dataNAT <- all_data[,names(all_data) != 'activityType']
    
    # Summarizing the all_dataNAT table to include just the mean of
    # each variable for each activity and each subject
    tidy_data <- aggregate(all_dataNAT[,names(all_dataNAT) 
                                       != c('activityId','subjectId')],
                           by=list(activityId=all_dataNAT$activityId,
                                   subjectId = all_dataNAT$subjectId),mean)
    
    # Merging the tidy_data with activity_type to include descriptive 
    # acitvity names
    tidy_data <- merge(activity_type,tidy_data, by='activityId',all.x=TRUE)
    
    # Rearrange the column order starting with subjectId followed by 
    # activityType, activityId and the rest
    tidy_data <- setcolorder(tidy_data, c(3, 2, 1, 4:21))
    
    # Sort tidy_data by subjectId
    tidy_data <- arrange(tidy_data, subjectId)
    
    # write tidy_data to a text file on disk
    write.table(tidy_data, './tidy_data.txt',row.names=FALSE);
    

}