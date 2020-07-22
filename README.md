# docker-jenkins
基于官方的 docker 镜像 添加一些额外的软件

## 包含

* jenkins/jenkins:lts-alpine
* Python3


## 使用

- 运行命令:
```
docker run -d 
    --name=jenkins 
    -p 8080:8080 
    -p 50000:50000 
    -v jenkins_home:/var/jenkins_home 
    --env JAVA_OPTS="-Dhudson.footerURL=$server_url -Dhudson.model.DirectoryBrowserSupport.CSP= -Duser.timezone=Europe/Moscow" \
    manycoding/jenkins-python
```

### 文件说明
* requirements.txt 要安装的pip第三方包
* plugins.txt 要安装的jenkins 插件包
* pipfile pipenv 配置