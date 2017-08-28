FROM ubuntu:16.04

MAINTAINER Fabrizio Galiano <fabrizio.galiano@hotmail.com>

#Gen Env
ENV LVERS libpcap-1.7.4
ENV DVERS daq-2.0.6
ENV HOST_INT ""
ENV HOST_NAME ""

#PulledPork Env
ENV PPORK_VERSION 0.7.0
ENV PPORK_OINKCODE ""

#Snort Env
ENV SNVERS 2.9.9.0
ENV SNORT_NET ""

#Barnyard2 Env
ENV BARN_VERSION 2-1.13
ENV BARN_DBUSER ""
ENV BARN_DBPASS ""
ENV BARN_DBHOST ""


# Install Dependencies
RUN apt-get update -qq
RUN apt-get -y install \
        wget \
        build-essential \
        libtool \
        automake \
        gcc \
        flex \
        bison \
        libnet1 \
        libnet1-dev \
        libpcre3 \
        libpcre3-dev \
        autoconf \
        libcrypt-ssleay-perl \
        libwww-perl \
        git \
        zlib1g \
        zlib1g-dev \
        libssl-dev \
        libmysqlclient-dev \
        imagemagick \
        wkhtmltopdf \
        libyaml-dev \
        libxml2-dev \
        libxslt1-dev \
        openssl \
        libreadline6-dev \
        unzip \
        libcurl4-openssl-dev \
        libapr1-dev \
        libaprutil1-dev \
        supervisor \
        net-tools \
        gettext-base

#Install LIBDNET - LIBPCAP
RUN apt-get install -y libdumbnet-dev libpcap-dev

#Install compiled LIBPCAP
# RUN cd /tmp \
#     && wget http://www.tcpdump.org/release/{$LVERS}.tar.gz \
#     && tar zxf {$LVERS}.tgz \
#     && cd {$LVERS} \
#     && ./configure \
#     && make && make install \
#     && ldconfig

#Install DAQ
RUN cd /tmp \
    && wget https://snort.org/downloads/snort/$DVERS.tar.gz \
    && tar zxf $DVERS.tar.gz \
    && cd $DVERS \
    && ./configure \
    && make && make install \
    && ldconfig

#Install SNORT
RUN cd /tmp \
    && wget https://snort.org/downloads/snort/snort-$SNVERS.tar.gz \
    && tar zxf snort-$SNVERS.tar.gz \
    && cd snort-$SNVERS \
    && ./configure --enable-sourcefire \
    && make && make install

#User/group/dir for Snort
RUN groupadd snort \
    && useradd snort -d /var/log/snort -s /sbin/nologin -c SNORT_IDS -g snort \
    && mkdir -p /var/log/snort \
    && chown snort:snort /var/log/snort -R \
    && mkdir -p /etc/snort \
    && cd /tmp/snort-$SNVERS \
    && cp -r etc/* /etc/snort/

#Install Pulledpork
RUN cd /tmp \
    && wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/pulledpork/pulledpork-$PPORK_VERSION.tar.gz \
    && tar zxf pulledpork-$PPORK_VERSION.tar.gz \
    && cd pulledpork-$PPORK_VERSION \
    && cp pulledpork.pl /usr/sbin/ \
    && chmod 755 /usr/sbin/pulledpork.pl \
    && cp -r etc/* /etc/snort/ \
    && cpan install LWP::Protocol::https \
    && cpan install Crypt::SSLeay  \
    && cpan Mozilla::CA IO::Socket::SSL 
    
#Snort
RUN cd /etc/snort \
    && chown -R snort:snort * \
    && mkdir -p /usr/local/lib/snort_dynamicrules \
    && mkdir /etc/snort/rules \
    && touch /etc/snort/rules/so_rules.rules \
    && touch /etc/snort/rules/local.rules \
    && touch /etc/snort/rules/white_list.rules

#Install Barnyard2
RUN cd /tmp \
    && wget https://github.com/firnsy/barnyard2/archive/v$BARN_VERSION.tar.gz \
    && tar zxf v$BARN_VERSION.tar.gz \
    && cd barnyard2-$BARN_VERSION/ \
    && ./autogen.sh \
    && ./configure --with-mysql --with-mysql-libraries=/usr/lib/x86_64-linux-gnu  \
    && make && make install

#Clean APT
RUN apt-get clean \
    && rm -rf /var/cache/apt/*

RUN rm -rf /tmp/*

COPY docker /docker

#Subst Oinkcode tu pulledpork conf
# RUN cp /docker/configuration/pulledpork/pulledpork.conf /etc/snort/pulledpork.conf
# RUN sed -i -e 's|<'PPORK_OINKCODE'>|'$PPORK_OINKCODE'|g' '/etc/snort/pulledpork.conf'
# RUN sed -i -e 's|<'PPORK_VERSION'>|'$PPORK_VERSION'|g' '/etc/snort/pulledpork.conf'

#Pulling down the Rules
# RUN /usr/sbin/pulledpork.pl -c /etc/snort/pulledpork.conf

CMD ["/bin/bash", "/docker/scripts/entrypoint.sh", "start-stack"]