

sudo touch /etc/profile.d/bigdata.sh
sudo chmod +x /etc/profile.d/bigdata.sh

#This new created file will maintain our environment variables

sudo echo -e '#!/bin/bash\n# Environment Variables for Big Data tools\n' | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null

export NameNodeDNS="ec2-52-47-114-249.eu-west-3.compute.amazonaws.com"
export DataNode001DNS="ec2-15-236-208-88.eu-west-3.compute.amazonaws.com"
export DataNode002DNS="ec2-35-180-159-161.eu-west-3.compute.amazonaws.com"
export DataNode003DNS="ec2-15-237-62-238.eu-west-3.compute.amazonaws.com"

export NameNodeIP="172.31.26.106"
export DataNode001IP="172.31.22.145"
export DataNode002IP="172.31.31.176"
export DataNode003IP="172.31.31.204"

export IdentityFile="~/.ssh/hadoop-aws.pem"

echo "# AmazonEC2 Variables START" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo "export NameNodeDNS=\"${NameNodeDNS}\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo "export DataNode001DNS=\"${DataNode001DNS}\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo "export DataNode002DNS=\"${DataNode002DNS}\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo "export DataNode003DNS=\"${DataNode003DNS}\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo "" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo -e "export NameNodeIP=\"${NameNodeIP}\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo -e "export DataNode001IP=\"${DataNode001IP}\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo -e "export DataNode002IP=\"${DataNode002IP}\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo -e "export DataNode003IP=\"${DataNode003IP}\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo -e "export IdentityFile=\"${IdentityFile}\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo -e "# AmazonEC2 Variables END" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null


# Following not to be executed all at once, but each one to its corresponding instance
publichost=${NameNodeDNS}
publichost=${DataNode001DNS}
publichost=${DataNode002DNS}
publichost=${DataNode003DNS}


# Reboot instances (DO NOT TERMINATE THEM)
# Test en variables

echo $publichost

sudo hostname ${publichost}

sudo rm -rf /etc/hostname
echo -e "${publichost}" | sudo tee --append /etc/hostname > /dev/null
sudo chown root /etc/hostname

# REBOOT
# Configure the /etc/hosts file

sudo rm -rf /etc/hosts
echo -e "127.0.0.1\tlocalhost" | sudo tee --append /etc/hosts > /dev/null
echo -e "127.0.1.1\t${publichost}" | sudo tee --append /etc/hosts > /dev/null
echo -e "${NameNodeIP}\thadoop-master" | sudo tee --append /etc/hosts > /dev/null
echo -e "${DataNode001IP}\tDataNode001" | sudo tee --append /etc/hosts > /dev/null
echo -e "${DataNode002IP}\tDataNode002" | sudo tee --append /etc/hosts > /dev/null
echo -e "${DataNode003IP}\tDataNode003" | sudo tee --append /etc/hosts > /dev/null
echo -e "\n# The following lines are desirable for IPv6 capable hosts" | sudo tee --append /etc/hosts > /dev/null
echo -e "::1 ip6-localhost ip6-loopback" | sudo tee --append /etc/hosts > /dev/null
echo -e "fe00::0 ip6-localnet" | sudo tee --append /etc/hosts > /dev/null
echo -e "ff00::0 ip6-mcastprefix" | sudo tee --append /etc/hosts > /dev/null
echo -e "ff02::1 ip6-allnodes" | sudo tee --append /etc/hosts > /dev/null
echo -e "ff02::2 ip6-allrouters" | sudo tee --append /etc/hosts > /dev/null
echo -e "ff02::3 ip6-allhosts" | sudo tee --append /etc/hosts > /dev/null
sudo chown root /etc/hosts

# REBOOT
sudo chmod 0400 ~/.ssh/config
sudo chmod 0400 ~/.ssh/hadoop-aws.pem



sudo rm -rf ~/.ssh/id_rsa*
sudo rm -rf ~/.ssh/known_hosts

ssh-keygen -f ~/.ssh/id_rsa -t rsa -P ""


sudo chmod 0600 ~/.ssh/id_rsa.pub
sudo cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


hosts=0.0.0.0,127.0.0.1,127.0.1.1,hadoop-master,DataNode001,DataNode002,DataNode003
ssh-keyscan -H ${hosts} >> ~/.ssh/known_hosts

# Only on NAMENODE
sudo cat ~/.ssh/id_rsa.pub | ssh -o StrictHostKeyChecking=no DataNode001 'cat >> ~/.ssh/authorized_keys'
sudo cat ~/.ssh/id_rsa.pub | ssh -o StrictHostKeyChecking=no DataNode002 'cat >> ~/.ssh/authorized_keys'
sudo cat ~/.ssh/id_rsa.pub | ssh -o StrictHostKeyChecking=no DataNode003 'cat >> ~/.ssh/authorized_keys'

# TESTS 

ssh -o StrictHostKeyChecking=no localhost
exit

ssh -o StrictHostKeyChecking=no hadoop-master
exit

ssh -o StrictHostKeyChecking=no DataNode001
exit

ssh -o StrictHostKeyChecking=no DataNode002
exit

ssh -o StrictHostKeyChecking=no DataNode003
exit

# If something went wrong during your SSH setup, run the following code to reset SSH and start over:

filename=~/.ssh/authorized_keys
line=$(head -1 ${filename})
echo $line

sudo rm -rf ${filename}
echo -e "${line}" | tee --append ${filename} > /dev/null
sudo chmod 0600 ${filename}

sudo rm -rf ~/.ssh/id_rsa*
sudo rm -rf ~/.ssh/known_hosts
ssh-keygen  -f ~/.ssh/id_rsa -t rsa -P ""
sudo chmod 0600 ~/.ssh/id_rsa.pub
sudo cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
sudo chmod 0600 ~/.ssh/authorized_keys
sudo chmod 0400 ~/.ssh/config
sudo chmod 0400 ~/.ssh/hadoop-clusterkeypair.pem

hosts=0.0.0.0,127.0.0.1,127.0.1.1,hadoop-master,DataNode001,DataNode002,DataNode003
ssh-keyscan -H ${hosts} >> ~/.ssh/known_hosts

sudo service ssh restart


########################################

# Install Java Developers Kit (JDK)

sudo apt-get -y update
sudo apt-get install openjdk-8-jdk


# Add Environment Variables to /etc/profile.d/bigdata.sh
echo "# JAVA Variables START" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64i" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo "PATH=\$PATH:\$JAVA_HOME/bin" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
echo "# JAVA Variables END" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
# Confirm that your Java variables were added, open the /etc/profile.d/bigdata.sh file:

sudo gedit /etc/profile.d/bigdata.sh
sudo reboot
java -version
echo $JAVA_HOME 
# Displays something similar to this:
# /usr/lib/jvm/default-java



# Download Hadoop from Apache

wget https://archive.apache.org/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz -P ~/Downloads/Hadoop


sudo tar -zxvf ~/Downloads/Hadoop/hadoop-*.tar.gz -C /usr/local
sudo mv /usr/local/hadoop-* /usr/local/hadoop


sudo echo -e "# HADOOP Variables START" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
sudo echo -e "export HADOOP_HOME='/usr/local/hadoop'" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
sudo echo -e "export HADOOP_CONF_DIR=\"\${HADOOP_HOME}/etc/hadoop\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
sudo echo -e "export HADOOP_DATA_HOME=\"\${HOME}/hadoop_data/hdfs\"" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
sudo echo -e "PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null
sudo echo -e "# HADOOP Variables END" | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null

# Run node
start-dfs.sh

# Test health of node by going to "<public DNS address>:50070"

# FROM ONE NODE TO MULTI NODE

# In CORE-SITE.XML
  <property>

    <name>thisnamenode</name>

    <value>${NamandeNodeDNS}</value>

    <description>NameNode is the hostname specified in the config file and etc/hosts file. It may be replaced with a DNS that points to your NameNode.</description>

  </property>

# In YARN-SITE.XML

  <property>

    <name>mapred.job.tracker</name>

    <value>${thisnamenode}:9001</value>

  </property>

# In HDFS-SITE.XML

  <property>

    <name>dfs.replication</name>

    <value>3</value>

    <description>Default block replication.

The actual number of replications can be specified when the file is created.

The default is used if replication is not specified in create time.

    </description>

  </property>


# Copy configuration files to all Nodes
cd $HADOOP_CONF_DIR
scp hadoop-env.sh core-site.xml hdfs-site.xml mapred-site.xml DataNode001:$HADOOP_CONF_DIR
scp hadoop-env.sh core-site.xml hdfs-site.xml mapred-site.xml DataNode002:$HADOOP_CONF_DIR
scp hadoop-env.sh core-site.xml hdfs-site.xml mapred-site.xml DataNode003:$HADOOP_CONF_DIR

# We need to create a .masters file. It needs to exist on any of the nodes that
# are designated as namenode. Our "hadoop-master" is one, and we are going to
# designate the DataNode001 as the second namenode.

sudo rm -rf $HADOOP_CONF_DIR/masters

echo -e "hadoop-master" | sudo tee --append $HADOOP_CONF_DIR/masters > /dev/null
echo -e "DataNode001" | sudo tee --append $HADOOP_CONF_DIR/masters > /dev/null

# Change ownership for new master files (namenode + DataNode001)
# Set ownership and permissions to the root (ubuntu on Amazon EC2 or root on VMWare) owner:

sudo chown ubuntu $HADOOP_CONF_DIR/masters
sudo chmod 0644 $HADOOP_CONF_DIR/masters

# OR (instead of having to redo the same thing manually on other terminal)
scp $HADOOP_CONF_DIR/masters DataNode001:$HADOOP_CONF_DIR

# Configure .slaves File (in $HADOOP_CONF_DIR/slaves)
# Add following:
DataNode001
DataNode002
DataNode003

# By executing this:

sudo rm -rf $HADOOP_CONF_DIR/slaves
echo -e "DataNode001" | sudo tee --append $HADOOP_CONF_DIR/slaves > /dev/null
echo -e "DataNode002" | sudo tee --append $HADOOP_CONF_DIR/slaves > /dev/null
echo -e "DataNode003" | sudo tee --append $HADOOP_CONF_DIR/slaves > /dev/null

# Set ownership and permissions

sudo chown ubuntu $HADOOP_CONF_DIR/slaves
sudo chmod 0644 $HADOOP_CONF_DIR/slaves

# Copy the slaves file to each Node in your cluster

scp $HADOOP_CONF_DIR/slaves DataNode001:$HADOOP_CONF_DIR
scp $HADOOP_CONF_DIR/slaves DataNode002:$HADOOP_CONF_DIR
scp $HADOOP_CONF_DIR/slaves DataNode003:$HADOOP_CONF_DIR

# Set permission on every node

sudo chown ubuntu $HADOOP_CONF_DIR/slaves
sudo chmod 0644 $HADOOP_CONF_DIR/slaves

# Copy the slaves file to each Node in your cluster

scp $HADOOP_CONF_DIR/slaves DataNode001:$HADOOP_CONF_DIR
scp $HADOOP_CONF_DIR/slaves DataNode002:$HADOOP_CONF_DIR
scp $HADOOP_CONF_DIR/slaves DataNode003:$HADOOP_CONF_DIR

# Formatting multi-node hadoop Cluster

sudo rm -rf $HADOOP_DATA_HOME
sudo rm -rf $HADOOP_HOME/logs
hdfs namenode -format

# SOURCE: https://klasserom.azurewebsites.net/Lessons/Binder/1960
