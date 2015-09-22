# Code Book

This code book summarizes the resulting data fields in `tidy.txt`.

## Original data set
Taken from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones:

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded   accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

For more information read visit http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, the website where the original data came from. 


## Data cleaning steps
The following steps were taken to get the data to the current form

#### 1. Merge the training and the test sets to create one data set.
After setting the source directory for the files, read into tables the data located in
	* features.txt
	* activity_labels.txt
	* subject_train.txt
	* x_train.txt
	* y_train.txt
	* subject_test.txt
	* x_test.txt
	* y_test.txt

* The subjects and activity labels were read, transformed to factors
* Test data df and train data df are read and each of them merged with the subjects and activities - using cbind
* Test data and train data are merged into on df - using rbind


#### 2. Extract only the measurements on the mean and standard deviation for each measurement. 

* The values that contain -mean() and -std() are filtered. 
* !!! why not the others containing mean, std? "MeanFreq is not the mean messurment of a specific measurment, rather as it suggests it is: Weighted average of the frequency components to obtain a mean frequency"
* Besides the filtered columne, the "subjects" and "activities" were also kept.

#### 3. Use descriptive activity names to name the activities in the data set
* The 1-6 values for activity factor were replaces with with meanngful values  like WALKING, WALKING_UPSTAIRS etc.Also made them lowercase
* The pearson values were not replace because "Pearson 1" is not more meaningful then "1"

#### 4. Appropriately label the data set with descriptive activity names.
Renamed the columns of the data frame to comply with the tidy data standards. The following actions were taken:
	* remove the alphanumeric "()"
	* remove the alphanumeric "-"
	* remove the alphanumeric ","
	* rename "f" to "frequency"
	* rename "t" to "time"
	* make all colums lowercase

#### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
* The data frame was meltet, id = "activity","subject" and  measure.vars = all the other columns
* Datagrame casted from the melted data frame to comply with the request
* Final dataframe writen to file

## Identifiers

* `subject` - The ID of the test subject
* `activity` - The type of activity performed when the corresponding measurements were taken

## Measurements
 [1] "subject"    
 		Pearson 1 to 24                    
 [2] "activity"
	* WALKING: subject was walking during the test
	* WALKING_UPSTAIRS: subject was walking up a staircase during the test
	* WALKING_DOWNSTAIRS: subject was walking down a staircase during the test
	* SITTING: subject was sitting during the test
	* STANDING: subject was standing during the test
	* LAYING: subject was laying down during the test                    
 [3] "timebodyaccmeax"                
 [4] "timebodyaccmeay"                
 [5] "timebodyaccmeaz"                
 [6] "timebodyaccstx"                 
 [7] "timebodyaccsty"                 
 [8] "timebodyaccstz"                 
 [9] "timegravityaccmeax"             
[10] "timegravityaccmeay"             
[11] "timegravityaccmeaz"             
[12] "timegravityaccstx"              
[13] "timegravityaccsty"              
[14] "timegravityaccstz"              
[15] "timebodyaccjerkmeax"            
[16] "timebodyaccjerkmeay"            
[17] "timebodyaccjerkmeaz"            
[18] "timebodyaccjerkstx"             
[19] "timebodyaccjerksty"             
[20] "timebodyaccjerkstz"             
[21] "timebodygyromeax"               
[22] "timebodygyromeay"               
[23] "timebodygyromeaz"               
[24] "timebodygyrostx"                
[25] "timebodygyrosty"                
[26] "timebodygyrostz"                
[27] "timebodygyrojerkmeax"           
[28] "timebodygyrojerkmeay"           
[29] "timebodygyrojerkmeaz"           
[30] "timebodygyrojerkstx"            
[31] "timebodygyrojerksty"            
[32] "timebodygyrojerkstz"            
[33] "timebodyaccmagmea"              
[34] "timebodyaccmagst"               
[35] "timegravityaccmagmea"           
[36] "timegravityaccmagst"            
[37] "timebodyaccjerkmagmea"          
[38] "timebodyaccjerkmagst"           
[39] "timebodygyromagmea"             
[40] "timebodygyromagst"              
[41] "timebodygyrojerkmagmea"         
[42] "timebodygyrojerkmagst"          
[43] "frequencybodyaccmeax"           
[44] "frequencybodyaccmeay"           
[45] "frequencybodyaccmeaz"           
[46] "frequencybodyaccstx"            
[47] "frequencybodyaccsty"            
[48] "frequencybodyaccstz"            
[49] "frequencybodyaccjerkmeax"       
[50] "frequencybodyaccjerkmeay"       
[51] "frequencybodyaccjerkmeaz"       
[52] "frequencybodyaccjerkstx"        
[53] "frequencybodyaccjerksty"        
[54] "frequencybodyaccjerkstz"        
[55] "frequencybodygyromeax"          
[56] "frequencybodygyromeay"          
[57] "frequencybodygyromeaz"          
[58] "frequencybodygyrostx"           
[59] "frequencybodygyrosty"           
[60] "frequencybodygyrostz"           
[61] "frequencybodyaccmagmea"         
[62] "frequencybodyaccmagst"          
[63] "frequencybodybodyaccjerkmagmea" 
[64] "frequencybodybodyaccjerkmagst"  
[65] "frequencybodybodygyromagmea"    
[66] "frequencybodybodygyromagst"     
[67] "frequencybodybodygyrojerkmagmea"
[68] "frequencybodybodygyrojerkmagst"
