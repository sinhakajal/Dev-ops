# A simple jenkins pipeline to verify if the docker slave configuration is working as expected.
For testing single agent add script path - jenkins/doc_agent_config /1_agent_config/jenkinsfile
![image](https://github.com/sinhakajal/Dev-ops/assets/50231099/c0aea39f-b539-44bf-9f86-7c4c8c555046)
![image](https://github.com/sinhakajal/Dev-ops/assets/50231099/02f78878-13b6-45b5-b137-53cade7dcb56)


On VM/Server check if docker is running (jenkins build is completed or not) by using the below command
```linux
docker ps
```
