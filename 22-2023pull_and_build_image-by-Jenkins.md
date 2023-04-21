# Clone the Github repository and auto-build and push on dockerhub with help of plugin.
### Installing the Plugin for job
> Go to **Manage Jenkins** Option. 
> 
> Then click on **Manage Plugin**. 
> 
> In the Right side click on **Available plugins**. Search **CloudBees Docker Build and Publish pluginVersion1.4.0, GitHub plugin and Git plugin** and select these all then click on ``Download now and install after restart``
> 
> After this step your jenkins will we start

## Now we will create the job which will clone the repository from GitHub and Build image and push on Docker-Hub 


>Go to in Dashboard.
>
> Now in the right side click on ``+ New Item``
>
> Give your job name and select **Freestyle project** and click ``Ok``
>  
> Step-1:  Option **Source Code Management** -> Choose ``Git``.
>   
>   - Here you give the repository name in which have a file named by [Dockerfile](https://github.com/Nitesh-Sen/Test.repo) and here no need to give github credentials. Because this is Public repository.
>   ![](https://github.com/Nitesh-Sen/Jenkins_version/blob/f4ab92b355cc3667dbf8861380cf8b4c229e69ea/Images/Screenshot%20from%202023-04-22%2000-42-51.png)
>   
>   - Branch to build option delete master and all. 
>   - Leave that blank. **Branch Specifier (blank for 'any')**
>    
>   Step-2: Option **Build Triggers** -> Choose ``GitHub hook trigger for GITScm polling``
>    
>    Step-3: Option **Build Steps** -> Choose ``Docker Build and Publish``
>    ![](https://github.com/Nitesh-Sen/Jenkins_version/blob/db38fbde2368897e24b20a9608817611d1592c72/Images/Image00-48-15_2023-04-22.png)
>     
>   - Then give Repository Name and Tag
>   ![](https://github.com/Nitesh-Sen/Jenkins_version/blob/949502b4ee2d43fdea27eabf6f55365dab8c5840/Images/Screenshot%20from%202023-04-22%2000-52-15.png)
>    
>    - Scroll the page and in ``Registry credentials`` -> Add -> Jenkins 
>    - Then give only username and Password and click on Add. In next option click on none and choose your added credentials. 
>    ![](https://github.com/Nitesh-Sen/Jenkins_version/blob/ed96dc14cfcb30b95d6b4a772ed0b68afb98ed2d/Images/Screenshot%20from%202023-04-22%2000-56-25.png)
> 
> Lastly click on Save. Then build your job.
>  
>  ![](https://github.com/Nitesh-Sen/Jenkins_version/blob/12edafd4ddbda317fb01d979fe26a929661a57a3/Images/Image01-03-10_2023-04-22.png)
>  ![](https://github.com/Nitesh-Sen/Jenkins_version/blob/12edafd4ddbda317fb01d979fe26a929661a57a3/Images/Image01-05-02_2023-04-22.png)
