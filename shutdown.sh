#boot2docker stop
#sudo nginx -s stop
docker stop dock-nginx
docker stop dock-redis
find . -type f -name application.properties -exec sed -i 's/127.0.0.1/192.168.59.103/g' {} \;''
pkill -f movie-database
