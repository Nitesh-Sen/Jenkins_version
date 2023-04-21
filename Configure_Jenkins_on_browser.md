# After Installing Jenkins on Amazon Linux 2 instance. Configuring it on browser: 
 **Step-1:** Firstly you need the create base. Installing  the Jenkins, Docker and Git. [Go to This file and installing all of these with few clicks.](https://github.com/Nitesh-Sen/Jenkins_version/blob/75fa430866d66164d0538c8910c041b7cbcae695/README.md)
 **Step-2: Now you have to open inbound Port 8080 from your instance. Then Open the browser and hit the public IP along with the 8080 port.**
```
http://<Your_Instance_Public_ip>:8080
```

![](https://miro.medium.com/v2/resize:fit:576/1*2k9302u5JHQsKmYZh4IRwg.png) 

**Step-3: Copy the path and get the password from the server:**
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
**Step-4: Install the suggested plugins :**

![](https://miro.medium.com/v2/resize:fit:576/1*M3ZI93YtqWIwnLVnfn4w2w.png)

**Step-5: Add the user credentials and save it:**

![](https://miro.medium.com/v2/resize:fit:576/1*zAWUbqduavKqByB1JVwiUw.png)

**Step-6: Installation and configuration are completed and now you can start creating the Jenkins jobs.**

![](https://miro.medium.com/v2/resize:fit:576/1*HxgXS1CgOI0Wl6AH8QkO3w.png)

