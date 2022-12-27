![image](https://user-images.githubusercontent.com/98226143/209611802-73448d19-8d4a-4927-95b3-223020d05aa0.png)
A docker image is build from JAR file and push to docker hub. This docker image is further pushed to AWS EC2 instance. All the steps are a part of Jenkins Pipeline.

Steps : 
1) connect to EC2 instance from Jenkins Server via SSH(SSH agent) 
2) Execute docker run on EC2 instance
