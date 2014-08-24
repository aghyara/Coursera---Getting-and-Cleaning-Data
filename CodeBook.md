### Getting and Cleaning Data Course Project

A code book file that describes the variables, the data, and any transformations or work that I have performed to clean up the data

* The data for the project has been obtained from the below link

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* A full description is available at the below site where the data was obtained

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

* The downloaded data is saved in the folder "UCI HAR Dataset", relative to the script file
* run_analysis.R file contains the script to clean the data. 
* Description of the Steps performed in the run_analysis.R file
    
    1) Read training data files first from Train folder into the following variables
        dtTrain - train/X_train.txt
        dtTrainLabel - train/y_train.txt
        dttrainSub - train/subject_train.txt
        
    2) Read test data files from the Test folder into the following variables
        dtTest - test/X_test.txt
        dtTestLabel - test/y_test.txt
        
        
    3) Read the Subjects text file into 
        dtTestSubject - test/subject_test.txt
        
    4) Merge the training and the test sets to create one data set.
        - Combine the training and test data into variable "mergeData"
        - Combine the training and test labels into variable "mergeLabel"
        - Combine the training and test Subjects into variable "mergeSubjects"

    5) Read the features data into variable "dtFeatures" and get the indices of all the rows that contain measurement for mean and standard deviation.
       The list of Indices is stored in variable "IndMeanStd". We use this variable to get the subset of mergeData containing only the columns present in the "IndMeanStd".  

    6) Clean the column names to improve readability, by removing brackets "()", making first letter capital for "Mean" and "Std"
    
    7) Read activitity data files, containing descriptive activity names to name the activities in the data set into the following variables
        dtActivity - /activity_labels.txt
    
    8) Clean the activity names present in the 2nd column of "dtActivity" by removing underscores and capitalizing the first letter with the rest lower case
    
    9) Update the values in "mergeLabels" with the actual activite names from dtActivity.
    
    10) Combine the datasets "mergeSubject", "mergeLabel", "mergeData" into variable "dtCleaned". The first column contains the Subject integers (1 to 30), the 2nd column the 6 types of Activity names, the remaining 66 columns are the measurements.
    
    11) Write this "dtCleaned" dataset into a file "mergeddata.txt"
    
    12) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. For each combination of unique subjects (30) and activities (6), we calculte the average of each measurement
    
    13) Write this final dataset "matrixResult" into file "txtdataAvg.txt" in the current working directory
     