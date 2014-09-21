#run_analysis.R
==================================================================
run_analysis.R takes the data from the following location: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  and produces a clean data frame for the mean and standard deviation, for each subject and activity.
Information on how this dataset was originally gathered is provided in the README.txt file in the above file.

The script asssumes that the data are maintained in the same file structure as it is in the zipped download, and that the file is in the working directory.

The script requires the reshape2 package to be installed. It will load this at the start. It loads in the neccessary files from the downloaded data, and renames columns of the X Test and Train datasets using the features document. It also renames other columns to be meaningful for the Y test and train sets and the Activity table. 

An additional, empty column is added to the Y test and train sets. 

The X,Y and subject tables are joined for the test and train sets, and an additional column is added to the end of each marking whether it is the test or train set (this is for reference if the sets ever need to be seperated). 

The Test and Train data frames are then joined, and the empty Activity.Name column is filled using the Activity dataframe.

A regex search is then used to seperate the mean and stand deviation values. N.B. the mean does not include mean Freq and gravityMean.

Finally a new dataframe is created which includes the mean for each subject and activity for each variable. This new dataframe is written to a file called run_analysis.txt