## This files explains the steps taken in my script 

# 1. Train and Test data are combined in the first step

There are three corresponding files for each dataset 

1) train_set : all the activity measurements  (X_train.txt)
2) train_label : the data containing the code for 6 activities (1-6)
3) train_subject : the data containing the name code for a volunteer (1-30)
## step I : merging two datasets 
# first step
train_set and test_set were combined for a complete measurement dataset
called
"data_set"
#second step
the header names were changed according to the actual measurement name, i.e. the header was updated with "features.txt"
#third step
train_label and test_label were combined to be called "data_label"
and the header name was updated to "acitivity"
#fourth step
train_subject and test_subject were combined to form "data_sub"
and the header was updated to "subject"
#fifth step
These three datasets were combined to form a complete dataset

##Step II : Select columns with "mean" or "standard deviation" measurements

The resultant data set is called "sel_data"

##Step III : replace numbers with names for all the activities

replaced all the numbers with the actual name of the activity e.g. 1 by walking etc.

##Step IV : Appropriate labels for the data set with descriptive variable names

Used "gsub" to replace the short names to actual descriptive names for all the variables in the headers for all the columns.

## Step V : Group this selected group by activity and subject

The file is called "grouped_data" and calculated the mean of each variable for each activity and each subject.

This dataset called :'tidy_dataset" was written into a text file called "tidy_dataset.txt"






