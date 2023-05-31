docker pull wordpress:latest
docker pull mariadb:latest
docker pull phpmyadmin:latest
docker network create sae23_sall 
docker run --name phpmyadmin -d --network sae23_sall -p 9000:80 --env PMA_HOST=some-mariadb phpmyadmin

docker run --detach --network sae23_sall -p 3306:3306 --name sall-mariadb --env MARIADB_USER=sall-user --env MARIADB_PASSWORD=my_docker1_secret --env MARIADB_ROOT_PASSWORD=my-docker2-secret --env MARIADB_DATABASE=sall-sql --volume C:\savesae23BADO_1:/var/lib/mysql mariadb:latest

docker run --network sae23_sall -p 80:80 -e WORDPRESS_DB_HOST=sall-mariadb -e WORDPRESS_DB_USER=sall-user -d -e WORDPRESS_DB_PASSWORD=my_docker1_secret -e WORDPRESS_DB_NAME=sall-sql --name sall-wordpress --volume C:\savesae23html_TP1/var/www/html wordpress:latest

#Partie image (étape3)
docker build -t image-portf .
docker run -p 82:80 -it -d --name some-portf image-portf