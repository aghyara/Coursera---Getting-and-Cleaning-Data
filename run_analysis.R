# 1. Merges the training and the test sets to create one data set.

#setwd("\\Course Project")

dtTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
#head(dtTrain)
dtTrainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
#table(dtTrainLabel)
dttrainSub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
dtTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
dtTestLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
#table(dtTestLabel)
dtTestSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

mergeData <- rbind(dtTrain, dtTest)
mergeLabel <- rbind(dtTrainLabel, dtTestLabel)
mergeSubject <- rbind(dttrainSub, dtTestSubject)

# 2. Extracts only the measurements on the mean and standard
# deviation for each measurement.
dtFeatures <- read.table("./UCI HAR Dataset/features.txt")
IndMeanStd <- grep("mean\\(\\)|std\\(\\)", dtFeatures[, 2])
length(IndMeanStd) # 66
mergeData <- mergeData[, IndMeanStd]
# remove brackets "()"
names(mergeData) <- gsub("\\(\\)", "", dtFeatures[IndMeanStd, 2]) 
# Capitalize M for readability
names(mergeData) <- gsub("mean", "Mean", names(mergeData))
# Capitalize S  for readability
names(mergeData) <- gsub("std", "Std", names(mergeData)) 

# 3. Uses descriptive activity names to name the activities in the data set

dtActivity <- read.table("./UCI HAR Dataset/activity_labels.txt")
dtActivity[, 2] <- tolower(gsub("_", "", dtActivity[, 2]))
substr(dtActivity[2, 2], 8, 8) <- toupper(substr(dtActivity[2, 2], 8, 8))
substr(dtActivity[3, 2], 8, 8) <- toupper(substr(dtActivity[3, 2], 8, 8))
dtActMrgLabel <- dtActivity[mergeLabel[, 1], 2]
mergeLabel[, 1] <- dtActMrgLabel
names(mergeLabel) <- "dtActivity"

# 4. Appropriately labels the data set with descriptive activity names.
names(mergeSubject) <- "subject"
dtCleaned <- cbind(mergeSubject, mergeLabel, mergeData)
#write.table(dtCleaned, "mergeddata.txt")

# Creates a second, independent tidy data set with the average of
# each variable for each activity and each subject.
SubLen <- length(table(mergeSubject))
ActLen <- dim(dtActivity)[1]
ColmLen <- dim(dtCleaned)[2]
matrixResult <- matrix(NA, nrow=SubLen*ActLen, ncol=ColmLen)
matrixResult <- as.data.frame(matrixResult)
colnames(matrixResult) <- colnames(dtCleaned)
row <- 1

for(i in 1:SubLen) {
    for(j in 1:ActLen) {
        matrixResult[row, 1] <- sort(unique(mergeSubject)[, 1])[i]
        matrixResult[row, 2] <- dtActivity[j, 2]
        bool1 <- i == dtCleaned$subject
        bool2 <- dtActivity[j, 2] == dtCleaned$dtActivity
        matrixResult[row, 3:ColmLen] <- colMeans(dtCleaned[bool1&bool2, 3:ColmLen])
        row <- row + 1
    }
}

head(matrixResult)
# write out the independent tidy data set with the 
# average of each variable for each activity and each subject
write.table(matrixResult, "txtdataAvg.txt", row.names=FALSE)
