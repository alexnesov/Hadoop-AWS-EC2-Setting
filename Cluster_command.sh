export NameNodeDNS="ec2-15-236-145-148.eu-west-3.compute.amazonaws.com"
export DataNode001DNS="ec2-15-188-193-3.eu-west-3.compute.amazonaws.com"
export DataNode002DNS="eec2-52-47-198-7.eu-west-3.compute.amazonaws.com"
export DataNode003DNS="ec2-35-180-253-225.eu-west-3.compute.amazonaws.com"

export NameNodeIP="172.31.22.1"
export DataNode001IP="172.31.16.78"
export DataNode002IP="172.31.20.78"
export DataNode003IP="172.31.21.161"

export IdentityFile="~/.ssh/hadoop-aws.pem"




sudo touch /etc/profile.d/bigdata.sh
sudo chmod +x /etc/profile.d/bigdata.sh


#This file will maintain our environment variables

sudo echo -e '#!/bin/bash\n# Environment Variables for Big Data tools\n' | sudo tee --append /etc/profile.d/bigdata.sh > /dev/null

export NameNodeDNS="ec2-15-236-145-148.eu-west-3.compute.amazonaws.com"
export DataNode001DNS="ec2-15-188-193-3.eu-west-3.compute.amazonaws.com"
export DataNode002DNS="eec2-52-47-198-7.eu-west-3.compute.amazonaws.com"
export DataNode003DNS="ec2-35-180-253-225.eu-west-3.compute.amazonaws.com"

export NameNodeIP="172.31.22.1"
export DataNode001IP="172.31.16.78"
export DataNode002IP="172.31.20.78"
export DataNode003IP="172.31.21.161"

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

