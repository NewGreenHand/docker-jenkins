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

# 使用 root 用户操作
USER root

# 安装python
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get -y install gcc automake autoconf libtool make \
    && apt-get -y install openssl libssl-dev \
    && cd /var/jenkins_home/ \
    && mkdir python3 \
    && cd python3/ \
    && wget https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tgz \
    && tar -xvf Python-3.8.3.tgz \
    && cd Python-3.8.3 \
    && ./configure --prefix=/var/jenkins_home/python3 \
    && find / -name python3 \
    && ln -s /var/jenkins_home/python3/bin/python3 /usr/bin/python3 \
    && find / -name pip3 \
    && ln -s /var/jenkins_home/python3/bin/pip3 /usr/bin/pip3 \