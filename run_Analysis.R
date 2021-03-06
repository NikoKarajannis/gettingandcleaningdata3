





###0. things to do first: install package, download file, reading data into file

install.packages("plyr")
library("plyr")


###download file 
if(!file.exists("./smartphone")){dir.create("./smartphone")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl,destfile="./smartphone/Dataset.zip",method="auto")


###unzip the file

unzip(zipfile="./smartphone/Dataset.zip",exdir="./smartphone")



##Reading data from the files into the variables

Read the Activity files

file_ActivityTest  <- read.table(file.path(file_smartphone, "test" , "Y_test.txt" ),header = FALSE)
file_ActivityTrain <- read.table(file.path(file_smartphone, "train", "Y_train.txt"),header = FALSE)

Read the Subject files

file_SubjectTest <- read.table(file.path(file_smartphone, "test", "subject_test.txt"),header = FALSE)
file_SubjectTrain  <- read.table(file.path(file_smartphone, "train" , "subject_train.txt"),header = FALSE)

Read Features files

file_FeaturesTest  <- read.table(file.path(file_smartphone, "test" , "X_test.txt" ),header = FALSE)
file_FeaturesTrain <- read.table(file.path(file_smartphone, "train", "X_train.txt"),header = FALSE)



###1. Merging the training and the test sets to create one data set

###1.1 Concatenate the data tables by rows

Subject <- rbind(file_SubjectTrain, file_SubjectTest)
Activity<- rbind(file_ActivityTrain, file_ActivityTest)
Features<- rbind(file_FeaturesTrain, file_FeaturesTest)

###checking the tables
Subject
Activity
Features


###1.2 Applying names to the tables

names(Subject)<-c("subject")
names(Activity)<- c("activity")
varlab_Features <- read.table(file.path(file_smartphone, "features.txt"),head=FALSE)

##have a look at the table 
varlab_Features

##-> V2 is supposed to be used for names

names(Features)<- varlab_Features$V2


###1.3 Merging columns to get the data frame Data for all data; wanted to use merge but no Ids, so maybe cbind is okay???

data_complete <- cbind(Subject, Activity, Features)

##checking the dataset

head(data_complete, 2)
tail(data_complete, 2)


###2. Extracting measurements for mean and standard deviation for each measurement

##using grep to extract all variables with "mean" or "std" in it; making a vector and using this vector to subset the dataset.
features_mean_sd_subset<-varlab_Features$V2[grep("mean|std", varlab_Features$V2)]
features_mean_sd_subset <- as.character(features_mean_sd_subset)

selectedNames<-c(features_mean_sd_subset, "subject", "activity")
data_complete<-subset(data_complete,select=selectedNames)


###3. Giving descriptive activity names using the activity_labels txt-file

##Importing descriptive activity names from activity_labels.txt file
activity_labels <- read.table(file.path(file_smartphone, "activity_labels.txt"),header = FALSE)

##applying levels and lables
activity_labels_levels <- factor(activity_labels, levels=c(1, 2, 3, 4, 5, 6), labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))


###4. Giving labels with desciptive names

In the former part, variables activity and subject and names of the activities have been labelled using descriptive names.In this part, Names of Feteatures will labelled using descriptive variable names.

names(data_complete)<-gsub("^t", "time", names(data_complete))
names(data_complete)<-gsub("^f", "frequency", names(data_complete))
names(data_complete)<-gsub("Acc", "Accelerometer", names(data_complete))
names(data_complete)<-gsub("Gyro", "Gyroscope", names(data_complete))
names(data_complete)<-gsub("Mag", "Magnitude", names(data_complete))
names(data_complete)<-gsub("BodyBody", "Body", names(data_complete))
names(data_complete)<-gsub("std", "standarddeviation", names(data_complete))


names(data_complete)



###5. Making another data set (tidy data set) with the mean of every variable for each activity and each subject using the aggregate function; then exporting it to a txt-file and a csv-file.

data_complete_version2<-aggregate(. ~activity + subject, data=data_complete, mean)
write.table(data_complete_version2, file = "smartphonedata_mean_activity_subject.txt", row.names=FALSE)




