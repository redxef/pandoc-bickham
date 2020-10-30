FROM archlinux/base:latest

RUN pacman --noconfirm -Syu make grep unzip curl
RUN pacman --noconfirm -S texlive-bin texlive-most pandoc tidy

RUN curl -o /tmp/BickhamScriptPro-Bold.otf 'https://www.wfonts.com/download/data/2014/12/29/bickham-script-pro/BickhamScriptPro-Bold.otf'
RUN curl -o /tmp/BickhamScriptPro-Regular.otf 'https://www.wfonts.com/download/data/2014/12/29/bickham-script-pro/BickhamScriptPro-Regular.otf'
RUN curl -o /tmp/BickhamScriptPro-Semibold.otf 'https://www.wfonts.com/download/data/2014/12/29/bickham-script-pro/BickhamScriptPro-Semibold.otf'
RUN curl -L -o /tmp/bickham.tds.zip http://mirrors.ctan.org/install/fonts/bickham.tds.zip

RUN cfftot1 /tmp/BickhamScriptPro-Bold.otf -o /tmp/BickhamScriptPro-Bold.pfb
RUN cfftot1 /tmp/BickhamScriptPro-Regular.otf -o /tmp/BickhamScriptPro-Regular.pfb
RUN cfftot1 /tmp/BickhamScriptPro-Semibold.otf -o /tmp/BickhamScriptPro-Semibold.pfb

RUN mkdir -p /usr/share/texmf/
RUN mkdir -p /usr/share/texmf/fonts/type1/adobe/bickham/
RUN unzip /tmp/bickham.tds.zip -d /usr/share/texmf
RUN rm /tmp/bickham.tds.zip
RUN mv /tmp/*.pfb /usr/share/texmf/fonts/type1/adobe/bickham/

RUN texhash
RUN updmap-sys --force --enable Map=bickham.map

COPY docker-makefile /docker-makefile
COPY docker-entrypoint.sh /usr/bin/

RUN rm -rf /tmp/*
RUN pacman --noconfirm -R unzip

ENTRYPOINT [ "docker-entrypoint.sh" ]
