# ベースイメージを指定
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

# タイムゾーンを自動設定
RUN apt-get update && apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# 必要なパッケージをインストール
RUN apt-get install -y \
    # Packages required by OpenEmbedded/Yocto
    gawk wget git git-lfs diffstat unzip texinfo gcc-multilib \
    chrpath socat cpio python3 python3-pip python3-pexpect xz-utils \
    debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa \
    libsdl1.2-dev pylint xterm bsdmainutils \
    libssl-dev libgmp-dev libmpc-dev lz4 zstd \
    # Packages needed for some "Developer Package" use cases
    build-essential libncurses-dev libncurses5 libyaml-dev libssl-dev \
    # Useful tools
    coreutils file sed curl bc lrzsz cvs subversion mercurial nfs-common \
    nfs-kernel-server libarchive-zip-perl dos2unix texi2html libxml2-utils

# python3をデフォルトに設定
RUN apt-get install -y python-is-python3

# MMCパーティション設定の追加
RUN mkdir -p /etc/modprobe.d && \
    echo 'options mmc_block perdev_minors=16' > /etc/modprobe.d/mmc_block.conf

# SDKインストールスクリプトのパスを変数に格納
ARG SDK_INSTALL_TAR="en.SDK-x86_64-stm32mp1-openstlinux-6.1-yocto-mickledore-mpu-v24.06.26.tar.gz"
ARG SDK_INSTALL_SCRIPT="stm32mp1-openstlinux-6.1-yocto-mickledore-mpu-v24.06.26/sdk/st-image-weston-openstlinux-weston-stm32mp1-x86_64-toolchain-4.2.4-openstlinux-6.1-yocto-mickledore-mpu-v24.06.26.sh"
ARG SDK_PATH="/opt/STM32MPU-Developer-Package/SDK"
ARG SDK_SCRIPT="environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi"

# SDK用ディレクトリの作成
RUN mkdir -p ${SDK_PATH}

# SDKインストールスクリプトを実行
COPY ./dockerfile/stm32mp1_cortex-a7_development-environment/${SDK_INSTALL_TAR} /tmp/
RUN tar xvf /tmp/${SDK_INSTALL_TAR} -C /tmp/ \
    && chmod +x /tmp/${SDK_INSTALL_SCRIPT} \
    && /tmp/${SDK_INSTALL_SCRIPT} -d ${SDK_PATH}

# SDK環境をセットアップ
RUN echo "source ${SDK_PATH}/${SDK_SCRIPT}" >> /root/.bashrc

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
CMD [ "tail", "-f", "/dev/null" ]