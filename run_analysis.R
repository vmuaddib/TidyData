#You should create one R script called run_analysis.R that does the following. 
        #1.Merges the training and the test sets to create one data set.
        #2.Extracts only the measurements on the mean and standard deviation for each measurement. 
        #3.Uses descriptive activity names to name the activities in the data set
        #4.Appropriately labels the data set with descriptive variable names. 
        #5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        
        #FILES CONTENT
        #- 'features_info.txt': Shows information about the variables used on the feature vector.
        #- 'features.txt': List of all features.
        #- 'activity_labels.txt': Links the class labels with their activity name.
        #- 'train/X_train.txt': Training set.
        #- 'train/y_train.txt': Training labels.
        #- 'test/X_test.txt': Test set.
        #- 'test/y_test.txt': Test labels.



#features data
fdf <- read.table(file = "./UCI HAR Dataset/features.txt", sep = "")
cn<- fdf[,"V2"] #put the name of the columns into one df

#subjects data
sts <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", sep = "")
sts <- as.factor(sts$V1) #transform to factor
str <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", sep = "")
str <- as.factor(str$V1) #transform to factor

#test data
tsl <- read.table(file = "./UCI HAR Dataset/test/y_test.txt", sep = "")
tsl <- as.factor(tsl$V1) #transform to factor
tsdf <- read.table(file = "./UCI HAR Dataset/test/x_test.txt", sep = "")
colnames(tsdf) <- cn #add column names for test dataframe
tsdf <- cbind(tsdf,"activity"=tsl,"subject"=sts) #add activity and subject to the dataset

#train data
trl <- read.table(file = "./UCI HAR Dataset/train/y_train.txt", sep = "")
trl <- as.factor(trl$V1) #transform to factor
trdf <- read.table(file = "./UCI HAR Dataset/train/x_train.txt", sep = "")
colnames(trdf) <- cn #add column names for train dataframe
trdf <- cbind(trdf,"activity"=trl, "subject"=str) #add activity and subject to the dataset

#1.Merges the training and the test sets to create one data set.
alldf <- rbind(trdf,tsdf)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#I am filtering only the variables containing -mean() and -std(). "MeanFreq is not the mean messurment of a specific measurment, rather as it suggests it is: Weighted average of the frequency components to obtain a mean frequency"
#I am keeping the new columns I added: "subjects" and "activities"
# colindex <- grep("(.*\\-(mean|std)\\())",names(alldf)) index for the columns of interest
cn <- c(grep("(.*\\-(mean|std)\\())",names(alldf), value = TRUE), "activity", "subject")

names(alldf[,colindex])#only the columns of interest
exalldf <- alldf[,cn] #the data in the selected columns

#3.Uses descriptive activity names to name the activities in the data set
acl <- read.table(file = "./UCI HAR Dataset/activity_labels.txt", sep = "")
colnames(acl) <- c("id","factor")
levels(exalldf$activity) <- tolower(acl$factor) # worked easy since the order was the same, also made lowercase 

#4.Appropriately labels the data set with descriptive variable names.
names(exalldf)
names(exalldf) <- gsub("*.\\(\\)","",names(exalldf)) #remove the alphanumeric "()"
names(exalldf) <- gsub("-","",names(exalldf)) #remove the alphanumeric "-"
names(exalldf) <- gsub(",","",names(exalldf)) #remove the alphanumeric ","
names(exalldf) <- gsub("^f","frequency",names(exalldf)) #rename "f" to "frequency"
names(exalldf) <- gsub("^t","time",names(exalldf)) #rename "t" to "time"
names(exalldf) <- tolower(names(exalldf)) #make all colums lowercase


#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
mv <- names(exalldf[,1:66]) #select all colums besides activity and subject
mdf <- melt(exalldf, id = c("activity","subject"), measure.vars = mv) #melt the dataframe
tdf <- dcast(mdf,subject+activity~variable,mean) 

#create the tidy file
write.table(tdf, file = "Tidy.txt", row.names = FALSE)
