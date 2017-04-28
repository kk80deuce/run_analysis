# run_analysis
This is my project from the course Getting and Cleaning Data

This project involves merging several txt files to form a coherent data table.
Most of the data files were split into a training set and a test set for Machine learning analysis.
Following are the steps I used to arrange the data table.
1. Rowbind X_training and X_test into x_total
2. Read the fetures file, transpose it, and remove one row so that I just have a row of column names
3. change the column names in x_total to feature_trans so the names are meaningful
4. removed all columns from x_total that don't contain the words "mean", "Mean", or "std".  Called that x_trunc.
5. Rowbind y_training and y_test into y_total.  This file is numbers for the six different activities.
6. Changed the name of column heading in y_total to "activity" so that it is meaningful.
7. Replaced the activity number in y_total with the actual activity name (i.e. "walking", "sitting",...)
8. Rowbind subject_training and subject_test into subject_total.  This is numbers 1 thru 30 corresponding to subject's in test.
9. Column bind subject numbers to the front of x_total, and activity names to the last column of x_total.
10. Grouped xy_grouped by subject number and activity
11. Found the mean by those groupings and wrote file to final_table.txt
