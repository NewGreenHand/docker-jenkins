FROM jenkins/jenkins:lts-alpine

ENV JAVA_OPTS=-Duser.timezone=Asia/Shanghai -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2

# 使用 root 用户
USER root

# 修改软件源(本地测试用)
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装 python
RUN apk add --no-cache python3 python3-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

# 安装 pip 第三方包
COPY requirements.txt /server_requirements.txt
RUN pip install -U pipenv && \
    pip install --extra-index-url=https://pypi.python.org/simple/ --no-cache-dir -r /server_requirements.txt

# 安装 Jenkins 插件
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER jenkins
