Install Jenkins, configure Docker as agent, set up ci/cd, deploy applications to k8s and much more.

# 1. Installation on EC2 Instance
- Go to AWS Console
- Instances(running)
- Launch instances

https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#Instances:search=:172-31-16-50;v=3;$case=tags:true%5C,client:false;$regex=tags:false%5C,client:false

![image](https://github.com/sinhakajal/Dev-ops/assets/50231099/88070e14-7a30-4706-a53c-43e20002ff49)

# 2. Install Jenkins
#### Pre-Requisites:
- Java (JDK)

#### Run the below commands to install Java and Jenkins
###### Install Java
```linux
sudo apt update
sudo apt install openjdk-11-jre
```

###### Verify Java is Installed
```linux
java --version
```

###### Now, you can proceed with installing Jenkins
https://www.jenkins.io/doc/book/installing/linux/

```linux
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```

###### By default EC2 instance does not receive traffic from the external world i.e. the inbound traffic rules are blocked by default
```linux
ps -ef | grep jenkins
jenkins    26969       1 11 13:30 ?        00:00:19 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080
ubuntu     27107   24738  0 13:33 pts/1    00:00:00 grep --color=auto jenkins
```

**NOTE** We can see Jenkins is running on port 8080 and By default, Jenkins will not be accessible to the external world due to the inbound traffic restriction by AWS. Open port 8080 in the inbound traffic rules as shown below.
- EC2 > Instances > Click on
- In the bottom tabs -> Click on Security
- Security groups
- Add inbound traffic rules as shown in the image (Allow TCP 8080).

![image](https://github.com/sinhakajal/Dev-ops/assets/50231099/c59e6585-3a93-41c4-bd25-e91fdb38ab8b)

##### Login to Jenkins using the below URL:
http://:8080 [You can get the ec2-instance-public-ip-address from your AWS EC2 console page]

After you login to Jenkins, - Run the command to copy the Jenkins Admin Password - sudo cat /var/lib/jenkins/secrets/initialAdminPassword - Enter the Administrator password
![image](https://github.com/sinhakajal/Dev-ops/assets/50231099/3468cf06-5571-423c-b74c-638a71f77afd)
###### Click on Install suggested plugins
Wait for the Jenkins to Install suggested plugins

###### Create First Admin User or Skip the step [If you want to use this Jenkins instance for future use-cases as well, better to create admin user]
![image](https://github.com/sinhakajal/Dev-ops/assets/50231099/8b120f71-e4e7-4313-8c46-7bb5771d049b)

###### Jenkins Installation is Successful. You can now starting using the Jenkins
![image](https://github.com/sinhakajal/Dev-ops/assets/50231099/dff4b305-9493-428f-9ddb-f677ab48b5cc)

# 3. Install the Docker Pipeline plugin in Jenkins:
- Log in to Jenkins.
- Manage Jenkins > Manage Plugins
- In the Available tab, search for "Docker Pipeline"
- Install plugin
- Restart Jenkins after the plugin is installed.
![image](https://github.com/sinhakajal/Dev-ops/assets/50231099/ad118215-a295-4d35-ac5e-3ac00ca718e8)
Restart Jenkins

## Docker Slave Configuration
Run the below command to Install Docker
```linux
sudo apt update
sudo apt install docker.io
```
Grant Jenkins user and Ubuntu user permission to docker deamon.
```linux
sudo su - 
usermod -aG docker jenkins
usermod -aG docker ubuntu
systemctl restart docker
```
For verification 
```linux
sudo su - jenkins
docker run hello-world
```
restart Jenkins.
```linux
http://<ec2-instance-public-ip>:8080/restart
```
The docker agent configuration is now successful.

