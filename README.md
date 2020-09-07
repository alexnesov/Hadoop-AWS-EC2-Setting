# Hadoop-AWS-EC2-Setup
Hadoop-AWS-EC2-Setup


<h4> About the environnement variables: </h4>

We create a file called ```bigdata.sh``` in ```/etc/profile.d```, that we transform as an executable through the following command: </br>
```sudo chmod +x /etc/profile.d/bigdata.sh```.</br> 
Creating such an executable is handy since this file will be executed at every instance reboot, making these enironnement variables persistent. Indeed,```/etc/profile``` and ```/etc/profile.d``` both contain startup files..
