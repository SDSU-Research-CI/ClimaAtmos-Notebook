# Use the official Julia base image
FROM julia:1.10.5@sha256:726b8bd1d2fa5e250bf45ad87dc94e79e15e1b857b2e058d1ad7e36654baa800

USER root
# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    openmpi-bin \
    openmpi-common \
    libopenmpi-dev \
    wget \
    curl \
    git \
    vim \
    nano \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install CUDA 12.4 toolkit
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey |  gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
&& curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
   tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && apt-get update
RUN  apt-get install -y nvidia-container-toolkit
# Set environment variables for CUDA
ENV CLIMACOMMS_DEVICE="CUDA"

# Set environment variables for MPI
ENV CLIMACOMMS_CONTEXT="MPI"