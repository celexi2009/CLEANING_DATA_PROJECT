PROJECT INFORMATION: 
Class: Coursera Data Science Specialization, Johns Hopkins 
COURSE 3: Getting and Cleaning Data
Assignment: Final project
Name: RSJ
Date: May 14, 2022

INTRO:
This readme covers the project for the Getting and Cleaning Data course on Coursera. 

SOURCE CODE LANGUAGE AND ENVIRONNMENT
All source code is written in R using the R Studio environment.

VERSIONS: 
RStudio version: 
RStudio 2022.02.2+485 "Prairie Trillium" Release (8acbd38b0d4ca3c86c570cf4112a8180c48cc6fb, 2022-04-19) for Windows
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.12.8 Chrome/69.0.3497.128 Safari/537.36

R Version: 4.2.0 (2022-04-22 ucrt) -- "Vigorous Calisthenics"

LIBRARIES:
The libraries used in this project are: 
downloader 
plyr

DIRECTORY INFO: 
The code gets the current working directory and uses that as the base; edit the 
path variables to override this.

TEST CONVETIONL: 
Testing code is included throughout the .R file, but is commented out, with a 
comment above nothing what the code is intended to test. 

CODE DESCRIPTION 
The source file is run_analysis.R as prescribed in the project instructions and 
performs the following actions:

1. Loads required libraries
2. Sets path variables
3. Download the dataset if not already done, using same process shown in class. 
2. Check to see if the dataset zip file was already extracted, and extract it if not.
3. List contents of zip file 
4. Read the test and train files for activity, subject and features
5. Combine the test and train files using rbind()
6. Combine the merged subject, activity, and features into a data frame
7. Get the mean and standard deviation of each measurement
8. Subset the data frame to subject and activity
9. Assign readable labels and factor acccording to those
10. Label columns with abbreviations into usefule names
11. Write out a clean data set to the tidyData.txt file 

