# DVWA-ELK
[![](https://img.shields.io/badge/Category-Vulnerability%20Detection-E5A505?style=flat-square)]() [![](https://img.shields.io/badge/Language-Docker-E5A505?style=flat-square)]() [![](https://img.shields.io/badge/Version-2.0-E5A505?style=flat-square&color=green)]()

## Features
- Packetbeat
- Filebeat
- Metricbeat
- Heartbeat
- Suricata

## Setting up system
```shellsession
chmod +x ./setup.sh
./setup.sh
```
<Run SQL commands from [Config files](https://github.com/mcdulltii/dvwa-elk#config-files)>
```shellsession
chmod +x ./start.sh
./start.sh
```

## Logging system
- Elasticsearch
- Logstash (Unused)
- Kibana

## Config files
*.yml files are stored within dvwa/ and dvwamysql/

MYSQL Database configured for dvwa-elk_dvwamysql_1 as of below:
```sql
mysql -pPassw0rd!
CREATE USER 'dvwa'@'%' IDENTIFIED BY 'Passw0rd!';
CREATE DATABASE dvwa;
GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'%';
```
