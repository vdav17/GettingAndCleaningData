
# Load needed libraries
library("dplyr")
library("plyr")

# Download DataSet and unzip
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data/Dataset.zip")){
  download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
  unzip(zipfile="./data/Dataset.zip",exdir="./data")
}

# Load the activity labels in a data frame
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
# Load the features names in features data frame
features <- read.table("./data/UCI HAR Dataset/features.txt")

# Load x test data (features)
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
#Load y test data (activities)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
#Load the test subject data 
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Load x train data (features)
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
# Load y train data (activities)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
#Load the train subject data 
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Merge train and test data for features
merged_x <- (rbind(x_test, x_train))
#Change the names of the merged features for significant ones contained in features data frame
names(merged_x)<-(features[[2]])

#Merge activities data for train and test
merged_y <- rbind(y_test, y_train)

#Merge the subject train and test data
merged_subject <- rbind(subject_test, subject_train)

# Add auxiliar row int field to join later
merged_y$row<-seq.int(nrow(merged_y))
merged_x$row<-seq.int(nrow(merged_x))
merged_subject$row<-seq.int(nrow(merged_subject))
activity_labels$row<-seq.int(nrow(activity_labels))

#Add activity names to merged activities 
labeled_activities <- join(merged_y, activity_labels, by= "V1")
names(labeled_activities) <- c("activity_id", "row", "activity_name","row")

#Assign significant names to subject data columns
names(merged_subject) <- c("subject_id", "row")

#Create final dataset joining  activity set with feature set
final <-  join(merged_x, labeled_activities, by= "row")
#Extract only mean and std dev
final<- final[, grepl("*mean()*|*std()*|row|activity_name",names(final))]
#Join subject information
final <-  join(final, merged_subject, by = "row")

#Write data set as csv
write.csv(final, file = "./data/UCI HAR Dataset/final.csv")

#Group by subject and activity to create another dataset with the variable means
final_summary<-final%>% group_by(subject_id,activity_name) %>% summarise_each(funs(mean))
#Create a new csv with summarized data
write.csv(final_summary, file = "./data/UCI HAR Dataset/final_mean.csv")

