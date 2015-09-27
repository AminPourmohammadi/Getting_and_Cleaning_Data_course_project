library(dplyr)
library(data.table)
library(tidyr)
## step 1 : merging train and test data

train_set<-read.table("train/X_train.txt",stringsAsFactors = FALSE)
test_set<-read.table("test/X_test.txt",stringsAsFactors = FALSE)
data_set<-rbind(train_set, test_set)
# features.txt contains the actual name of all 561 columns in the above file
header<-read.table("features.txt")
names(data_set)<-header$V2
# load activity labels for train and test
train_label<-read.table("train/y_train.txt",stringsAsFactors = FALSE)
test_label<-read.table("test/y_test.txt",stringsAsFactors = FALSE)
data_label<-rbind(train_label,test_label)
colnames(data_label)<-"activity"

# load subjects for train and test 
train_subject<-read.table("train/subject_train.txt") # set of subjects 
test_subject<-read.table("test/subject_test.txt") # set of subjects 
data_sub<-rbind(train_subject,test_subject)
colnames(data_sub)<-"subject" # change the column label 

# final data with all the subjects, activities of all the volunteers in train and test subjects
data<-cbind(data_set,data_label,data_sub)
final<-tbl_df(data)
rm(data)
sel_cols<-final[,grep("std|mean|activity|subject",colnames(final),ignore.case=TRUE)]  # names(final[,"requiredcolumn"])
sel_data<-tbl_df(sel_cols)
rm(sel_cols)
#activity<-read.table("activity_labels.txt",stringsAsFactors = FALSE)
sel_data$activity[sel_data$activity==1]<-"WALKING"
sel_data$activity[sel_data$activity==2]<-"WALKING_UPSTAIRS"
sel_data$activity[sel_data$activity==3]<-"WALKING_DOWNSTAIRS"
sel_data$activity[sel_data$activity==4]<-"SITTING"
sel_data$activity[sel_data$activity==5]<-"STANDING"
sel_data$activity[sel_data$activity==6]<-"LAYING"

# descriptive names for all the activities
names(sel_data)<-gsub("^t","Time",names(sel_data))
names(sel_data)<-gsub("-mean()","Mean",names(sel_data))
names(sel_data)<-gsub("-std()","Standard_Deviation",names(sel_data))
names(sel_data)<-gsub("Acc","Accelerometer",names(sel_data))
names(sel_data)<-gsub("Gyro","Gyroscore",names(sel_data))
names(sel_data)<-gsub("Mag","Magnitude",names(sel_data))
names(sel_data)<-gsub("Freq","Frequency",names(sel_data))
names(sel_data)<-gsub("^f","Frequency",names(sel_data))
names(sel_data)<-gsub("BodyBody","Body",names(sel_data))
names(sel_data)<-gsub("tBody","TimeBody",names(sel_data))

# group this selected group by activity and subject
grouped_activity<-group_by(sel_data,activity, subject)
# we can use summarise_each to get the mean of every column (summarize for one or a few columns)
tidy_dataset<-summarise_each(grouped_activity,funs(mean))
#saving this data to a file 
write.table(tidy_dataset,file="tidy_dataset.txt",row.names = FALSE)


