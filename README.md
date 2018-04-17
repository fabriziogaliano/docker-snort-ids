# docker-snort-ids
[![](https://images.microbadger.com/badges/version/fabriziogaliano/docker-snort-ids.svg)](https://microbadger.com/images/fabriziogaliano/docker-snort-ids "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/fabriziogaliano/docker-snort-ids.svg)](https://microbadger.com/images/fabriziogaliano/docker-snort-ids "Get your own image badge on microbadger.com")

Docker IDS image with Snort 2.9.9.0, Barnyard2 2-1.13, PulledPork 0.7.0, DAQ 2.0.6, Libpcap 1.7.4


## All the Environment shown below are Mandatory!

```

SNORT_NET: Network where snort sniff traffic
HOST_INT: Network interface where traffic dump operation are done
HOST_NAME: Name of the IDS is running
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
      image: fabriziogaliano/snort-ids:latest

      network_mode: host

      volumes:
         - "/etc/localtime:/etc/localtime"
         - "./rules:/etc/snort/rules"
         - "./log/snort:/var/log/snort"
         - "./log/barnyard2:/var/log/barnyard2"

      privileged: false

      environment:
         SNORT_NET: "x.x.x.x/xx"
         HOST_INT: "eth0"
         HOST_NAME: "snort01"
         PPORK_OINKCODE: "00xxxxxd6934xxxxxxxx4ab1e0d4a7xxxxxxxc6c8"
         BARN_DBUSER: "snort"
         BARN_DBNAME: "snorby"
         BARN_DBPASS: "yourPasswordHere"
         BARN_DBHOST: "db.host.local"

      restart: always

```

## DB for Barnyard2 ( /docker-entrypoint-initdb.d help you to inizialize the DB for the first time )

```

version: '2'
services:
    ids_db:
       image: mariadb:10.3.0

       container_name: ids_db

       network_mode: host

       environment:
          MYSQL_DATABASE: "snorby"
          MYSQL_USER: "snort"
          MYSQL_PASSWORD: "yourUserPassword"
          MYSQL_ROOT_PASSWORD: "yourRootPassword"

       volumes:
          # you can find the *.sql in GitHub ( /docker/scripts/snorby-schema.sql )
          - "./snorby-schema.sql:/docker-entrypoint-initdb.d"
          - "./data:/var/lib/mysql"

       ports:
         - "3306:3306"

       restart: always

```

## If you encount problem with the operations to set the snorby password follow this command

```
login to container and launch: 

# yum update -y nss curl libcurl

# cd /usr/local/src/snorby

# bundle install

# RAILS_ENV="production" bundle exec script/rails c

# User.create(:name => 'Administrator', :email => 'user@domain.com', :password => 'yourPasswordHere', :password_confirmation => 'yourPasswordHere', :admin => true)

```

## As web GUI i used SNORBY, a good product, tnx mate for the image

```

https://hub.docker.com/r/polinux/snorby/

```
