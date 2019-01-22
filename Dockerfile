FROM base/archlinux:latest

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S make unzip texlive-bin texlive-core pandoc

RUN curl -o /tmp/BickhamScriptPro-Bold.otf 'https://www.wfonts.com/download/data/2014/12/29/bickham-script-pro/BickhamScriptPro-Bold.otf'
RUN curl -o /tmp/BickhamScriptPro-Regular.otf 'https://www.wfonts.com/download/data/2014/12/29/bickham-script-pro/BickhamScriptPro-Regular.otf'
RUN curl -o /tmp/BickhamScriptPro-Semibold.otf 'https://www.wfonts.com/download/data/2014/12/29/bickham-script-pro/BickhamScriptPro-Semibold.otf'
RUN curl -L -o /tmp/bickham.zip mirrors.ctan.org/fonts/bickham.zip

RUN cfftot1 /tmp/BickhamScriptPro-Bold.otf -o /tmp/BickhamScriptPro-Bold.pfb
RUN cfftot1 /tmp/BickhamScriptPro-Regular.otf -o /tmp/BickhamScriptPro-Regular.pfb
RUN cfftot1 /tmp/BickhamScriptPro-Semibold.otf -o /tmp/BickhamScriptPro-Semibold.pfb

RUN unzip /tmp/bickham.zip -d /tmp/

RUN mkdir -p /usr/share/texmf/doc/
RUN mkdir -p /usr/share/texmf/tex/latex/bickham/
RUN mkdir -p /usr/share/texmf/fonts/map/
RUN mkdir -p /usr/share/texmf/fonts/afm/adobe/bickham/
RUN mkdir -p /usr/share/texmf/fonts/tfm/adobe/bickham/
RUN mkdir -p /usr/share/texmf/fonts/type1/adobe/bickham/
RUN mkdir -p /usr/share/texmf/fonts/vf/adobe/bickham/


RUN mv /tmp/bickham/bickham-doc.pdf /tmp/bickham/bickham-doc.tex /usr/share/texmf/doc/
RUN mv /tmp/bickham/bickham.sty /usr/share/texmf/tex/latex/bickham/
RUN mv /tmp/bickham/bickham.map /usr/share/texmf/fonts/map/
RUN mv /tmp/bickham/*.afm /usr/share/texmf/fonts/afm/adobe/bickham/
RUN mv /tmp/bickham/*.tfm /usr/share/texmf/fonts/tfm/adobe/bickham/
RUN mv /tmp/*.pfb /usr/share/texmf/fonts/type1/adobe/bickham/
RUN mv /tmp/bickham/*.vf /usr/share/texmf/fonts/vf/adobe/bickham/

RUN texhash
RUN updmap-sys --force --enable Map=bickham.map

RUN rm -rf /tmp/*
RUN pacman --noconfirm -R unzip
