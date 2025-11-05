#build: docker buildx build --platform linux/amd64,linux/arm64 -t registry.cn-hangzhou.aliyuncs.com/zhangyicloud/async-profiler:v4.2-uos -f uos.Dockerfile --push .
FROM registry.cn-hangzhou.aliyuncs.com/zhangyicloud/async-profiler:v4.2 AS stage

FROM pubrepo.guance.com/basis/uniontechos-server-zy-root:v2.0
LABEL author="Yee Zhang" email="1054948153@qq.com"
RUN curl -k -o /etc/yum.repos.d/uos-local.repo https://pmgmt.jiagouyun.com/repo/uos-local.repo && \
   echo "sslverify=0" >> /etc/yum.repos.d/uos-local.repo && yum makecache
COPY --from=stage /async-profiler /async-profiler/
ENV PATH=$PATH:/async-profiler/bin
WORKDIR /async-profiler
CMD ["asprof", "-v"]