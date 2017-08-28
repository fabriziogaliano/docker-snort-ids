# docker-snort-ids
[![](https://images.microbadger.com/badges/version/fabriziogaliano/docker-snort-ids.svg)](https://microbadger.com/images/fabriziogaliano/docker-snort-ids "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/fabriziogaliano/docker-snort-ids.svg)](https://microbadger.com/images/fabriziogaliano/docker-snort-ids "Get your own image badge on microbadger.com")

Docker IDS image with Snort 2.9.9.0, Barnyard2 2-1.13, PulledPork 0.7.0, DAQ 2.0.6, Libpcap 1.7.4


## All the Environment showed below are Mandatory!

```

SNORT_NET: Network where snort sniff traffic
HOST_INT: Network interface where traffic dump operation are done
PPORK_OINKCODE: Your Snort OINKCODE (create on https://snort.org)
BARN_DBUSER: DB User for Barnyard2
BARN_DBNAME: DB name where Barnyard2 will insert record
BARN_DBPASS: DB User password
BARN_DBHOST: DB host

```

## Docker-compose file
in alternative you can use docker run, but... why?

```

version: '2'
services:
   ids:
      image: fabriziogaliano/docker-snort-ids:latest

      network_mode: host

      volumes:
         - "/etc/localtime:/etc/localtime"
         - "./log/snort:/var/log/snort"
         - "./log/barnyard2:/var/log/barnyard2"

      privileged: false

      environment:
         SNORT_NET: "x.x.x.x/xx"
         HOST_INT: "eth0"
         PPORK_OINKCODE: "00xxxxxd6934xxxxxxxx4ab1e0d4a7xxxxxxxc6c8"
         BARN_DBUSER: "snort"
         BARN_DBNAME: "snorby"
         BARN_DBPASS: "yourPasswordHere"
         BARN_DBHOST: "db.host.local"

      restart: always

```

## As web GUI i used a very good image, tnx mate

```

https://hub.docker.com/r/polinux/snorby/

```