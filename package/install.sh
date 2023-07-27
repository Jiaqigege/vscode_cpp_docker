#!/bin/bash

cwd=$(
	cd $(dirname $0)
	pwd
)

# 定义函数：安装 clang_extra_tools
install_clang_extra_tools() {
	mkdir -p ${cwd}/tmp
	tar -xzvf ${cwd}/clang_extra_tools_16.0.6_x86_64_9.4.tar.gz -C ${cwd}/tmp
	chmod +x ${cwd}/tmp/clang_extra_tools_16.0.6_x86_64_9.4/*
	mv ${cwd}/tmp/clang_extra_tools_16.0.6_x86_64_9.4/* /usr/bin/
	rm ${cwd}/tmp -rf

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

	xz -d ${cwd}/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz
	tar -xvf ${cwd}/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar -C /opt
	update-alternatives --install /usr/bin/aarch64-linux-gnu aarch64-linux-gnu /opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu 80
	echo "export PATH=$PATH:/usr/bin/aarch64-linux-gnu/bin" >> /home/damon/.bashrc
	rm -rf gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar
}

# 调用安装函数
install_clang_extra_tools
install_aarch64_compiler_7.5
