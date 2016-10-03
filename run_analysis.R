train<-read.table('train/X_train.txt')
train_label<-read.table('train/Y_train.txt')
test<-read.table('test/X_test.txt')
test_label<-read.table('test/y_test.txt')
subject1<-read.table('train/subject_train.txt')
subject2<-read.table('test/subject_test.txt')
subject<-rbind(subject2,subject1)
activities<-c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
for(i in 1:6) {train_label[train_label==i]<-activities[i]}
for(i in 1:6) {test_label[test_label==i]<-activities[i]}
labeltrain<-cbind(train_label,train)
labeltest<-cbind(test_label,test)
Mergedata<-rbind(labeltest,labeltrain)
Mergedata<-cbind(subject,Mergedata)
dnames<-read.table('features.txt')
dnames1<-dnames[,2]
dnames1<-as.character(dnames1)
dnames1<-c("Subject", "Activity",dnames1)
names(Mergedata)<-dnames1
Mergedata<-Mergedata[,!duplicated(colnames(Mergedata))]
cdata<-select(Mergedata,Subject,Activity,contains('mean'),contains('std'))
gdata<-group_by(cdata,Subject,Activity)
sdata<-summarise_each(gdata,funs(mean))
