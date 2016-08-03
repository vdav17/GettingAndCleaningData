To get the two tidy data sets just 
	- Open R Studio
	- Open the file called: run_analysis.R
	- Run the script
	- Check the result csv files in th actual working directory

Notes
	- The result files are called final.csv and final_mean.csv in ./data/UCI HAR Dataset/ folder
	
	
	
	The script run_analysis.R does the following:

- Load needed libraries
- Download DataSet and unzip
- Load the activity labels in a data frame
- Load the features names in features data frame
- Load ´x´ test data (features)
- Load ´y´ test data (activities)
- Load the test subject data 
- Load ´x´ train data (features)
- Load ´y´ train data (activities)
- Load the train subject data 
- Merge train and test data for features
- Change the names of the merged features for significant ones contained in features data frame
- Merge activities data for train and test
- Merge the subject train and test data
- Add auxiliar row int field to join later
- Add activity names to merged activities 
- Assign significant names to subject data columns
- Create final dataset joining  activity set with feature set
- Extract only mean and std dev
- Join subject information
- Write data set as csv
- Group by subject and activity to create another dataset with the variable means
- Create a new csv with summarized data

