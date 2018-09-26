# Incremental/Delta-Load-in-Hive
This repository contains the solution for incremental/delta load in hive using partitioning.

Delta load in hive is a major problem faced by industries and only few approaches were there to perform this in hive.
One of those approch will give more optimal result with no performance issues.

You will find two files inside repository- 

      incremental.sh - A Shell script that contains relevant command to automate the process.
  
      part.hql - A hive query file that contains commands to perform dynamic partitioning.
      
Steps to perform incremental append-
1. Create a partitioned table in hive.
            Example:
            
            CREATE EXTERNAL TABLE base_table (
            ID int, 
            Name string,
            Contact_No bigint,
            Time_stamp string
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '/user/hive/base_table';

2. Load the data from your database initially.
3. Give permission to user/hive directory using following command:
      
            sudo hadoop fs -chmod 777 /user/hive/directory_name
      
      Note: Instead of 777, Admin can give permissions according to user's privileges.
4. Move both files into the same folder.
5. Run the script and check incremented rows.

Note: Make sure that the new rows were inserted in the source database otherwise you may get an error.      
