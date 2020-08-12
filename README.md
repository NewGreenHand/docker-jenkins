# docker-jenkins
基于官方的 docker 镜像 添加一些额外的软件

## 包含

* fillpit/jenkins:lts-alpine
* Python3


## 使用

- 运行命令:
```
docker run -d \
    --name=fillpit-jenkins \
    -p 8080:8080 \
    -p 50000:50000 \
    -v /volume1/docker/jenkins:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(which docker):/usr/bin/docker\
    --env PUID="1024" \
    --env PGID="100" \
    fillpit/jenkins:lts-alpine 
```

### 文件说明
* requirements.txt 要安装的pip第三方包
* plugins.txt 要安装的jenkins 插件包
* pipfile pipenv 配置