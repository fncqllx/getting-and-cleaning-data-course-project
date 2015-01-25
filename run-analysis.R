setwd("/Users/qian.li/Dropbox/data science/getting and cleaning data/")

if (!file.exists("projectdata")){
    dir.create("projectdata")
}

##Download the zipped data from the provided link
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./projectdata/UCIHARDataset.zip")


##trying to unzip the file. How to make it work?
##unzip(UCIHARDataset)    this does not work. So I went ahead unzipping the file by clicking

##Step 1: merge the test data and train data

testdata <- read.table("./projectdata/UCI HAR Dataset/test/X_test.txt")
testlabel<- read.table("./projectdata/UCI HAR Dataset/test/y_test.txt")
testsubject<- read.table("./projectdata/UCI HAR Dataset/test/subject_test.txt")

traindata <- read.table("./projectdata/UCI HAR Dataset/train/X_train.txt")
trainlabel <- read.table("./projectdata/UCI HAR Dataset/train/y_train.txt")
trainsubject <- read.table("./projectdata/UCI HAR Dataset/train/subject_train.txt")

xcombined<- cbind(testdata, testsubject, testlabel)
ycombined<- cbind(traindata, trainsubject, trainlabel)

combined <- rbind(xcombined, ycombined)

names <- read.table("./projectdata/UCI HAR Dataset/features.txt")
names(combined) <- c(as.character(names[,2]), "subject", "label")


##step2 : subset the data frame by partically matching variable names with "mean" or "std"

subdata1 <- combined[,grep("mean", colnames(combined))] 
subdata2 <- combined[,grep("std", colnames(combined))] 
subdata3 <- combined[,c("subject","label")]

subdata <- cbind(subdata1, subdata2, subdata3)
dim(subdata)

##step3: Use descriptive activity names to name the activities in the data set
## the activity name is from the text file "activity labels"
##activity <- read.table("./projectdata/UCI HAR Dataset/activity_labels.txt")

activity <- gsub("1", "walking", 
	gsub("2", "walking upstairs", 
		gsub("3", "walking downstairs",
			gsub("4", "sitting", 
				gsub("5", "standing", 
					gsub("6", "laying", subdata$label))))))

middata <- cbind(subdata, activity)


##step 4: label the data set with descriptive variable names.

tidy1<- gsub("-", "", 
	gsub("mean", "Mean",
		gsub("std", "Std",
			gsub("()", "", names(middata), fixed=TRUE))))
  
names(middata) <- c(tidy1)

##step 5: From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.

library(dplyr)

grouped <- group_by(middata, activity, subject)

tidy2 <- summarise_each(grouped, funs(mean, sd))

write.table(tidy2, file = "/Users/qian.li/Dropbox/data science/getting and cleaning data/projectdata/step5.txt",
     row.names=FALSE, col.names=TRUE, append = FALSE, sep = " ")

##try <- read.table("./projectdata/step5.txt")

