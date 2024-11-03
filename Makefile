all :
	docker-compose -f ./srcs/docker-compose.yml up --build

down :
	docker-compose -f ./srcs/docker-compose.yml down

stop :
	docker stop $(shell docker ps -qa)

clean : stop
	docker rm $(shell docker ps -qa)

fclean : clean down
	docker rmi $(shell docker images -qa)  -f

re : fclean all