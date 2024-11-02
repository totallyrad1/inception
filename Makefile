all :
	docker-compose -f ./srcs/docker-compose.yml up --build -d

stop :
	docker-compose -f ./srcs/docker-compose.yml down

clean :
	docker rm $(shell docker ps -qa)

fclean : stop
	docker rmi $(shell docker images -qa)  -f

re : stop fclean all