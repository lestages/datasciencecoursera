## The following pulls in all the training data renames the columns headers and combines them

train_datax <- read.table('x_train.txt',)
col_names <- read.table('features.txt')
col_names2 <- col_names[,2]
colnames(train_datax) <- col_names2
train_datay <- read.table('y_train.txt',)
names(train_datay)[1] <- 'Activity'
train_data_sub <- read.table('subject_train.txt',)
names(train_data_sub)[1] <- 'Subject'
train_datasuby <- cbind(train_data_sub, train_datay)
train_data <- cbind(train_datasuby, train_datax)

## The following does the same for the test data

test_datax <- read.table('x_test.txt',)
colnames(test_datax) <- col_names2
test_datay <- read.table('y_test.txt',)
names(test_datay)[1] <- 'Activity'
test_data_sub <- read.table('subject_test.txt',)
names(test_data_sub)[1] <- 'Subject'
test_datasuby <- cbind(test_data_sub, test_datay)
test_data <- cbind(test_datasuby, test_datax)

## combining test and training data
train_test_data <- rbind(train_data, test_data)
head(train_test_data)


## naming the activities nicely
for(x in 1:10299){
if (train_test_data[x,2] == 5){ train_test_data[x,2] <- c('STANDING')}
if (train_test_data[x,2] == 1){ train_test_data[x,2] <- c('WALKING')}
if (train_test_data[x,2] == 2){ train_test_data[x,2] <- c('WALKING UPSTAIRS')}
if (train_test_data[x,2] == 3){ train_test_data[x,2] <- c('WALKING DOWNSTAIRS')}
if (train_test_data[x,2] == 4){ train_test_data[x,2] <- c('SITTING')}
if (train_test_data[x,2] == 6){ train_test_data[x,2] <- c('LAYING')}
}

## keeping just the means and std columns and Subject and Activiy of course
train_test_means <- train_test_data[grepl('\\bMean\\b|\\bstd\\b|\\bSubject\\b|\\bActivity\\b|\\bmean\\b', colnames(train_test_data))]


## Attempting to name the columns nicely. Never got it to work.
for(x in 1:89)
[
train_test_means[1,x]<-gsub("\\()","", train_test_means[1,x])
]

##averaging by subject and activity. 

data_summary <- train_test_means %>%
    group_by(Subject, Activity) %>%
    summarise_each(funs(mean), tBodyAccmean()-X:fBodyBodyGyroJerkMag-std())

