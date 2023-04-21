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
fi
echo ""
sleep 2

################Jenkins installation, docker, git
for a in jenkins git docker
        do
        which $a &>> /tmp/jenkinsinstallation
        if [ $? != 0 ] ; then
                echo -e "${Yellow} $a packages is not available"     
                sleep 2
                echo -e "   ${Green} packages is going to install $NC"
                echo -e "    Please wait, it will take some time ............................."
                sudo yum install $a -y
                if [ $? == 0 ]
                then
                        echo -e "${Green}    Package $a is successfully installed $NC "
                else
                        echo -e "$Red Package $a installation failed. $NC"

                fi
        else

                echo -e "${Green} $a package is already available no need to install $NC"
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
		echo -e "${Yellow} check with this command -> $NC ${Green} sudo systemctl status $b $NC"
		sleep 1
	else
		echo -e "${Yellow} $b is not started. this is going to start and enable. Please wait it will take the time $NC"
		sleep 3
		systemctl start $b
		if [ $? == 0 ] ; then
			echo -e "${Green} $b is started $NC"
                	echo -e "Run this command to check the status of jenkins ${Green} sudo systemctl status $b $NC"
                	echo -e "${Yellow} $b enabling Please wait it will take time................... $NC"
                	systemctl enable $b
                	echo -e "${Green} $b is enabled $NC"
		else
			echo -e "${Red} $b is not start please check manually $NC"
		fi
	fi
        echo ""
        sleep 2

done

############# jenkins add  in docker group
id jenkins | grep docker &> /tmp/jenkinsinstallation
if [ $? == 0 ] ; then
        echo -e "${Green} Jenkins is already members of Docker group $NC"
else
        echo -e "${Yellow} Jenkins is not members of Docker group going to add $NC"
        sudo usermod -aG docker jenkins
	echo ""
	echo -e "${Yellow} Jenkins is added in docker group Need to restart jenkins and docker $NC"
	echo ""
	echo -e "${Green} docker restarting $NC"
	sudo service docker restart 
        echo ""
	echo -e "${Green} jenkins restarting $NC"
	sudo service jenkins restart

fi
echo ""
sleep 2
