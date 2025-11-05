#build: docker buildx build --platform linux/amd64,linux/arm64 -t registry.cn-hangzhou.aliyuncs.com/zhangyicloud/eclipse-temurin:11.0.23_9-centos7-basis -f centos7.basis.Dockerfile --push .
FROM registry.cn-hangzhou.aliyuncs.com/zhangyicloud/eclipse-temurin:11.0.23_9-jdk-centos7
LABEL author="Yee Zhang" email="1054848153@qq.com"
RUN if [ $(uname -m) = "x86_64" ]; then \
   curl -sL -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.huaweicloud.com/repository/conf/CentOS-7-anon.repo; \
 elif [ $(uname -m) = "aarch64" ]; then \
   curl -sL -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.huaweicloud.com/repository/conf/CentOS-AltArch-7.repo; \
 fi && yum makecache && yum -y install make gcc gcc-c++ java-11-openjdk-devel centos-release-scl-rh scl-utils

RUN sed -i "s/# *baseurl=/baseurl=/g" /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo && \
    sed -i "s/mirrorlist=/#mirrorlist=/g" /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo && \
    sed -i "s/gpgcheck=1/gpgcheck=0/g" /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo && \
    if [ $(uname -m) = "x86_64" ]; then \
      sed -i "s/http:\/\/mirror.centos.org\/centos\/7/https:\/\/repo.huaweicloud.com\/centos-vault\/7.9.2009/g" /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo; \
    elif [ $(uname -m) = "aarch64" ]; then \
      sed -i "s/http:\/\/mirror.centos.org\/centos\/7/https:\/\/mirrors.huaweicloud.com\/centos-altarch\/7/g" /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo; \
    fi
RUN yum makecache && yum -y install devtoolset-8
CMD ["scl", "enable", "devtoolset-8", "gcc -v"]