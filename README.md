# Hadoop-AWS-EC2-Setup
This repo contains tools to set up and run a Hadoop Cluster, and also more specifically on AW EC2.


<h4> About the environnement variables: </h4>

We create a file called ```bigdata.sh``` in ```/etc/profile.d```, that we transform as an executable through the following command: </br>
```sudo chmod +x /etc/profile.d/bigdata.sh```</br></br> 
Creating such an executable is handy since this file will be executed at every instance reboot, making these enironnement variables persistent. Indeed,```/etc/profile``` and ```/etc/profile.d``` both contain startup files.

More informations about ```/etc/profile``` <a href="http://www.linuxfromscratch.org/blfs/view/6.3/postlfs/profile.html">here</a>

<h4> Required after instance stop: </h4>

<ul>
	<li> Modify public DNS in each config file located in <code>~/.ssh</code></li>
		<ul>
			<li><code>chmod 777 config</code></li>
			<li>Replace DNS</li>
			<li><code>chmod 0400 config</code></li>
		</ul>
	<li> In <code>/etc/profile.d</code> of each node replace old DNS by the new one</li>
		<ul>
			<li><code>sudo chown ubuntu bigdata.sh</code></li>
			<li><code>chmod 777 bigdata.sh</code></li>
			<li>Replace DNS</li>
			<li>Do not forget to re-set <code>chmod 0400 bigdata.sh</code></li>
			<li>Reboot to make env variables active</li>		
		</ul>
	<li> Change hostnames (on every node) </br>
	<code>publichost=${NameNodeDNS}</code> </br>
	<code>publichost=${DataNode001DNS}</code> </br>
	<code>publichost=${DataNode002DNS}</code> </br>
	<code>publichost=${DataNode003DNS}</code> </br> </br>
	<code>sudo rm -rf /etc/hostname</code> </br>
<code>echo -e "${publichost}" | sudo tee --append /etc/hostname > /dev/null </code> </br>
<code>sudo chown root /etc/hostname</code>	
	</li>
</ul>
</br>
Stopping an AWS EC2 instance resets the DNS. Hence, Hadoop will require us to adjust this. Here again, we see the usage of such a file, faciliting our life for continuous adjustements.



<h5>Command to find own public DNS</h5>
```
dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}'
```



