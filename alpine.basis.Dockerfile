#build: docker buildx build --platform linux/amd64,linux/arm64 -t registry.cn-hangzhou.aliyuncs.com/zhangyicloud/amazoncorretto:11.0.21-alpine-basis -f alpine.basis.Dockerfile --push .
FROM registry.cn-hangzhou.aliyuncs.com/zhangyicloud/amazoncorretto:11.0.21-alpine
LABEL author="Yee Zhang" email="1054948153@qq.com"
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
   apk add make gcc g++ linux-headers
CMD [ "gcc", "-v" ]
