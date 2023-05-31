#Télécharge les images
docker pull mariadb:latest
#lance la base de données mariadb
#docker run --detach -p 3306:3306 --name sall-mariadb --env MARIADB_USER=sall-user --env MARIADB_PASSWORD=my_docker1_secret --env MARIADB_ROOT_PASSWORD=my-docker2-secret --env MARIADB_DATABASE=sall-sql mariadb:latest 
#lancer le terminal
#docker exec -ti sall-mariadb /bin/bash 
#@IP
#ip a
# Aprés  avoir vérifier  que la commande ping ne marchait  pas (ping n’est pas installé) et on installe le paquet iputils-ping en suivant les étapes suivantes
#apt update
#apt install iputils-ping
#Création de réseau dedié(dans powershell)
#docker network create sae23_sall 
#Pour le mettre dans sall-mariadb :on supprime le containeur qu’on avait déjà crée pour pouvoir ajouter mon réseau dans le container puis on tape les commandes suivantes ; normalement le ping doit fonctionné 
docker run --detach --network sae23_sall -p 3306:3306 --name sall-mariadb --env MARIADB_USER=sall-user --env MARIADB_PASSWORD=my_docker1_secret --env MARIADB_ROOT_PASSWORD=my-docker2-secret --env MARIADB_DATABASE=sall-sql mariadb:latest  
apt update 
apt install iputils-ping
#phpmyadim: téléchargement de l'image
docker pull phpmyadmin:latest
#création du  conteneur phpmyadmin
docker run --name phpmyadmin -d --network sae23_sall -e PMA_HOST=sall-mariadb -p 9000:80 phpmyadmin
#Wordpress:téléchargement de l'image
docker pull wordpress:latest
#lancement de wordpress
docker run --network sae23_sall -p 80:80 -e WORDPRESS_DB_HOST=sall-mariadb -e WORDPRESS_DB_USER=sall-user -d -e WORDPRESS_DB_PASSWORD=my_docker1_secret -e WORDPRESS_DB_NAME=sall-sql --name sall-wordpress wordpress:latest
#Persistance de données 
docker run --detach --network sae23_sall -p 3306:3306 --name sall-mariadb --env MARIADB_USER=sall-user --env MARIADB_PASSWORD=my_docker1_secret --env MARIADB_ROOT_PASSWORD=my-docker2-secret --env MARIADB_DATABASE=sall-sql --volume C:\SAE23\savesae23BADO_1:/var/lib/mysql mariadb:latest
docker run --network sae23_sall -p 80:80 -e WORDPRESS_DB_HOST=sall-mariadb -e WORDPRESS_DB_USER=sall-user -d -e WORDPRESS_DB_PASSWORD=my_docker1_secret -e WORDPRESS_DB_NAME=sall-sql --name sall-wordpress --volume C:\SAE23\savesae23html_TP1:/var/www/html  wordpress:latest
