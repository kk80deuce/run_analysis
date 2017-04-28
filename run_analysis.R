
library(dplyr)
# READ and ROW BIND X_train and X_test
x_train <- read.table('X_train.txt')
x_test <- read.table('X_test.txt')
x_total <- rbind(x_train, x_test)

# READ features.txt, transpose features.txt, delete row 1 so we have 1 row of names
features <- read.table('features.txt')
feature_trans <- t(features)
feature_trans <- feature_trans[-1,]

# change column names of x_total to the name in feature_trans
names(x_total) <- feature_trans

# select columns with only "mean", "std", or "Mean"
x_trunc <- x_total[grepl("mean", names(x_total)) | grepl("std", names(x_total)) | grepl("Mean", names(x_total))]
dim(x_trunc)
names(x_trunc)

# READ and ROW BIND y_train and y_test
y_train <- read.table('y_train.txt')
y_test <- read.table('y_test.txt')
y_total <- rbind(y_train, y_test)

# change column name of y_total to something meaningful
names(y_total) <- "activity"
y_total[1,1] <- 5    #fix strange symbol in row 1 

# READ activity_labels.txt, name the columns something meaningful
activity_labels <- read.table('activity_labels.txt')
names(activity_labels) <- c("activity", "type")

# replace activity number with actual activity name, delete column 1, left with a column of activity names
activity_name <- y_total %>% mutate("type" = ifelse(activity == 1, "walking", ifelse(activity==2, "walking_upstairs", ifelse(activity==3, "walking_downstairs", ifelse(activity==4, "sitting", ifelse(activity==5, "standing", ifelse(activity==6, "laying", 0)))))))
activity_name <- activity_name[,-1]

# READ and ROW BIND subject_train and subject_test
subject_train <- read.table('subject_train.txt')
subject_test <- read.table('subject_test.txt')
subject_total <- rbind(subject_train, subject_test)

# change column name to something meaningful
names(subject_total) <- "subject_number"

# fix strange symbol in row 1 and row 7353
subject_total[1,1] <- 1
subject_total[7353,1] <- 2

# COLUMN BIND subject_total with x_total
x_with_subjects <- cbind(subject_total, x_trunc)

# COLUMN BIND x_with_subjects and y_tot
xy_with_subjects <- cbind(x_with_subjects, activity_name)
print(xy_with_subjects$subject_number)

# Group data set by subject number and activity name
xy_grouped <- group_by(xy_with_subjects, subject_number, activity_name)

# new tidy data set with the average of all the columns
xy_grouped_mean <- summarise_each(xy_grouped, funs(mean))

write.table(xy_grouped_mean, 'final_table.txt', row.names = FALSE)

