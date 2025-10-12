FROM ubuntu:22.04


RUN groupadd --gid 1000 andrey
RUN useradd --uid 1000 --gid andrey --shell /bin/bash --create-home andrey

WORKDIR /opt/app
RUN apt update
RUN apt -y install mc
RUN apt -y install pandoc
RUN DEBIAN_FRONTEND=noninteractivе apt -y install texlive-xetex
RUN apt -y install texlive-lang-cyrillic
RUN mkdir /root/.fonts
COPY fonts/ /root/.fonts
RUN  fc-cache -f -v


# COPY xetex-install.sh /tmp/
# RUN /tmp/xetex-install.sh
# texlive-xetex
# fc-cache -f -v
# -V 'mainfont:Montserrat'