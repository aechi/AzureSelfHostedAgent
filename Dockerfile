FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    zip \
    curl \
    git \
    python3.10 \
    iputils-ping \
    jq \
    lsb-release \
    software-properties-common \
    wget unzip 

################################
# Install Terraform
################################

# Download terraform for linux
RUN wget https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip

# Unzip
RUN unzip terraform_1.4.6_linux_amd64.zip

# Move to local bin
RUN mv terraform /usr/local/bin/
# Check that it's installed
RUN terraform --version 

################################
# Install JAVA
################################

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install OpenJDK 11
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends openjdk-11-jdk

# Install Maven
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends maven

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64


WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]
