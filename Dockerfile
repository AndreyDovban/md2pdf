FROM ubuntu:22.04


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
