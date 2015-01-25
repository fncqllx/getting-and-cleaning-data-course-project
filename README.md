# getting-and-cleaning-data-course-project
This is for the course project getting and cleaning the Samsung data. All five steps are finished. 
Step 1: x_test, y_test, subject_test, x_train, y_train, subject_train are all merged into one file. Read and used V2 values from feature.txt as variable names for the combined file. 
Step2: subset the data frame with only the measurements on the mean and standard deviation for each measurement. Subject and label columns are kept
Step3: replaced activity numbers "1, 2, 3.." with more descriptive activity names like "walking" or "sitting". 
Step4: Renamed variables by removing (), - and space. Capitalized mean and std 
Step 5: created tidy2 by using summarize_each function from dplyr package. Used write.table to save tidy2 as a text file. 
Spend a whole sunday for this, and missed a brunch and a haircut appt. Have mercy!
