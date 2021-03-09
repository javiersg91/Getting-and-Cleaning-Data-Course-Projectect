# Getting-and-Cleaning-Data-Course-Projectect
Coursera Assignment
Script reads and stores all the data first, with the functions read.table and 
read.csv, and merge them with the function bind_row from the dplyr library. 
It uses the function select (also from dplyr) in order to filter the requested
data and the function gsub in order to rename the variables. 
The script uses the aggregate function at the end in order to summarize the
results of all the variables as requested. 

Variables used to store data: 
features
data.subject.test
data.x.test
data.y.test
data.subject.train
data.x.train
data.y.train

variables used to merge data: 
data.test
data.train
data

variable used to rename variables:
name.new

variable to store final result: 
final.table