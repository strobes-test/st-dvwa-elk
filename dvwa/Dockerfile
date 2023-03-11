FROM php:5.6.27-apache

RUN apt-get update && apt-get install -y git libjpeg62-turbo-dev libpng12-dev \
    libpcap0.8 mysql-client libnetfilter-queue-dev \
    libpcre3 libpcre3-dbg libpcre3-dev libnss3-dev libnspr4-dev \
    build-essential autoconf automake libtool libpcap-dev libnet1-dev liblz4-dev make python-yaml \
    libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libmagic-dev libcap-ng-dev libcap-ng0 rustc cargo python \
    libjansson-dev pkg-config libgeoip-dev liblua5.1-dev libhiredis-dev libevent-dev

RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd mysql pdo_mysql mysqli

WORKDIR /var/www/html
COPY ./suricata.tar.gz /suricata.tar.gz

RUN rm -rf * \
    && git clone https://github.com/RandomStorm/DVWA.git /var/www/html

RUN mv /var/www/html/config/config.inc.php.dist /var/www/html/config/config.inc.php \
    && sed -i "s/127.0.0.1/dvwamysql/g" /var/www/html/config/config.inc.php \
    && sed -i "s/impossible/low/g" /var/www/html/config/config.inc.php \
    && sed -i "s/root/dvwa/g" /var/www/html/config/config.inc.php \
    && sed -i "s/p@ssw0rd/Passw0rd!/g" /var/www/html/config/config.inc.php \
    && sed -i "s/5432/3306/g" /var/www/html/config/config.inc.php \
    && chmod a+w /var/www/html/hackable/uploads/ \
    /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt \
    /var/www/html/config/

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-7.5.2-amd64.deb && \
    dpkg -i packetbeat-7.5.2-amd64.deb && \
    rm packetbeat-7.5.2-amd64.deb

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.5.2-amd64.deb && \
    dpkg -i filebeat-7.5.2-amd64.deb && \
    rm filebeat-7.5.2-amd64.deb

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.5.2-amd64.deb && \
    dpkg -i metricbeat-7.5.2-amd64.deb && \
    rm metricbeat-7.5.2-amd64.deb

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/heartbeat/heartbeat-7.5.2-amd64.deb && \
    dpkg -i heartbeat-7.5.2-amd64.deb && \
    rm heartbeat-7.5.2-amd64.deb

RUN tar -xvf /suricata.tar.gz -C ./ && \
    rm /suricata.tar.gz

RUN cd suricata-5.0.1 && \
    ./configure --enable-nfqueue --prefix=/usr --sysconfdir=/etc --localstatedir=/var && \
    make -j 4 && make install && \
    make install-conf && make install-rules && make install-full

RUN echo "./start_service.sh" >> ~/.bashrc

COPY ./suricata.yml.disabled /etc/filebeat/modules.d/suricata.yml.disabled
