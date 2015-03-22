 ##Getting and Cleaning Data
###Course Project
 
###Make a Tidy Dataset from HAR Dataset


	The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
	Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
	wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
	we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
	The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly 
	partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% 
	the test data.
 


__Scripts__ 

| Script | Action |
|--------|--------|
| run_analysis.R | Unique Script, download data, unzip, process and store tidyDataset.txt |

__Functions__ 

| Function | Action |
|--------|--------|
| checkOrDownloadZipFile |  Ensure has de Zip File or Download it  |
| unzipDataFile |  Unzip datafile.zip |
| checkForData |  Ensure the _'UCI HAR Dataset','UCI HAR Dataset/test' and 'UCI HAR Dataset/train'_ exists |
| ensureDataFiles | Call checkOrDownloadZipFile, unzipDataFile and checkForData  functions |
| readLabelsAndFeaturesData |  Read Activity labels  and Feature Names, filter the FeatureNames to get only Mean and StdDev Columns |
| readRawData |  Reads Test and Train Files  |
| mergeRawData |  Join X,Y,Subject from test and train, make a single wholeData Set |
| filterRawData | Filter WholeData to columns Selected in _readLabelsAndFeaturesData_  |
| assignActivities | Assign proper Activity Names  |
| labelingColumns | Rename Columns to a meaningful name  |
| calcTidyDataset | Calc average per variable for subject-activity  |
| storeDataset | Store result on tidyDataset.txt file  |


##Resulted Dataset
 
The file  tidyDataset.txt  has:


| Feature | Description |
|--------|--------|
|Subject | Subject Measured  |
|Activity | Activity Related |
|BodyAcc_X_TimeMean | Body Acceleration over X Axis - Time Average  |
|BodyAcc_Y_TimeMean | Body Acceleration over Y Axis - Time Average  |
|BodyAcc_Z_TimeMean | Body Acceleration over Z Axis - Time Average  |
|GravityAcc_X_TimeMean | Gravity Acceleration over X Axis - Time Average  |
|GravityAcc_Y_TimeMean | Gravity Acceleration over Y Axis - Time Average   |
|GravityAcc_Z_TimeMean | Gravity Acceleration over Z Axis - Time Average   |
|BodyAccJerk_X_TimeMean | Body Acceleration on Jerk over X Axis - Time Average   |
|BodyAccJerk_Y_TimeMean |  Body Acceleration on Jerk over Y Axis - Time Average  |
|BodyAccJerk_Z_TimeMean |  Body Acceleration on Jerk over Z Axis - Time Average  |
|BodyGyro_X_TimeMean | Body Gyroscope over X Axis - Time Average|
|BodyGyro_Y_TimeMean | Body Gyroscope over Y Axis - Time Average |
|BodyGyro_Z_TimeMean | Body Gyroscope over Z Axis - Time Average|
|BodyGyroJerk_X_TimeMean | Body Gyroscope on Jerk over X Axis- Time Average |
|BodyGyroJerk_Y_TimeMean | Body Gyroscope on Jerk over Y Axis- Time Average  |
|BodyGyroJerk_Z_TimeMean | Body Gyroscope on Jerk over Z Axis- Time Average  |
|BodyAccMagTimeMean | Body Acceleration Magnitude over Z Axis - Time Average   |
|GravityAccMagTimeMean | Gravity Acceleration Magnitude  - Time Average  |
|BodyAccJerkMagTimeMean | Body Acceleration Magnitude on Jerk  - Time Average  |
|BodyGyroMagTimeMean | Body Gyroscope Magnitude - Time Average  |
|BodyGyroJerkMagTimeMean | Body Gyroscope Magnitude  on Jerk  - Time Average  |
|BodyAcc_X_FreqMean | Body Acceleration over X Axis - Frequency Average |
|BodyAcc_Y_FreqMean | Body Acceleration over Y Axis - Frequency Average  |
|BodyAcc_Z_FreqMean | Body Acceleration over Z Axis - Frequency Average  |
|BodyAccJerk_X_FreqMean |  Body Acceleration on Jerk over X Axis - Frequency Average |
|BodyAccJerk_Y_FreqMean |  Body Acceleration on Jerk over X Axis - Frequency Average |
|BodyAccJerk_Z_FreqMean |  Body Acceleration on Jerk over X Axis - Frequency Average |
|BodyGyro_X_FreqMean |  Body Gyroscope over X Axis - Frequency Average|
|BodyGyro_Y_FreqMean |  Body Gyroscope over Y Axis - Frequency Average |
|BodyGyro_Z_FreqMean |  Body Gyroscope over Z Axis - Frequency Average |
|BodyAccMagFreqMean | Body Acceleration Magnitude - Time Average |
|BodyBodyAccJerkMagFreqMean | Body Acceleration Magnitude on Jerk - Frequency Average  |
|BodyBodyGyroMagFreqMean | Body Gyroscope Magnitude - Frequency Average  |
|BodyBodyGyroJerkMagFreqMean | Body Gyroscope Magnitude on Jerk - Frequency Average  |
|BodyAcc_X_TimeStdDev |  Body Acceleration over X Axis - Time Standard Deviation  |
|BodyAcc_Y_TimeStdDev |  Body Acceleration over Y Axis - Time Standard Deviation  |
|BodyAcc_Z_TimeStdDev |  Body Acceleration over Z Axis - Time Standard Deviation  |
|GravityAcc_X_TimeStdDev |  Gravity Acceleration over X Axis - Time Standard Deviation|
|GravityAcc_Y_TimeStdDev |  Gravity Acceleration over Y Axis - Time Standard Deviation |
|GravityAcc_Z_TimeStdDev |  Gravity Acceleration over Z Axis - Time Standard Deviation |
|BodyAccJerk_X_TimeStdDev | Body Acceleration on Jerk over X Axis - Time Standard Deviation |
|BodyAccJerk_Y_TimeStdDev | Body Acceleration on Jerk over Y Axis - Time Standard Deviation |
|BodyAccJerk_Z_TimeStdDev | Body Acceleration on Jerk over Z Axis - Time Standard Deviation |
|BodyGyro_X_TimeStdDev |  Body Gyroscope over X Axis - Time Standard Deviation  |
|BodyGyro_Y_TimeStdDev |  Body Gyroscope over Y Axis - Time Standard Deviation |
|BodyGyro_Z_TimeStdDev |  Body Gyroscope over Z Axis - Time Standard Deviation |
|BodyGyroJerk_X_TimeStdDev | Body Gyroscope on Jerk over X Axis- Time Standard Deviation |
|BodyGyroJerk_Y_TimeStdDev | Body Gyroscope on Jerk over Y Axis- Time Standard Deviation |
|BodyGyroJerk_Z_TimeStdDev | Body Gyroscope on Jerk over Z Axis- Time Standard Deviation |
|BodyAccMagTimeStdDev | Body Acceleration Magnitude - Time Standard Deviation |
|GravityAccMagTimeStdDev | Gravity Gyroscope Magnitude - Frequency  Standard Deviation |
|BodyAccJerkMagTimeStdDev | Body Acceleration Magnitude on Jerk - Frequency Standard Deviation |
|BodyGyroMagTimeStdDev | Body Gyroscope Magnitude - Frequency  Standard Deviation |
|BodyGyroJerkMagTimeStdDev | Body Gyroscope Magnitude on Jerk - Frequency  Standard Deviation |
|BodyAcc_X_FreqStdDev |  Body Acceleration over X Axis - Frequency Standard Deviation |
|BodyAcc_Y_FreqStdDev |  Body Acceleration over Y Axis - Frequency Standard Deviation |
|BodyAcc_Z_FreqStdDev |  Body Acceleration over Z Axis - Frequency Standard Deviation |
|BodyAccJerk_X_FreqStdDev | Body Acceleration on Jerk over X Axis - Frequency Standard Deviation |
|BodyAccJerk_Y_FreqStdDev | Body Acceleration on Jerk over Y Axis - Frequency Standard Deviation |
|BodyAccJerk_Z_FreqStdDev | Body Acceleration on Jerk over Z Axis - Frequency Standard Deviation |
|BodyGyro_X_FreqStdDev | Body Gyroscope over X Axis - Frequency Standard Deviation |
|BodyGyro_Y_FreqStdDev | Body Gyroscope over Y Axis - Frequency Standard Deviation |
|BodyGyro_Z_FreqStdDev | Body Gyroscope over Z Axis - Frequency Standard Deviation |
|BodyAccMagFreqStdDev | Body Acceleration Magnitude - Frequency Standard Deviation  |
|BodyBodyAccJerkMagFreqStdDev |  Body Acceleration Magnitude on Jerk - Frequency Standard Deviation  |
|BodyBodyGyroMagFreqStdDev |  Body Gyroscope Magnitude - Frequency Standard Deviation  |
|BodyBodyGyroJerkMagFreqStdDev |  Body Gyroscope Magnitude on Jerk - Frequency Standard Deviation  |
|-|-|




 