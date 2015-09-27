# Introduction

* 1th step: Use rbind() function merge all the similar data; all those files have same columns and same means .
* 2th step: Only extract mean and sd measurement from the dataset;give the correct names,by names in "feature.txt"
* 3th step: Activity data have six states labeled by  1:6,we will replace them by the activity names and IDs from "activity_labels.txt"
* 4th step: The whole dataset colume names are corrected,  use the activity names and IDs from `activity_labels.txt`
* 5th step:  Generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows),called `averages_data.txt` 


# Variables

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `X_data`,`x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in `mean_and_std_features`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.
* `All_data` merges `X_data`, `y_data` and `subject_data` in a big dataset
* Finally, `averages_data` contains the relevant averages which will be later stored in a `.txt` file. `ddply()` from the plyr package is used to apply `colMeans()` and ease the development.
