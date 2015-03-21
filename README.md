

# gettingandcleaningdata3

##the script follows the instructions given


###0. things to do first: install package, download file, reading data into file

###download file 

###unzip the file

##Reading data from the files into the variables

###1. Merging the training and the test sets to create one data set

###1.1 Concatenate the data tables by rows

###1.2 Applying names to the tables

###1.3 Merging columns to get the data frame Data for all data; wanted to use merge but no Ids, so maybe cbind is okay???

##checking the dataset


###2. Extracting measurements for mean and standard deviation for each measurement

##using grep to extract all variables with "mean" or "std" in it; making a vector and using this vector to subset the dataset.

###3. Giving descriptive activity names using the activity_labels txt-file

##Importing descriptive activity names from activity_labels.txt file

##applying levels and lables

###4. Giving labels with desciptive names

###5. Making another data set (tidy data set) with the mean of every variable for each activity and each subject using the aggregate function; then exporting it to a txt-file and a csv-file.

