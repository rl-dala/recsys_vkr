FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV CUDA_VISIBLE_DEVICES=0
ENV OMP_NUM_THREADS=8

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.10 python3.10-dev python3.10-distutils \
    curl wget git libopenblas-dev \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3.10 /usr/local/bin/python3 \
    && curl -SL https://bootstrap.pypa.io/get-pip.py | python3

RUN useradd -m -s /bin/bash jupyter

RUN rm -rf /home/jupyter/.local/lib/python3.10/site-packages/torch* \
    && rm -rf /home/jupyter/.local/lib/python3.10/site-packages/torchvision* \
    && rm -rf /home/jupyter/.local/lib/python3.10/site-packages/torchaudio*

RUN pip install --upgrade pip==25.1.1 \
    && pip install --no-cache-dir \
       torch==2.7.0+cu118 \
       torchvision==0.22.0+cu118 \
       torchaudio==2.7.0+cu118 \
       --extra-index-url https://download.pytorch.org/whl/cu118

RUN pip install --no-cache-dir \
    numpy==2.2.6 \
    pandas==2.2.2 \
    matplotlib==3.10.3 \
    scipy==1.15.3 \
    scikit-learn==1.6.1 \
    joblib==1.5.0 \
    --no-deps pytorch-lightning==2.5.1 \
    lightning-utilities==0.14.3 \
    setuptools==80.8.0 \
    typing-extensions==4.13.2 \
    PyYAML==6.0.2 \
    filelock==3.18.0 \
    fsspec==2025.5.0 \
    jinja2==3.1.6 \
    MarkupSafe==3.0.2 \
    networkx==3.4.2 \
    sympy==1.14.0 \
    mpmath==1.3.0 \
    torchmetrics==1.7.1 \
    tqdm==4.67.1 \
    sentence-transformers==4.1.0 \
    transformers==4.52.3 \
    huggingface-hub==0.31.4 \
    Pillow==11.2.1 \
    requests==2.32.3 \
    certifi==2025.4.26 \
    charset-normalizer==3.4.2 \
    urllib3==2.4.0 \
    safetensors==0.5.3 \
    tokenizers==0.21.1 \
    contourpy==1.3.2 \
    cycler==0.12.1 \
    fonttools==4.58.0 \
    kiwisolver==1.4.8 \
    pyparsing==3.2.3 \
    python-dateutil==2.9.0 \
    six==1.17.0 \
    jupyterlab==4.2.0

# Дополнительные пакеты для рекомендательных систем
RUN pip install --no-cache-dir implicit==0.7.0 faiss-gpu==1.7.2

RUN mkdir -p /etc/jupyter \
    && echo "c.NotebookApp.mem_limit = 96e9" >> /etc/jupyter/jupyter_server_config.py \
    && echo "c.NotebookApp.cpu_limit = 8" >> /etc/jupyter/jupyter_server_config.py

RUN chown -R jupyter:jupyter /usr/local/lib/python3.10/dist-packages /usr/local/bin

USER jupyter
WORKDIR /home/jupyter

EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''"]