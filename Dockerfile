FROM python:3.11-slim

ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app
ENV TZ=Asia/Shanghai

RUN sed -i 's|deb.debian.org|mirrors.aliyun.com|g' \
    /etc/apt/sources.list.d/debian.sources 2>/dev/null || true

RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    gcc \
    fonts-dejavu-core \
    fonts-liberation \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir playwright patchright

RUN python -m playwright install --with-deps chromium

RUN python -m patchright install --with-deps chromium

WORKDIR /app

#docker build -t xianyu-python-playwright:latest -f Dockerfile .