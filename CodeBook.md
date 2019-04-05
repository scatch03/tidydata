## Variables description
  * subjectId - unique id of test subject, which was source of data for activity 
  * activityDescription - human-radable subject activity label
  * rest of the colunds correspond one-to-one with columns from input data set having same name, only difference being that actual values represent means of measured values for each subject and activity combination.
  
# Data
 * Input data is provided from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
 * Resulting data can be found in _data/merged/meansBySubjectByActivity.csv_ file, which is result of launching _run_analysis.R_ script.

# Transformations applied to obtain resulting data
 * Load both training and testing data sets
 * Merge both loaded data sets with corresponding subject and activity, based on position in file.
 * Combine two data sets into one
 * Select only columns with mean and standart deviation for each measure, along with corresponding activity and subject id.
 * Calculate measure means within each activity and activity group.
 * Save result in CSV format into _data/merged/meansBySubjectByActivity.csv_ file.