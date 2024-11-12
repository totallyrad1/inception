all :
	mkdir -p ~/asnaji/data/mariadb ~/asnaji/data/wordpress-nginx
	docker-compose -f ./srcs/docker-compose.yml up --build

down :
	docker-compose -f ./srcs/docker-compose.yml down -v

stop :
	docker stop $(shell docker ps -qa)

clean : stop
	docker rm $(shell docker ps -qa)

fclean : down
	rm -rf ~/asnaji/data/mariadb/ ~/asnaji/data/wordpress-nginx
	docker rmi $(shell docker images -qa)

re : fclean all