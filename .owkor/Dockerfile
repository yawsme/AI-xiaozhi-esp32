# .firmware/Dockerfile
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    git wget flex bison gperf python3 python3-pip python3-setuptools \
    python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util

# 克隆 ESP-IDF（建议固定版本，或采用 submodule 方式管理）
RUN git clone --depth=1 --recursive https://github.com/espressif/esp-idf.git /opt/esp-idf
WORKDIR /opt/esp-idf
RUN ./install.sh

# 将 ESP-IDF 环境变量写入 profile（非必须，可在构建脚本中 source）
RUN echo ". /opt/esp-idf/export.sh" >> /etc/profile

# 拷贝项目代码到容器（建议将自定义部分和上游代码分开管理）
WORKDIR /workspace
COPY . /workspace

# 构建固件示例（具体命令根据实际项目修改）
RUN . /opt/esp-idf/export.sh && \
    idf.py set-target esp32 && \
    idf.py build

# 构建产物放在 /workspace/build 文件夹中