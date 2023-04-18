# Jenkins_Installation

Create a file.
```
sudo vim ~/jenkins.sh
```
Now add this content in this file and save then exit [wq!]

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
Give the execute permissions of this file.
```
sudo chmod u+x ~/jenkins.sh
```
And lastly execute this file.
```
sudo bash ~/jenkins.sh
```
