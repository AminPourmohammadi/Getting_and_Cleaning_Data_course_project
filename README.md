# Getting_and_Cleaning_Data_course_project
library("dplyr")
library("plyr")
library("data.table")
train_set<-read.table("train/X_train.txt") # set of features
test_set<-read.table("test/X_test.txt")
train_label<-read.table("train/y_train.txt") # activity label
test_label<-read.table("test/y_test.txt")
train_subject<-read.table("train/subject_train.txt") # set of subjects 
test_subject<-read.table("test/subject_test.txt")
set<-rbind(train_set,test_set)
label<-rbind(train_label,test_label)
subject<-rbind(train_subject,test_subject)

names(subject)<-c("subject_label")
names(label)<-c("activity_label")
# 561 measurements : labeling with the real names from features.txt
feature_label<-read.table("features.txt")
names(set)<-feature_label$V2
sub_act_label<-cbind(subject,label)

all_data<-cbind(set,sub_act_label) # 1) merged data
mean_or_std<-feature_label$V2[grep("mean\\(\\)|std\\(\\)",feature_label$V2)]
subset_data<-c(as.character(mean_or_std),"subject_label","activity_label") # to be used as a selected columns for subsetting the data
# data only with mean or std in activities from features.txt
new_data<-subset(all_data,select=subset_data) # 2) only mean and std
activity<-read.table("activity_labels.txt")
colnames(activity)<-c("activity_label","Activity")
data_act_name<-merge(new_data,activity,by=("activity_label"))
data_act_name<-select(data_act_name,-data_act_name$activity_label) # 3) descriptive activity name
names(data_act_name)<-sub("Gyro","Gyroscope",names(data_act_name))
names(data_act_name)<-sub("Acc","Accelerometer",names(data_act_name))
names(data_act_name)<-sub("Mag","Magnitude",names(data_act_name))
names(data_act_name)<-sub("^f","frequency",names(data_act_name))
names(data_act_name)<-sub("^t","time",names(data_act_name))
final<-aggregate(. ~subject_label + Activity,data_act_name,mean)
final<-final[order(final$subject_label,final$Activity),]
