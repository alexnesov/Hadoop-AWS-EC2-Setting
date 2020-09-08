# Hadoop-AWS-EC2-Setup
This repo contains tools to set up and run a Hadoop Cluster, and also more specifically on AW EC2.


<h4> About the environnement variables: </h4>

We create a file called ```bigdata.sh``` in ```/etc/profile.d```, that we transform as an executable through the following command: </br>
```sudo chmod +x /etc/profile.d/bigdata.sh```</br></br> 
Creating such an executable is handy since this file will be executed at every instance reboot, making these enironnement variables persistent. Indeed,```/etc/profile``` and ```/etc/profile.d``` both contain startup files.

More informations about ```/etc/profile``` <a href="http://www.linuxfromscratch.org/blfs/view/6.3/postlfs/profile.html">here</a>

</br>
Stopping an AWS EC2 instance resets the DNS. Hence, Hadoop will require us to adjust this. Here again, we see the usage of such a file, faciliting our life for continuous adjustements.

<h4> MySQL installation for Hive Metastore</h4>

```
sudo apt-get install mysql-server
sudo apt-get install libmysql-java
```
</br>
<strong>Soft link for connector in Hive lib directory (or copy jar to lib folder)</strong>
</br>
```
ln -s /usr/share/java/mysql-connector-java.jar $HIVE_HOME/lib/mysql-connector-java.jar
mysql -u root -p
mysql> CREATE DATABASE metastore;
mysql> USE metastore;
mysql> SOURCE /home/ubuntu/hive/scripts/metastore/upgrade/mysql/hive-schema-0.14.0.mysql.sql;
```

</br>
<strong>Account creation:</strong>
</br>
```
CREATE USER 'hiveuser'@'%' IDENTIFIED BY 'hivepassword';
GRANT all on *.* to 'hiveuser'@localhost identified by 'hivepassword';
flush privileges;
```

Configure ```hive-site.xml``` in ```$HIVE_HOME/conf```:

```
<configuration>
   <property>
      <name>javax.jdo.option.ConnectionURL</name>
      <value>jdbc:mysql://localhost/metastore?createDatabaseIfNotExist=true</value>
      <description>metadata is stored in a MySQL server</description>
   </property>
   <property>
      <name>javax.jdo.option.ConnectionDriverName</name>
      <value>com.mysql.jdbc.Driver</value>
      <description>MySQL JDBC driver class</description>
   </property>
   <property>
      <name>javax.jdo.option.ConnectionUserName</name>
      <value>hiveuser</value>
      <description>user name for connecting to mysql server</description>
   </property>
   <property>
      <name>javax.jdo.option.ConnectionPassword</name>
      <value>hivepassword</value>
      <description>password for connecting to mysql server</description>
   </property>
</configuration>
``` 
