FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.local/bin:${PATH}"

# 基础环境
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    bash \
    vim \
    nano \
    less \
    ca-certificates \
    build-essential \
    python3.10 \
    python3.10-dev \
    python3.10-venv \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# 设置 python
RUN ln -sf /usr/bin/python3.10 /usr/bin/python && \
    python -m pip install --upgrade pip setuptools wheel

# ===== 安装 Claude Code（允许失败）=====
RUN echo "Installing Claude Code..." && \
    (curl -fsSL https://claude.ai/install.sh | bash) || \
    echo "Claude install skipped (region unsupported)"

# ===== 安装你的 pip 包 =====
RUN pip install coterm

# demo workspace
WORKDIR /workspace
RUN mkdir -p /workspace/demo && \
    echo 'print("hello coterm")' > /workspace/demo/main.py

CMD ["tail", "-f", "/dev/null"]