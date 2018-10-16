FROM node:carbon-jessie

ENV DISPLAY=:1

#####################################################################
# Install Xvfb and basic dependencies
#####################################################################
RUN apt update -y && \
    apt install -y tzdata && \
    apt install -y apt-transport-https build-essential libasound2 xvfb

#####################################################################
# Install vscode
#####################################################################
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt update -y && \
    apt-get install -y code 

#####################################################################
# Running Xvfb in bacground
#####################################################################
ADD ./bootstrap.sh /bootstrap.sh
RUN chmod a+x /bootstrap.sh
CMD bash -C '/bootstrap.sh'; 'bash'
