## Getting and Cleaning Data Course Project

This file provides information on how to run this project:

1) Download the zip file from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip". Unzip the folder. The folder extracted will be "UCI HAR Dataset". All the data files will be present in this folder.

2) Confirm that the run_analysis.R script and the folder "UCI HAR Dataset" are in your current working directory.

3) Use source("run_analysis.R") command in RStudio to run the script

4) 2 text files will be created in the current directory.
    * mergeddata.txt file containing the cleaned dataset (10299x68)
    * txtdataAvg.txt file, a second, independent tidy data set with the average of each variable for each activity and each subject

5) Additionally present in the current folder is "CodeBook.md" file containing description of the variables and code.