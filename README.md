### DataCleaningWeek4 folder contains:  
* a) This readme.md file;  
* b) run_analysis.R script with step by step descriptions on how data from Week 4 assignment was read/manipulated/summarized;
* c) Codebook to describe variables in summarised dataset (saved and submitted as summarised_done.txt)

In this assignment, we have been provided an url link to a zip file which had to be unzipped into a folder on local working directory.
 
This folder contains two subfolders with similar txt files for 
* a) Observations measures on 561 variables; 
* b) Subjects (persons who were providing observations), 30 in total
* c) Activities for subjects which were of 6 different types

Two subforders are "test" and "train" which were eventually merged into a single dataset.

As per assignment, this merged dataset had to be filtered to contain only the measurements for mean() and str()
Variable value names had to be imported from a separate file (features.txt) and tidied. 

The resulting table is a summary of "mean value" statistics on all observations (which totalled 10299) and selected variables (see above), factored by activity description and subject code. Note: activity descriptions were pulled from a separate txt file and merged with a summarised dataset. 

Received summarised dataset contains 180 rows which have a combination of 6 activities for 30 subjects, and "mean value" summaries for observations on 64 variables. Note: filtering eliminated variables that contained meanFreq().
