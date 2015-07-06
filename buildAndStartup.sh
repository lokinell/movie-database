docker stop dock-nginx
pkill -f movie-database
find . -type f -name application.properties -exec sed -i 's/192.168.59.103/127.0.0.1/g' {} \;''

mvn clean install
cd movie-database-shop-app
sudo npm install
bower install
grunt
rm -rf /opt/moviedatabase/shop-app
sudo cp  -R dist/. /opt/moviedatabase/shop-app
cd ..
find . -type f -name moviedatabase.conf -exec sed -i 's/localhost/10.5.6.49/g' {} \;''

sudo cp moviedatabase.conf /etc/nginx/conf.d
dock nginx
dock redis
java -jar movie-database-monitoring/target/movie-database-monitoring-0.0.1-SNAPSHOT.jar > /dev/null 2>&1 &
java -jar movie-database-navigation/target/movie-database-navigation-0.0.1-SNAPSHOT.jar > /dev/null 2>&1 &
java -jar movie-database-movies/target/movie-database-movies-0.0.1-SNAPSHOT.jar > /dev/null 2>&1 &
java -jar movie-database-actors/target/movie-database-actors-0.0.1-SNAPSHOT.jar > /dev/null 2>&1 &
java -jar movie-database-shop-rest/target/movie-database-shop-rest-0.0.1-SNAPSHOT.jar > /dev/null 2>&1 &

# revoke
find . -type f -name application.properties -exec sed -i 's/127.0.0.1/192.168.59.103/g' {} \;''
find . -type f -name moviedatabase.conf -exec sed -i 's/10.5.6.49/localhost/g' {} \;''
