# COURSERA DATA SCIENCE SPECIALIZATION
# COURSE 3: GETTING AND CLEANING DATA 
# FINAL PROJECT
# RICHARD JACKSON 
# May 14, 2022
#

# Get the libraries we will need 
library(downloader)
library(plyr);
library(knitr)

# Same process as shown in the class :) 
# Download the data set
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Path variables for consistency
path = getwd()
destFilePath = paste(path, "/Dataset.zip", sep = "")
destFolderPath = paste(path, "/UCI HAR Dataset", sep = "")

# Check the paths
# destFilePath
# destFolderPath

# Download the zip if we don't have it yet 
if(!file.exists(destFilePath))
{
  download.file(Url, destFilePath, mode = "wb")
}
# We know the unzipped folder name, so see if its there or not
dirPath = paste(path, "/UCI HAR Dataset", sep = "")
if(!file.exists(dirPath))
{
  # Unzip to current path
  unzip(destFilePath)
}
# List everything that's in the UCI HAR Dataset folder
path <- file.path(path , "UCI HAR Dataset")

files<-list.files(path, recursive=TRUE)
#This should be what we get, from inspection: 
# test/subject_test.txt
# test/X_test.txt
# test/y_test.txt
# train/subject_train.txt
# train/X_train.txt
# train/y_train.txt

#Ok we have the data now load it and read it

# Read activity file set
activityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
activityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)

# Read Subject file set
subjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
subjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)

# Read Features file set
featuresTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
featuresTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)

## Test: Check properties

str(activityTest)
str(activityTrain)
str(subjectTrain)
str(subjectTest)
str(featuresTest)
str(featuresTrain)

# Now merge the test and training sets since we are 
# not doing a machine learning model. 

# munge the data table using rbind (by rows)
dataSubject <- rbind(subjectTrain, subjectTest)
dataActivity <- rbind(activityTrain, activityTest)
dataFeatures <- rbind(featuresTrain, featuresTest)

# set up logical names; subject, activity, and features. 
names(dataSubject) <-c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(dataFeatures) <- dataFeaturesNames$V2

# Munge everything into a data frame 
dataCombined <- cbind(dataSubject, dataActivity)
myDataFrame <- cbind(dataFeatures, dataCombined)

#grep the mean and standard deviations of each measurement 
subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# Make a subset based on the names we have; subject and activity. 
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
myDataFrame<-subset(myDataFrame,select=selectedNames)

# Check the data frame
# str(myDataFrame)

# Assign  readable lablels
activityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)

# Factor the activity variable using the labels
myDataFramea$activity<-factor(Data$activity,labels=activityLabels[,2])

# Check the data
# head(myDataFrame$activity,30)

# Label using easily readable names, lowercase for consistency.  
names(myDataFrame)<-gsub("^t", "time", names(myDataFrame))
names(myDataFrame)<-gsub("^f", "frequency", names(myDataFrame))
names(myDataFrame)<-gsub("Acc", "accelerometer", names(myDataFrame))
names(myDataFrame)<-gsub("Gyro", "gyroscope", names(myDataFrame))
names(myDataFrame)<-gsub("Mag", "magnitude", names(myDataFrame))
names(myDataFrame)<-gsub("BodyBody", "body", names(myDataFrame))

# Check the names
# names(myDataFrame)

# everything looks good, create a clean data set
finalData <-aggregate(. ~subject + activity, myDataFrame, mean)
finalData <- finalData[order(finalData$subject,finalData$activity),]
write.table(finalData, file = "tidyData.txt",row.name=FALSE,quote = FALSE, sep = '\t')

# Check final data
# str(finalData)
# summary(finalData)

