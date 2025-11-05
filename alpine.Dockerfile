#build: docker buildx build --platform linux/amd64,linux/arm64 -t registry.cn-hangzhou.aliyuncs.com/zhangyicloud/async-profiler:v4.2-alpine -f alpine.Dockerfile --push .
FROM registry.cn-hangzhou.aliyuncs.com/zhangyicloud/amazoncorretto:11.0.21-alpine-basis
LABEL author="Yee Zhang" email="1054948153@qq.com"
COPY . /opt/async-profiler
RUN cd /opt/async-profiler && make && mkdir /async-profiler && mv build/* /async-profiler/ && \
    cd /opt && rm -rf /opt/async-profiler
ENV PATH=$PATH:/async-profiler/bin
WORKDIR /async-profiler
CMD [ "asprof", "-v" ]
