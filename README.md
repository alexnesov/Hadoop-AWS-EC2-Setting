# Hadoop-AWS-EC2-Setup
This repo contains tools to run a Hadoop Cluster, and also more specifically on AW EC2.


<h4> About the environnement variables: </h4>

We create a file called ```bigdata.sh``` in ```/etc/profile.d```, that we transform as an executable through the following command: </br>
```sudo chmod +x /etc/profile.d/bigdata.sh```</br></br> 
Creating such an executable is handy since this file will be executed at every instance reboot, making these enironnement variables persistent. Indeed,```/etc/profile``` and ```/etc/profile.d``` both contain startup files.

More informations about ```/etc/profile``` <a href="http://www.linuxfromscratch.org/blfs/view/6.3/postlfs/profile.html">here</a>

</br>
Stopping an AWS EC2 instance resets the DNS. Hence, Hadoop will require us to adjust this. Here again, we see the usage of such a file, faciliting our life for continuous adjustements.
