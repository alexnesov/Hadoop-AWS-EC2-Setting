

sudo touch /etc/profile.d/bigdata.sh
sudo chmod +x /etc/profile.d/bigdata.sh

#This new created file will maintain our environment variables

sudo echo -e '#!/bin/bash\n# Environment Variables for Big Data tools\n' | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null

export NameNodeDNS="ec2-35-180-126-36.eu-west-3.compute.amazonaws.com"
export DataNode001DNS="ec2-15-188-76-198.eu-west-3.compute.amazonaws.com"
export DataNode002DNS="ec2-15-236-212-130.eu-west-3.compute.amazonaws.com"
export DataNode003DNS="ec2-15-188-238-197.eu-west-3.compute.amazonaws.com"

export NameNodeIP="172.31.25.115"
export DataNode001IP="172.31.26.106"
export DataNode002IP="172.31.31.84"
export DataNode003IP="172.31.18.111"

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


# SOURCE: https://klasserom.azurewebsites.net/Lessons/Binder/1960
