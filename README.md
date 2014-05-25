README file for run_analysis.R
======================================================================================

This file provides a brief description and instructions for running the "run_analysis.R" program. The "run_analysis.R"  program creates a tidy data set that contains the summary of selected measurements from the raw data. The raw data is obtained from the "UCI HAR Dataset". The "run_analysis.R" program assumes that the "UCI HAR Dataset", containing all the required data, is available in the directory that contains the "run_analysis.R" program file.

#### Instructions for downloading raw data

If "UCI HAR Dataset" is not available or does not contain all required raw data files, the user may download the raw files and unzip them by uncommenting the lines 11 to 14 in "run_analysis.R" and then execute the program.

#### Files used

For the creation of the tidy data set, "run_analysis.R" uses the following files in the "UCI HAR Dataset" folder

* 'train/X_train.txt'                   -- Contains raw training data obtained from measurements
* 'train/y_train.txt'                   -- Contains activity code corrresponding to observations in X_train.txt
* 'train/subject_train.txt'             -- Contains subject code corresponding to observations in X_train.txt         
* 'test/X_test.txt'                     -- Contains raw test data obtained from measurements
* 'test/y_test.txt'                     -- Contains activity code corrresponding to observations in X_test.txt
* 'test/subject_test.txt'               -- Contains subject code corresponding to observations in X_test.txt  
* features.txt                          -- List of features (column names) for raw training and test data
* activity_labels.txt                   -- Contains activity names corresponding to activity codes

For further details on the raw data, refer to the README.txt file in the "UCI HAR Dataset" folder.

#### Note on variable names

In the case of  small variable names, lower case is used. For medium to large variable names, camel case is used for the sake of readability. While lower case naming convention has been recommended (whenever possible) in the lecture notes, the R style guide from Google ("https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml#identifiers") suggests that camel case is also acceptable. 

#### Selection of measurements for tidy data set

The raw data contains measurements of 561 variables. Of these, only variables that are either a "mean" or "standard deviation (std)" estimate of the raw signals is considered for the summary. These variables contain either "mean()" or "std()" in their names. 

Variables that are weighted average estimates (for example, those with "meanFreq()" in their names) are ignored for the summary. Variables (with "Mean" in their names) used for computation of "angle" variables are also not considered for the summary.

#### What run_analysis.R does

The "run_analysis.R" performs the following operations

1. Collates data from "X_train.txt" with "activity" (from "y_train.txt") and "subject" (from "subject_train.txt") data to create a "merged train" data set.

2. Combines data from "X_test.txt" with "activity" (from "y_test.txt") and "subject" (from "subject_test.txt") data to create a "merged test" data set.

3. Creates a combined data set by merging "merged train" and "merged test" data.

4. Extracts only the "mean" and "std" measurement data (as explained in section "Selection of measurements for tidy data") from the combined data set ("meanStdData").

5. Replaces "activity" code (numeric) in "meanStdData" with descriptive activity names provided in "activity_lables.txt".

6. Cleans up variable names (removes special characters like "-" and "()") and creates descriptive names for variables in "meanStdData". 

7. Calculates the mean values, by activity for all subjects, of the variables in "meanStdData". Adds a prefix "avg" to denote that these computed variables are average (or mean) of underlying variables.

8. Creates a tidy data set using the mean values and apprporiate variable names.

9. Writes out "tidydata.txt"  containing  the tidy data set in the same folder that includes "run_analysis.R" and prints "Tidy data set has been created" on the console.



