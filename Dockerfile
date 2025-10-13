FROM ubuntu:22.04


RUN groupadd --gid 1000 andrey
RUN useradd --uid 1000 --gid andrey --shell /bin/bash --create-home andrey

WORKDIR /opt/app
RUN apt update
RUN apt -y install wget
RUN apt -y install pandoc
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.jammy_amd64.deb
RUN apt -y install ./wkhtmltox_0.12.6.1-3.jammy_amd64.deb
RUN  ln -s /usr/bin/wkhtmltopdf /usr/local/bin/html2pdf
RUN mkdir /root/.fonts
COPY fonts/ /root/.fonts
RUN fc-cache -f -v
RUN apt -y install pdftk


RUN apt -y install qpdf
# RUN fc-cache -f -v  qpdf

# RUN mv ./wkhtmltox/bin/wkhtmltoimage /usr/local/bin/
# RUN mv ./wkhtmltox/bin/wkhtmltopdf /usr/local/bin/


# RUN  apt -y install ./wkhtmltopdf_0.12.6-2build2_amd64.deb
# RUN DEBIAN_FRONTEND=noninteractivе apt -y install texlive-xetex
# RUN apt -y install texlive-lang-cyrillic

# COPY xetex-install.sh /tmp/
# RUN /tmp/xetex-install.sh
# texlive-xetex
# fc-cache -f -v
# -V 'mainfont:Montserrat'