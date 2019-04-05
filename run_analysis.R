# load activity labels
activities <- read.csv("data/activity_labels.txt", sep =" ", header=F)
# assign descriptive column names
names(activities) <- c("code", "activityDescription")

# read features list
features <- read.csv("data/features.txt", header = F, sep="")
# assign descriptive column names
names(features) <- c("ordinal", "feature")
# get feature list for assigning to measurement/test columns
featureNames <- features$feature

# load test data set and set column names
testMeasurements <- read.csv("data/test/X_test.txt", header=F, sep="")
names(testMeasurements) <- featureNames
testActivityCodes <- read.csv("data/test/y_test.txt", header=F, sep="")
names(testActivityCodes) <- c("activityCode")
testSubjects <- read.csv("data/test/subject_test.txt")
names(testSubjects) <- c("subjectId")
# add ordinals for merge
testMeasurements$N  <- seq(1:dim(testMeasurements)[1])
testActivityCodes$N <- seq(1:dim(testActivityCodes)[1])
testSubjects$N <- seq(1:dim(testSubjects)[1])
# merge measurement with activity by ordinal 
testDataMerged <- merge(testMeasurements, testActivityCodes, by.x = "N", by.y = "N")
testDataMerged <- merge(testDataMerged, testSubjects, by.x = "N", by.y = "N")


# load training data set and set column names
trainMeasurements <- read.csv("data/train/X_train.txt", header=F, sep="")
names(trainMeasurements) <- featureNames
trainActivityCodes <- read.csv("data/train/y_train.txt", header=F, sep="")
names(trainActivityCodes) <- c("activityCode")
trainSubjects <- read.csv("data/train/subject_train.txt")
names(trainSubjects) <- c("subjectId")
# add ordinals for merge
trainMeasurements$N  <- seq(1:dim(trainMeasurements)[1])
trainActivityCodes$N <- seq(1:dim(trainActivityCodes)[1])
trainSubjects$N <- seq(1:dim(trainSubjects)[1])
# merge measurement with activity by ordinal 
trainDataMerged <- merge(trainMeasurements, trainActivityCodes, by.x = "N", by.y = "N")
trainDataMerged <- merge(trainDataMerged, trainSubjects, by.x = "N", by.y = "N")


# combine test and train data
fullData <- bind_rows(trainDataMerged, testDataMerged)

# change activity code to activity description and select only mean, 
# standard deviation and activity columns
fullData <- merge(fullData, activities, by.x="activityCode", by.y="code") %>%
  select(subjectId, contains("mean()"), contains("std()"), activityDescription)

# calculate means for each subject and activity
meansBySubjectByActivity <- fullData %>%
    group_by(subjectId, activityDescription) %>%
    summarize_all(list(mean))

# save calculated data 
if(!file.exists("data/merged/meansBySubjectByActivity.csv")) {
  dir.create("data/merged/", recursive = T)
  file.create("data/merged/meansBySubjectByActivity.csv")
}
write.csv(meansBySubjectByActivity, "data/merged/meansBySubjectByActivity.csv")
