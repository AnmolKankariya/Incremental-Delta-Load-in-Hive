echo "Enter your name:"
read name

echo "Welcome $name!"
echo "Do you want incrementally appended rows?"
read user_input

if [ $user_input == "Yes" -o $user_input == "yes" -o $user_input == "y" ]
then
	read -p "Enter the last value for timestamp : " ts
	sqoop import --connect jdbc:mysql://localhost/ak --username root --password cloudera --table students --target-dir /user/cloudera/incremental_table -m 1 --check-column Time_Stamp --incremental append --last-value "$ts"
	echo "Executing hive script...."
	hive -f part.hql
	echo "Executed Successfully!"
else
	echo "Thanks! for visiting warehouse"
fi



