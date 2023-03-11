docker-compose build && \
docker-compose up -d
sleep 5
echo "
CREATE USER 'dvwa'@'%' IDENTIFIED BY 'Passw0rd!';
CREATE DATABASE dvwa;
GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'%';"
docker exec -it dvwa-elk_dvwamysql_1 mysql -pPassw0rd!