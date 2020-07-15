# docker jenkins
FROM jenkins/jenkins:lts

# environment settings
ENV PATH=/usr/local/openjdk-8/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
LANG=C.UTF-8 \
JAVA_HOME=/usr/local/openjdk-8 \
JAVA_VERSION=8u242 \
JAVA_BASE_URL=https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jdk_ \
JAVA_URL_VERSION=8u242b08 \
JENKINS_HOME=/var/jenkins_home \
JENKINS_SLAVE_AGENT_PORT=50000 \
REF=/usr/share/jenkins/ref \
JENKINS_UC=https://updates.jenkins.io \
JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental \
JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals \
COPY_REFERENCE_FILE_LOG=/var/jenkins_home/copy_reference_file.log \
JAVA_OPTS=-Duser.timezone=Asia/Shanghai

# ports and volumes
VOLUME /var/jenkins_home
EXPOSE 8080  50000

# 复制文件
COPY python_package.sh /tmp/python_package.sh
# COPY Python-3.8.3.tgz /var/jenkins_home/

# 使用 root 用户操作
USER root

# 修改软件源(本地测试用)
# RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
#     && echo "deb http://ftp.cn.debian.org/debian/ stretch main" > /etc/apt/sources.list \
#     && echo "deb http://ftp.cn.debian.org/debian/ stretch-updates main" >> /etc/apt/sources.list \
#     && echo "deb http://ftp.cn.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list

# 安装编译环境
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get -y install gcc automake autoconf libtool make zlib* openssl libssl-dev 

# 安装python
RUN cd /var/jenkins_home \
    && wget https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tgz \
    && tar -xvf Python-3.8.3.tgz \
    && cd Python-3.8.3 && ./configure --prefix=/usr/local/python3 --with-ssl && make && make install \
    && ln -s /usr/local/python3/bin/python3 /usr/bin/python3 \
    && ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3

# 安装 python 包
RUN pip3 install requests

# 执行sh 脚本(先授权)chmod 777 /tmp/python_package.sh
# ENTRYPOINT ["/tmp/python_package.sh"]
