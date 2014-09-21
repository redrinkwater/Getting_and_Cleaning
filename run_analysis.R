##loads required library

library(reshape2)


## Load in files

features<-read.table("UCI HAR Dataset/features.txt")

Xtest<-read.table("UCI HAR Dataset/test/X_test.txt", col.names=as.vector(features[,2]))     #and renames columns using features data frame

Xtrain<-read.table("UCI HAR Dataset/train/X_train.txt", col.names=as.vector(features[,2]))  #and renames columns using features data frame

Ytest<-read.table("UCI HAR Dataset/test/y_test.txt", col.names="Activity.ID")

Ytrain<-read.table("UCI HAR Dataset/train/y_train.txt", col.names="Activity.ID")

subjectTest<-read.table("UCI HAR Dataset/test/subject_test.txt", col.names="Subject")

subjectTrain<-read.table("UCI HAR Dataset/train/subject_train.txt", col.names="Subject")

Activity<-read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("Activity.ID", "Activity.Name"))


##Creates empty column Activity.Name

Ytest$Activity.Name<-""       
Ytrain$Activity.Name<-""      


##combinessubject, X and Y data frames

Test<-cbind(subjectTest, Ytest, Xtest)      
Train<-cbind(subjectTrain, Ytrain, Xtrain)


##adds column 'Set' and fills with either Test or Train (to allow 2 sets to be found after merge)

Test$Set<-"Test"
Train$Set<-"Train"


##Joins Test and Train data frames

Combined<-rbind(Test, Train)


##Fills Activity.Name column with the descriptive name for activities

Combined$Activity.Name <- Activity[Combined$Activity.ID,2]


##Creates new dataframe with just those values for mean and standard deviation

meansd<- Combined[ , which(grepl("Subject|Activity.Name|mean[^F]|std", names(Combined)))]


##Melts the dataframe and casts it to return the average for each subject-activity combination and variable

MTidy<-melt(meansd, id=c("Subject", "Activity.Name"))
Tidy<-dcast(MTidy, Subject+Activity.Name~variable, mean)


##Writes the result to a table

write.table(Tidy, file="run_analysis.txt", row.name=FALSE)