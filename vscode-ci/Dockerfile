FROM node:14

#####################################################################
# Install Xvfb and basic dependencies
#####################################################################
RUN apt-get update -y && \
    apt-get install -y tzdata && \
    apt-get install -y apt-transport-https build-essential libasound2 xvfb x11-utils

#####################################################################
# Install vscode
#####################################################################
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt-get update -y && \
    apt-get install -y code 

#####################################################################
# Install yarn
#####################################################################
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -y && \
    apt-get install -y yarn 

#####################################################################
# Install vsce
#####################################################################
RUN npm install -g vsce

#####################################################################
# Running Xvfb in bacground
#####################################################################
COPY bootstrap.sh /
RUN chmod a+x /bootstrap.sh
ENTRYPOINT [ "/bootstrap.sh" ]
