#build: docker buildx build --platform linux/amd64,linux/arm64 -t registry.cn-hangzhou.aliyuncs.com/zhangyicloud/async-profiler:v4.2 -f Dockerfile --push .
# FROM pubrepo.jiagouyun.com/googleimages/eclipse-temurin:11.0.20_8-jdk
# LABEL author="Yee Zhang" email="1054948153@qq.com"
# RUN if [ $(uname -m) = "x86_64" ]; then \
#      sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/" /etc/apt/sources.list; \
#    elif [ $(uname -m) = "aarch64" ]; then \
#      sed -i "s/ports.ubuntu.com/mirrors.aliyun.com/" /etc/apt/sources.list; \
#    fi && apt-get update && apt-get -y install make gcc g++
# COPY . /opt/async-profiler
# RUN cd /opt/async-profiler && make && mkdir /async-profiler && mv build/* /async-profiler/ && \
#     cd /opt && rm -rf /opt/async-profiler
# WORKDIR /async-profiler
# ENV PATH=$PATH:/async-profiler/bin
# CMD [ "asprof", "-v"]

#build: docker buildx build --platform linux/amd64,linux/arm64 -t registry.cn-hangzhou.aliyuncs.com/zhangyicloud/async-profiler:v4.2 -f Dockerfile --push .
FROM registry.cn-hangzhou.aliyuncs.com/zhangyicloud/eclipse-temurin:11.0.23_9-centos7-basis
LABEL author="Yee Zhang" email="1054848153@qq.com"

COPY . /opt/async-profiler/
RUN cd /opt/async-profiler && scl enable devtoolset-8 make && \
    mkdir /async-profiler && mv build/* /async-profiler/ && cd .. && rm -rf /opt/async-profiler
ENV PATH=$PATH:/async-profiler/bin LC_ALL=""
WORKDIR /async-profiler
CMD ["asprof", "-v"]