all :
	docker-compose -f ./srcs/docker-compose.yml up --build

down :
	docker-compose -f ./srcs/docker-compose.yml down

stop : down
	docker stop $(shell docker ps -qa)

clean : stop
	docker rm $(shell docker ps -qa)

fclean : down
	rm -rf ~/Desktop/data/mariadb/* ~/Desktop/data/wordpress-nginx/*
	docker rmi $(shell docker images -qa)

re : fclean all