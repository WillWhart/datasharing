README for the file run_analysis.R
submitted for data cleaning course
8/19/2014

This script is run without parameters
smallTidy <- run_analysis()
returning a small tidy data set and writing a larger one to disk

The script requires the following files from the Samsung data set in the working directory	
"y_test.txt"
"subject_test.txt"
"y_train.txt"
"subject_train.txt"
"features.txt"
"X_test.txt"
"X_train.txt"

Both tidy data structures had 68 columns, the subject index, activity index, and 66 measurements. The measurements,as well as explaining how I chose them,  are explained further in the file codebook.md

as a result, the tidy file written to disk has 10299 rows (and 68 columns). There are 10299 measurements (including training and test records)
The file written to disk (written to file "courseOutput.txt")
The tidy file returned by the call has 180 rows (1 for each of the 30 subject and 6 activity indices, as well as the average of each measurement (column) for the selected subject/activity pairs)


