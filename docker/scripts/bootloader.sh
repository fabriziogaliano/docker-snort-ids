#!/bin/bash

#Copy config file of Snort / Pulledpork
cp /docker/configuration/pulledpork/pulledpork.conf /etc/snort/pulledpork.conf
cp /docker/configuration/pulledpork/pulledpork.pl /usr/sbin/pulledpork.pl && chmod 755 /usr/sbin/pulledpork.pl
cp /docker/configuration/snort/snort.conf /etc/snort/snort.conf
cp /docker/configuration/barnyard2/barnyard2.conf /etc/snort/barnyard2.conf
chown snort.snort /etc/snort -R
mkdir -p /var/log/snort

#create some needed files
touch /etc/snort/sid-msg.map
mkdir -p /var/log/barnyard2
touch /var/log/snort/barnyard2.waldo

#if you do not have oinkcode yet # ATTENTION ! these rules could be outdated #
# cp -r /docker/rules/* /etc/snort/rules/

#example snort.rules
# echo "alert icmp any any -> any any (msg:"LOCAL ICMP echo test"; itype:8; sid:2000000;)" >> /etc/snort/rules/snort.rules

for var in $(printenv); do

    #explode vars to retrive key/value pairs
    IFS='=' read -r -a array <<< $var

    export KEY=${array[0]}

    if [[ $KEY =~ SNORT_|PPORK_|BARN_|HOST_ ]]; then

        export VALUE=${array[1]}

        sed -i -e 's|<'$KEY'>|'$VALUE'|g' '/etc/snort/snort.conf'
        sed -i -e 's|<'$KEY'>|'$VALUE'|g' '/etc/snort/pulledpork.conf'
        sed -i -e 's|<'$KEY'>|'$VALUE'|g' '/etc/snort/barnyard2.conf'
        sed -i -e 's|<'$KEY'>|'$VALUE'|g' '/docker/configuration/supervisord/supervisor.conf'

    fi

done