## This program creates a tidy data set consisting of a summary of select measurements
## from the raw data (train and test) in the "UCI HAR Dataset". The summary includes the 
## mean of all selected variables for each subject by each activity. The program assumes
## that the "UCI HAR Dataset" folder, containing all required data, is available in the 
## working directory of this program file. If, "UCI HAR Dataset" folder is not availabe
## or if some data is missing, you may uncomment the code in lines 11 to 14 and 
## run this program.

## Code for downloading the data and unzipping - Remove comments for downloading data

# fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
# download.file(fileUrl, "TempData.zip")
# unzip("TempData.zip", overwrite = TRUE)
# unlink("TempData.zip")

## Folder 'UCI HAR Dataset' gets created during unzip. This folder contains data,
## readme files and all other informarion regarding the raw data set.

## Read feature names
featureNames <- read.table("./UCI HAR Dataset/features.txt")
featureNames <- featureNames[,2]

## Read Activity Labes, convert to lower case and remove "_"
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activityLabels <- tolower(activityLabels[,2])
activityLabels <- gsub("_","",activityLabels)
numActivity = length(activityLabels)

## Get training data
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt", header=F)
names(trainData) <- featureNames

## Get activity information for the training data
trainActivity <- read.table("./UCI HAR Dataset/train/y_train.txt", header = F) 
names(trainActivity) <- "activity"

## Obtain subject information for the training data
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = F) 
names(trainSubject) <- "subject"

## combine train data with subject and activity information
mergedTrainData <- cbind(trainData,trainSubject,trainActivity)

## Delete large objects that are no longer needed
remove("trainData", "trainSubject", "trainActivity")

## Get test data
testData <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F)

## Read activity information for the test dataset
testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt", header = F) 

## Read subject information for the test data
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = F) 

## Combine test data with subject and activity information
mergedTestData <- cbind(testData,testSubject,testActivity)
names(mergedTestData) <- names(mergedTrainData)

## Delete objects that are no longer needed
remove("testData", "testSubject", "testActivity")

## Merge train and test data sets
mergedAllData <- rbind(mergedTrainData, mergedTestData)

## Obtain data that are only mean and std 
meanStdData <- mergedAllData[,grepl("mean[()]|std[()]",featureNames)]

## Delete large objects that are no longer needed
remove("mergedTrainData","mergedTestData")

## Replace numeric activity values with descriptive activity labels
act <- vector(mode = "character", length = nrow(meanStdData))
for(i in 1:nrow(meanStdData)){
        act[i] <- switch(meanStdData[i,"activity"],activityLabels[1],activityLabels[2],activityLabels[3],activityLabels[4],activityLabels[5],activityLabels[6])
}
meanStdData[,"activity"] <- act

## Rename data labels with descriptive names. Replace "t" by "time", "f" by "freq"
names(meanStdData) <- gsub("^t","time",names(meanStdData))
names(meanStdData) <- gsub("^f","freq",names(meanStdData))

## Remove "-" and "()" from labels
names(meanStdData) <- gsub("-","",names(meanStdData))
names(meanStdData) <- gsub("[()]","",names(meanStdData))

## Replace "BodyBody" instances with "Body"
names(meanStdData) <- gsub("BodyBody","Body",names(meanStdData))

## Replace "mean" with "Mean", "std" with "Std" for consistency
names(meanStdData) <- gsub("mean","Mean",names(meanStdData))
names(meanStdData) <- gsub("std","Std",names(meanStdData))

## Create a new tidy data set that is a summary of meanStdData. 
## Get number of variables
numVariable <- length(names(meanStdData))-2

## Get number of subjects
numSubject <- length(unique(meanStdData$subject))

## Initialize some temporary variables
aa    <- matrix(0,numActivity*numSubject,numVariable) # for mean values
bb    <- matrix("",numActivity*numSubject,1) # for activity names
cc    <- matrix(0,numActivity*numSubject,1) # for subject numbers

## Split meanStdData by activity
dataSplitAct <- split(meanStdData,meanStdData$activity)
actNames <- names(dataSplitAct)
ct <- 0  ## Initialize counter

## For each activity, split by subject and calculate mean for each subject
for (i in 1:numActivity){           
        # Write this activity name        
        indx = 1:numSubject+(i-1)*numSubject
        bb[indx,1] <- rep(actNames[i],numSubject)
        
        # Get data for this activity
        dummy <- dataSplitAct[[i]]
        
        # Split each element of dummy by subject
        dummy1 <- split(dummy,dummy$subject)  
        
        # For each subject calculate mean values
        for (j in 1:numSubject){
                ct = ct+1    
                
                # Get data for this subject
                dummy2 <- dummy1[[j]]
                
                # Write mean values of measured variables
                aa[ct,] <- colMeans(dummy2[,1:numVariable],na.rm = TRUE)
                
                # Write subject number
                cc[ct,] <- j
        }
}

## Create data frame for the tidy data set
tidyData <- data.frame(cbind(bb,cc,aa))

## Create names for columns
nn <- names(meanStdData)
nn <- nn[1:numVariable]

## Adding avg as prefix to signify that the variable is the average of of several 
## mean or std values
nn <- paste("avg",nn,sep = "")

## Replace "time" by "Time", "freq" by "Freq" for consistency
nn <- gsub("time","Time",nn)
nn <- gsub("freq","Freq",nn)

names(tidyData) <- c("activity","subject", nn)

## Write out tidy data set
write.table(tidyData,"tidydata.txt", row.names = FALSE, quote = FALSE)

## Delete variables
remove("aa","bb","cc","dummy","dummy1","dummy2","act","actNames","dataSplitAct","i","indx")        
remove("featureNames","ct","j","nn","activityLabels","numActivity","numSubject","numVariable")

print("Tidy data set has been created")

