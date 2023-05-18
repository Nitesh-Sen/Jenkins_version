
# Jenkins Installation in Amazon Linux 2

###### NOTE: Open Inbound Port 8080, 80 to All Traffic 
> *If you will run Jenkins in t2.micro. Then Create swap memory for run Jenkins easily or smoothly in your server with this [document](https://repost.aws/knowledge-center/ec2-memory-swap-file).*

Create a file.
```
sudo vim ~/jenkins.sh
```
Now add this content in this file and save then exit [wq!]
- If you want to do only installing of Jenkins then copy this **OR**

```
#!/bin/bash
Green='\033[0;92m'
Red='\033[0;91m'
Yellow='\033[0;33m'       # Yellow
NC='\033[0m' # No Color
sum=0
###################
yum update &> /tmp/jenkinsinstallation
ls /etc/yum.repos.d/jenkins.repo &> /tmp/jenkinsinstallation
if [ $? == 0 ] ; then
        echo -e "${Green} jenkins.repo already exist $NC" 
        sleep 1
else
        echo -e "${Yellow} jenkins.repo is not available going to  install $NC"
        sleep 1
        wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
fi
echo -e "${Green} Importing a key file from Jenkins-CI to enable installation from the package ${NC}"
sleep 1
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
echo -e "${Green} your system is going to upgrading $NC"
yum upgrade &> /tmp/jenkinsinstallation
##################
dnf list --installed | grep java-11-amazon-corretto &> /tmp/jenkinsinstallation
if [ $? == 0 ] ; then
        echo -e "${Green} java-11-amazon-corretto package is already available $NC" 
        sleep 1
else
        echo -e "${Yellow} java-11-amazon-corretto is not available going to install $NC"
        sleep 1
	dnf install java-11-amazon-corretto -y
fi 
################Jenkins installation
which jenkins &> /tmp/jenkinsinstallation
if [ $? == 0 ] ; then
        echo -e "${Green} jenkins package is already available $NC" 
        sleep 1
else
        echo -e "${Yellow} jenkins is not available going to install $NC"
        sleep 1
        yum install jenkins -y
fi
#############starting jenkins
systemctl status jenkins &> /tmp/jenkinsinstallation
if [ $? == 0 ] ; then
        echo -e "${Green} jenkins is already started No need to start $NC"
	echo -e "${Yellow} check with this command -> $NC ${Green} sudo systemctl status jenkins $NC"
        sleep 1
else
        echo -e "${Yellow} jenkins is not started. this is going to start and enable. Please wait it will take the time $NC"
        sleep 3
        systemctl start jenkins
	if [ $? == 0 ] ; then
		echo -e "${Green} jenkins is started $NC"
		echo -e " run this command to check the status of jenkins"
		echo -e "${Green} sudo systemctl status jenkins $NC"
		echo -e "${Yellow} jenkins enabling Please wait it will take time................... $NC"
		systemctl enable jenkins
		echo -e "${Green} jenkins is enabled $NC"
	else
		echo -e "${Red} jenkins is not start please check manually $NC"
	fi
fi
```

- If you want to install Jenkins with Docker and Git with add the jenkins in docker group. Then copy this content.
```
#!/bin/bash
Green='\033[0;92m'
Red='\033[0;91m'
Yellow='\033[0;33m'       # Yellow
NC='\033[0m' # No Color
sum=0
###################
yum update &> /tmp/jenkinsinstallation
ls /etc/yum.repos.d/jenkins.repo &> /tmp/jenkinsinstallation
if [ $? == 0 ] ; then
        echo -e "${Green} jenkins.repo already exist $NC" 
        sleep 1
else
        echo -e "${Yellow} jenkins.repo is not available going to  install $NC"
        sleep 1
        wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
fi
echo ""
echo -e "${Green} Importing a key file from Jenkins-CI to enable installation from the package ${NC}"
sleep 1
echo ""
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
echo -e "${Green} Server is upgrading Please Wait........ $NC"
yum upgrade &> /tmp/jenkinsinstallation
echo ""
##################
dnf list --installed | grep java-11-amazon-corretto &> /tmp/jenkinsinstallation
if [ $? == 0 ] ; then
        echo -e "${Green} java-11-amazon-corretto package is already available $NC" 
else
        echo -e "${Yellow} java-11-amazon-corretto is not available going to install $NC"
	dnf install java-11-amazon-corretto -y
	if [ $? == 0 ]
                then
                        echo -e "${Green} Package java-11-amazon-corretto is successfully installed $NC "
                else
                        echo -e "${Red} Package java-11-amazon-corretto installation failed. $NC"

                fi
                sleep 1
fi
echo ""
sleep 2

################Jenkins installation, docker, git
for a in jenkins git docker
        do
        which $a &>> /tmp/jenkinsinstallation
        if [ $? != 0 ] ; then
                echo -e "${Yellow} Package $a is not available. ${Green}it's going to install $NC"     
                sleep 2
                sudo yum install $a -y
                if [ $? == 0 ]
                then
                        echo -e "${Green} Package $a is successfully installed. $NC "
                else
                        echo -e "${Red} Package $a installation failed. $NC"

                fi
		sleep 1
        else

                echo -e "${Green} Package $a is already available no need to install. $NC"
        fi
        echo ""
        sleep 2
done

#####################jenkins and docker starting
for b in jenkins docker
        do
        systemctl status $b &>> /tmp/jenkinsinstallation
	if [ $? == 0 ] ; then
		echo -e "${Green} $b is already started No need to start $NC"
	else
		echo -e "${Yellow} $b is not started. this is going to start and enable. Please wait it will take the time $NC"
		sleep 2
		echo ""
		systemctl start $b
		if [ $? == 0 ] ; then
			echo -e "${Green} $b is started $NC"
			echo ""
                	echo -e "${Yellow} $b enabling Please wait it will take time................... $NC"
                	systemctl enable $b
			echo ""
                	echo -e "${Green} $b is enabled $NC"
		else
			echo -e "${Red} $b is not start please check manually $NC"
		fi
	fi
        echo ""
        sleep 2

done
echo ""
echo ""
echo ""

############# jenkins add  in docker group
id jenkins | grep docker &> /tmp/jenkinsinstallation
if [ $? == 0 ] ; then
        echo -e "${Green} Jenkins is already members of Docker group. $NC"
else
        echo -e "${Yellow} Jenkins is not members of Docker group going to add $NC"
        sudo usermod -aG docker jenkins
	echo ""
	echo -e "${Yellow} Jenkins is added in docker group Need to restart jenkins and docker $NC"
	echo ""
	echo -e "${Green} docker restarting $NC"
	sudo service docker restart 
        echo ""
	echo -e "${Green} jenkins restarting. Please wait, It will take the time $NC"
	sudo service jenkins restart

fi
echo ""
sleep 2
```
Give the execute permissions of this file.
```
sudo chmod u+x ~/jenkins.sh
```
And lastly execute this file.
```
sudo bash ~/jenkins.sh
```
