USE test_inc_partition;

drop table incremental;

!sudo hadoop fs -rm -r /user/hive/incremental;

CREATE EXTERNAL TABLE incremental (
ID int, 
Name string,
Contact_No bigint,
Time_Stamp string
)
PARTITIONED BY (
Date date
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/user/hive/incremental';

load data inpath '/user/cloudera/incremental_table' into table incremental partition (Date='2018-09-24');

DROP TABLE students_temp;

!sudo hadoop fs -rm -r /user/hive/students_temp;

CREATE EXTERNAL TABLE students_temp (
ID int, 
Name string,
Contact_No bigint,
Time_Stamp string
)
PARTITIONED BY (
Date date
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/user/hive/students_temp';

SET hive.exec.dynamic.partition = true;					
SET hive.exec.dynamic.partition.mode = nonstrict;

insert into students_temp partition (Date) select t1.* from (select * from students union all select * from incremental) t1 join (select ID, max(Time_Stamp) as last_update_date from (select * From students union all select * From incremental ) t2 group by ID) t3 on t1.ID = t3.ID and t1.Time_Stamp = t3.last_update_date;

DROP TABLE students;

--!sudo hadoop fs -rm -r /user/hive/base;

CREATE TABLE students as SELECT * from students_temp;
select * from students;
