# Build Docker image
```
shell# docker build -t image_name .
```

# Run Docker image
```
shell# docker run -it -p 8080:8080 -v /home/jenkins:/var/lib/jenkins image_name /bin/bash
```

# Things you have to know first
- The uid & gid of jenkins in the docker image should be 48
- The uid & gid of jenkins in the docker image should be 499
- Mount a jenkins folder on /var/lib/jenkins
- Stop jenkins service when you use the docker image first time. Cos the uid and gid is different from docker images.
```
docker# service jenkins stop 
docker# chown jenkins.jenkins /var/lib/jenkins
docker# service jenkins start
```
