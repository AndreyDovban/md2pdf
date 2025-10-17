FROM ubuntu:22.04
ARG NODE_VERSION=20.15.0


RUN groupadd --gid 1000 andrey
RUN useradd --uid 1000 --gid andrey --shell /bin/bash --create-home andrey

WORKDIR /opt/app
RUN apt update
RUN apt -y install wget
RUN apt -y install pandoc
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.jammy_amd64.deb
RUN apt -y install ./wkhtmltox_0.12.6.1-3.jammy_amd64.deb
RUN mkdir /root/.fonts
COPY fonts/ /root/.fonts
RUN fc-cache -f -v


RUN apt -y install curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# set env
ENV NVM_DIR=/root/.nvm

# install node
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION"
RUN apt -y install mc
RUN ln -s /root/.nvm/versions/node/v$NODE_VERSION/bin/node /usr/bin/node
RUN ln -s /root/.nvm/versions/node/v$NODE_VERSION/bin/npm /usr/bin/npm

RUN apt -y install node-puppeteer

