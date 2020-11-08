# Hadoop-AWS-EC2-Setup
This repo contains tools to set up and run a Hadoop Cluster, and also more specifically on AW EC2.


<h4> About the environnement variables: </h4>

We create a file called ```bigdata.sh``` in ```/etc/profile.d```, that we transform as an executable through the following command: </br>
```sudo chmod +x /etc/profile.d/bigdata.sh```</br></br> 
Creating such an executable is handy since this file will be executed at every instance reboot, making these enironnement variables persistent. Indeed,```/etc/profile``` and ```/etc/profile.d``` both contain startup files.

More informations about ```/etc/profile``` <a href="http://www.linuxfromscratch.org/blfs/view/6.3/postlfs/profile.html">here</a>




<h5>Command to find own public DNS</h5>
<code>
dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}'
</code>


<h4> Regarding the local setup </h4>

If not able to access web UI but nodes working. Check ports used and correspoding address:

<code>sudo netstat -plten | grep java</code>
