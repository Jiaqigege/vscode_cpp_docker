FROM ubuntu:20.04
MAINTAINER Jiaqi "Jiaqi@norelpy.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN cp -a /etc/apt/sources.list /etc/apt/sources.list.bak
RUN sed -i 's@http://.*ubuntu.com@http://repo.huaweicloud.com@g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    bash-completion openssh-server vim sudo locales time rsync \
    bc python apt-utils git ssh p7zip unzip net-tools \
    iproute2 tree curl iputils-ping build-essential asciidoc \
    binutils bzip2 gawk gettext libncurses5-dev libz-dev \
    patch python3 zlib1g-dev lib32gcc1 libc6-dev-i386 \
    subversion flex uglifyjs git-core gcc-multilib p7zip \
    p7zip-full msmtp libssl-dev texinfo libglib2.0-dev \
    xmlto qemu-utils upx libelf-dev autoconf automake \
    libtool autopoint device-tree-compiler build-essential \
    g++-multilib antlr3 gperf wget curl swig rsync

RUN apt-get update && apt-get install -y -f

# language support
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# switch to a no-root user
RUN useradd -c 'damon user' -m -d /home/damon -s /bin/bash damon 
RUN echo 'damon:ubuntu' | chpasswd
RUN sed -i -e '/\%sudo/ c \%sudo ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
RUN usermod -a -G sudo damon
RUN echo "export TERM=xterm-256color" >> /home/damon/.bashrc

#取消pam限制
RUN sed -ri 's/session required pam_loginuid.so/#session required pam_loginuid.so/g' /etc/pam.d/sshd

RUN echo "#!/bin/bash\n \
    /usr/sbin/sshd -D" > /run.sh \
    && chmod +x /run.sh

RUN mkdir -p /var/run/sshd \
    && mkdir -p run/sshd \
    && mkdir -p /root/.ssh \
    && ssh-keygen -A

#开放端口
EXPOSE 22

#设置自启动命令
#CMD ["/run.sh"]
#CMD ["/bin/bash", "-c", "/run.sh"]
COPY ./package /package
RUN ./package/install.sh

USER damon
WORKDIR /home/damon

