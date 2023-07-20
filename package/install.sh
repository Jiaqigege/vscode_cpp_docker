#!/bin/bash

cwd=$(
	cd $(dirname $0)
	pwd
)

# 定义函数：安装 clang_extra_tools
install_clang_extra_tools() {
	# 检查 clang_extra_tools 压缩包是否存在
	if [ -e ${cwd}/clang_extra_tools_*.tar.gz ]; then
		echo "找到 clang_extra_tools 压缩包。"
	else
		echo "未找到 clang_extra_tools 压缩包。无法继续安装。"
		return 1
	fi

	# 提取 clang_extra_tools 版本号
	clang_extra_tools_version=$(echo clang_extra_tools_*.tar.gz | grep -oP '(?<=clang_extra_tools_)\d+\.\d+\.\d+')

	if [ -z "$clang_extra_tools_version" ]; then
		echo "无法提取 clang_extra_tools 版本号。"
		return 1
	else
		echo "clang_extra_tools 版本号：$clang_extra_tools_version"
	fi

	# 提取主机架构
	host_arch=$(echo clang_extra_tools_*.tar.gz | grep -oP '(?<=clang_extra_tools_)\d+\.\d+\.\d+_(\S+)_\d+\.\d+')

	if [ -z "$host_arch" ]; then
		echo "无法提取主机架构。"
	else
		echo "主机架构：$host_arch"
	fi

	# 提取 GCC 版本
	gcc_version=$(echo clang_extra_tools_*.tar.gz | grep -oP '(?<=_)\d+\.\d+(?=\.tar\.gz)')
	if [ -z "$gcc_version" ]; then
		echo "无法提取 GCC 版本。"
	else
		echo "GCC 版本：$gcc_version"
	fi

	tar -xzvf clang_extra_tools*.tar.gz -C $(cwd)/tmp
	chmod +x $(cwd)/tmp/*
	mv $(cwd)/tmp/* /usr/bin/
	rm $(cwd)/tmp -rf

	# 完成安装
	echo "软件安装完成。"
}

install_aarch64_compiler_7.5()
{
	# 检查 lang_extra_tools 压缩包是否存在
	if [ -e ${cwd}/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz ]; then
		echo "找到 gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz 压缩包。"
	else
		echo "未找到 gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz 压缩包。无法继续安装。"
		return 1
	fi

	xz -d gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz
	tar -xvf gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar -C /opt
	update-alternatives --install /usr/bin/aarch64-linux-gnu aarch64-linux-gnu /opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu 80
	echo "PATH=$PATH:/usr/bin/aarch64-linux-gnu/bin" >> /home/damon/.bashrc
	rm -rf gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar
}

# 调用安装函数
install_clang_extra_tools
install_aarch64_compiler_7.5
