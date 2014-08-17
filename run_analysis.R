## This is the main function to get and clean data. The files are all assumed to be
## in the current directory
run_analysis <- function ()
{
	## 1) Merges the training and the test sets to create one data set.
	## next, get the subject and activity information
	activityTest <- scan("y_test.txt")
	subjectTest  <- scan("subject_test.txt")
	## get the training data
	activityTrain <- scan("y_train.txt")
	subjectTrain  <- scan("subject_train.txt")
	## merge the Test data to the Training data and make an activity vector 
	## and a subject vector
	activity <- c (activityTrain, activityTest)
	subject <- c (subjectTrain, subjectTest)

	## Get the data
	## Get the labels for the data
	labels <- read.table ("features.txt")
	useLabels <- c("subject","activity",as.vector(labels[,2]))
	## Determine the number of columns in the data frame.
	## the first 2 columns are integers (subject and activity),
	## while the rest are real numeric (data)
	numColumns <- length(useLabels)
	## while the number of rows will be the number of data entries
	numRows <- length (activity)

	## And read the measurements
	dataTest <- read.table("X_test.txt")
	dataTrain <- read.table("X_train.txt")
	data <- rbind(dataTrain,dataTest)

	## next, add the subject and activity to the table
	fullData <- cbind(subject,activity,data)

	## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
	## Next, just find the labels whose name includes 
	## "mean(" or "std("
	indices <- grepl("mean(",labels[,2],fixed=TRUE) | grepl("std(",labels[,2],fixed=TRUE)
	## and label subject and activity "TRUE"
	useIndices = c(TRUE,TRUE,indices)
	## 3) Uses descriptive activity names to name the activities in the data set
	## 4) Appropriately labels the data set with descriptive variable names. 
	names(fullData) <- useLabels
	## Finally, remove the unwanted elements from the return labels
	returnLabels = useLabels[useIndices]

	selectedData <- fullData[,useIndices]

	## Finally, set up the return table. This will be 
	## a structure like the data, but with only 1 entry
	## for each subject/activity pair, or 30*6 =180
	numUniqueSubjects <- length(unique(subject))
	numUniqueActivities <- length(unique(activity))

	uniqueSubject <- sort(unique(subject))
	uniqueActivity <- sort(unique(activity))
	numberIndices <- length(returnLabels)

	## 5) Creates a second, independent tidy data set with the average of each variable 
	##    for each activity and each subject. 

	## Use a copy of a slice of the selected data for the tidy data
	tidyData <- selectedData[1:uniqueSubject*uniqueActivity,]

	## and get the means of the columns
	counter = 1
	for (i in uniqueSubject) { 
		for (j in uniqueActivity) {
			tidyData[counter,1] <- i
			tidyData[counter,2] <- j
			## Compute the mean for each of the colums
			tidyData[counter,3:numberIndices] <-
			colMeans(selectedData[
			selectedData[,1] == i & selectedData[,2] == j,3:numberIndices])
			counter <- counter + 1
		}
	}
	##  Write the table to a file. Exclude 
	write.table(tidyData, file = "courseOutput.txt",row.names = FALSE, col.names=FALSE )

	return(tidyData)
}
