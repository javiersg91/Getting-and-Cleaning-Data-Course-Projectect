library(dplyr)

##Reading data
setwd("~/R/Projects/UCI HAR Dataset")
features <- read.csv("features.txt", header = FALSE, sep = ' ')
features <- as.character(features[,2])

data.subject.test <- read.csv('./test/subject_test.txt', header = FALSE, sep = ' ')
data.x.test <- read.table('./test/X_test.txt')
data.y.test <- read.csv('./test/Y_test.txt', header = FALSE, sep = ' ')
data.test <- data.frame(data.subject.test, data.y.test, data.x.test)
names(data.test) <- c(c('subject', 'activity'), features)

data.subject.train <- read.csv('./train/subject_train.txt', header = FALSE, sep = ' ')
data.x.train <- read.table('./train/X_train.txt') 
data.y.train <- read.csv('./train/Y_train.txt', header = FALSE, sep = ' ')
data.train <- data.frame(data.subject.train, data.y.train, data.x.train)
names(data.train) <- c(c('subject', 'activity'), features)

##1. Merging data
data <- bind_rows(data.train, data.test)

##2. Extracting mean and standard deviation
meanstd <- select(data, subject, activity, grep("mean|std", names(data)))

##3. Naming activities in the dataset
activities <- read.csv("activity_labels.txt", header = FALSE, sep = ' ')
activities <- as.character(activities[,2])
meanstd$activity <- activities[meanstd$activity]

##4. Labeling dataset with descriptive variable names
name.new <- names(meanstd)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("Body", "", name.new)
name.new <- gsub("^t", "Time_", name.new)
name.new <- gsub("^f", "Frequency_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-mean", "_Mean", name.new)
name.new <- gsub("-meanFreq", "_MeanFrequency", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-std", "_StandardDeviation", name.new)
name.new <- gsub("-", "_", name.new)
names(meanstd) <- name.new

##5. Tidy dataset with averages
final.table <- aggregate(meanstd[,3:81], list(meanstd$activity, meanstd$subject), mean)
write.table(final.table, "final.table.txt", row.names = FALSE)
