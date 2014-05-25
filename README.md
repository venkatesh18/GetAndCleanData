### README file for run_analysis.R

This file provides the instructions for running the "run_analysis.R" program. The "run_analysis.R"  program creates a tidy data set that contains the summary of selected measurements from the raw data. The raw data is obtained from the "UCI HAR Dataset". The "run_analysis.R" program assumes that the "UCI HAR Dataset", containing all the required data, is available in the directory that contains the "run_analysis.R" program file. If the data set is not available or does not contain all required raw data files, the user may download the raw files and unzip them by uncommenting the lines 11 to 14 in "run_analysis.R" and then execute the program.

For the creation of the tidy data set, "run_analysis.R" uses the following files in the "UCI HAR Dataset" folder

* X_train.txt            -- Contains raw training data obtained from measurements
* y_train.txt            -- Contains activity code corrresponding to observations in X_train.txt
* subject_train.txt      -- Contains subject code corresponding to observations in X_train.txt         
* X_test.txt             -- Contains raw test data obtained from measurements
* y_test.txt             -- Contains activity code corrresponding to observations in X_test.txt
* subject_test.txt       -- Contains subject code corresponding to observations in X_test.txt  
* features.txt           -- List of features (column names) for raw training and test data
* activity_labels.txt    -- Contains activity names corresponding to activity codes

For more information on the raw data, refer to the README file in the "UCI HAR Dataset" folder.

#### Note on variable names
In the case of  small variable names, lower case is used. For medium to large variable names, camel case is used for the sake of readability. 

