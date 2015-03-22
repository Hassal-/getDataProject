library(plyr)
library(dplyr)
library(reshape2)
library(Hmisc)


#Getting Data
checkOrDownloadZipFile <- function(){
  if(!file.exists("./datafile.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                  destfile = "datafile.zip", method = 'curl')
  } 
}

unzipDataFile <- function(){
  if(!file.exists("UCI HAR Dataset")){
    unzip(zipfile="datafile.zip", exdir=".", overwrite=TRUE)
  }
}

checkForData <- function(){
  if(!file.exists("./UCI HAR Dataset")){
    stop("There is no 'UCI HAR Dataset' Directory  ")
  } else if(!file.exists("./UCI HAR Dataset/test")){
    stop("There is no 'UCI HAR Dataset/test' Directory  ")
  }  else if(!file.exists("./UCI HAR Dataset/train")){
    stop("There is no 'UCI HAR Dataset/test' Directory  ")
  }  
}

ensureDataFiles<- function(){
  print("Ensuring Data File")
  checkOrDownloadZipFile()
  unzipDataFile()
  checkForData()
}


#Load Data 
readLabelsAndFeaturesData <- function(){
  print("Reading Labels")
  gLabels <<- read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("id","Activity")) 
  
  print("Reading Features/Column Names")
  lFeaturesNamesData <<- read.table("./UCI HAR Dataset/features.txt", col.names=c("id","Feature")) 
  lFeaturesNamesDataSelected <<- rbind(lFeaturesNamesData[grepl("mean\\(", lFeaturesNamesData$Feature),],lFeaturesNamesData[grepl("std\\(", lFeaturesNamesData$Feature),])
  
  print("Asigning Column Names")
  lColNames <- c(c("Subject","Activity"),as.vector(lFeaturesNamesData[,2] ))
  lColSelected <- c(c("Subject","Activity"),as.vector(lFeaturesNamesDataSelected[,2] )) 
  gFeatureNames <<- list(y= "Activity", subject =  "Subject",  x=as.vector(lFeaturesNamesData[,2]), allCols=lColNames, colSelected = lColSelected)
}

#Load Files 2 loops, 1.- test/train, 2.- x,y,subject 
readRawData<- function(){
  print("Reading Data Files") 
  gData <<- lapply(list(test="test",train="train"), 
                   function(aDataset){  
                     lapply(list(y="y",x="x",subject="subject"), 
                            function(aSrcFile){ 
                              print(paste("Loading DS:",aDataset,"-","SRC:",aSrcFile))
                              data <- read.table(paste("UCI HAR Dataset/", aDataset,"/",aSrcFile,"_", aDataset, ".txt",sep = ""))  
                              colnames(data) <- unlist(gFeatureNames[aSrcFile])
                              data
                            }
                     )  
                   }
  )
}

mergeRawData<- function(){ 
  print("Merging Data") 
  gData <<- lapply(gData, 
                   function(aDataset){   
                     aDataset$fullDataset <- data.frame(Reduce(cbind, c(aDataset$subject,aDataset$y ,aDataset$x) ) )
                     aDataset
                   }
  )
  gData$wholeData <<- rbind(gData$test$fullDataset,gData$train$fullDataset) 
  colnames(gData$wholeData) <<- unlist(gFeatureNames$allCols)
}


filterRawData<- function(){ 
  print("Filtering Data") 
  gData$filteredData <<-gData$wholeData[,unlist(gFeatureNames$colSelected)]
}

assignActivities <- function(){ 
  print("Assigning Descriptive Activities ") 
  gData$filteredData$Activity <<- factor(gData$filteredData$Activity,gLabels$id,gLabels$Activity)
}

labelingColumns <- function(){
  print("Labeling Columns") 
  gFeatureNames$colRenamed <<- gFeatureNames$colSelected;
  gFeatureNames$colRenamed <<- gsub("(\\w*)(-mean\\(\\))(\\w*)","\\1\\3-Mean",gFeatureNames$colRenamed, perl=T)
  gFeatureNames$colRenamed <<- gsub("(\\w*)(-std\\(\\))(\\w*)","\\1\\3-StdDev",gFeatureNames$colRenamed, perl=T)
  gFeatureNames$colRenamed <<- gsub("^t(\\w*)","\\1-Time",gFeatureNames$colRenamed, perl=T)
  gFeatureNames$colRenamed <<- gsub("^f(\\w*)","\\1-Freq",gFeatureNames$colRenamed, perl=T)
  gFeatureNames$colRenamed <<- gsub("(\\w*)\\-(\\w*)\\-([X|Y|Z])","*\\3*\\1-\\2",gFeatureNames$colRenamed, perl=T)
  gFeatureNames$colRenamed <<- gsub("\\-","",gFeatureNames$colRenamed, perl=T)
  gFeatureNames$colRenamed <<- gsub("\\*","_",gFeatureNames$colRenamed, perl=T)
  colnames(gData$filteredData) <<- unlist(gFeatureNames$colRenamed)
}

calcTidyDataset <- function(){
  idColumns <- c("Subject","Activity")
  measureColumns <- gFeatureNames$colRenamed[!gFeatureNames$colRenamed %in% c("Subject","Activity")]
  meltedData <-  melt(gData$filteredData, idColumns,measureColumns )
  gData$tidyData <<- dcast(meltedData, Subject + Activity ~ variable, mean)
}

storeDataset <- function(){
  write.table(gData$tidyData, file = "./tidyDataset.txt",row.name=FALSE)
}


##Prerequisites 
ensureDataFiles()
readLabelsAndFeaturesData() 

##Step 1
readRawData()
mergeRawData()

##Step 2
filterRawData()

##Step 3
assignActivities()

##Step 4
labelingColumns()

##Step 5
calcTidyDataset()
storeDataset()

View(gData$tidyData)

