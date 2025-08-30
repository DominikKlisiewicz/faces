FROM nvidia/cuda:12.1.1-base-ubuntu22.04

RUN apt-get update && apt-get install -y \
    python3-pip python3-dev python3-setuptools \
    git curl wget unzip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip

RUN pip3 install torch==2.2.2+cu121 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121

RUN pip3 install deepface matplotlib opencv-python-headless numpy pandas jupyter

WORKDIR /workspace

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]

