FROM debian:11.7

ARG ver1c
ENV ver1c $ver1c

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y tar wget libgtk-3-0 gstreamer1.0-plugins-good gstreamer1.0-plugins-bad libegl1-mesa nano iproute2 smbclient locales locales-all fontconfig-config bc cifs-utils geoclue-2.0 libtiff5 apache2

RUN echo "deb http://ftp.ru.debian.org/debian sid main contrib non-free" >> /etc/apt/sources.list
RUN apt update -y
RUN apt install -y ttf-mscorefonts-installer

RUN locale-gen ru_RU.UTF-8
ENV LANG='ru_RU.UTF-8' LANGUAGE='ru_RU:ru' LC_ALL='ru_RU.UTF-8'

RUN wget http://ftp.ru.debian.org/debian/pool/main/e/enchant/libenchant1c2a_1.6.0-11.1+b1_amd64.deb
RUN apt install -y ./libenchant1c2a_1.6.0-11.1+b1_amd64.deb
RUN fc-cache –fv

RUN wget https://cloud.arbis29.ru/index.php/s/qQWMKYTe6aBadqp/download/licenceserver-3.0.33-11299.amd64.deb
RUN wget https://cloud.arbis29.ru/index.php/s/48WbzKz8DriiZCs/download/licenceaddin-3.0.33-11299.amd64.deb

RUN apt install -y ./licenceserver-3.0.33-11299.amd64.deb
RUN apt install -y ./licenceaddin-3.0.33-11299.amd64.deb


COPY get1cdistr.sh .
RUN chmod +x ./get1cdistr.sh
RUN ./get1cdistr.sh
RUN ./setup-1c.run --mode unattended --enable-components server,ws,server_admin,liberica_jre,client_thin_fib,ru

RUN mkdir –p /home/usr1cv8/.fonts
RUN cp -R /usr/share/fonts/truetype/msttcorefonts /home/usr1cv8/.fonts

COPY start1c.sh .

RUN echo "LoadModule _1cws_module \"/opt/1cv8/x86_64/$ver1c/wsap24.so\"" >> /etc/apache2/apache2.conf
RUN echo "IncludeOptional 1cpub/*.conf" >> /etc/apache2/apache2.conf
RUN ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
