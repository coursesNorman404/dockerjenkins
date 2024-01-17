FROM jenkins/jenkins
USER root

# Actualiza los paquetes e instala las dependencias necesarias
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Agrega la clave GPG oficial de Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Configura el repositorio de Docker
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list

# Instala Docker Engine
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# Agregar el usuario 'jenkins' al grupo 'docker'
RUN usermod -aG docker jenkins

USER jenkins
