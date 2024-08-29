<!-- docker stop $(docker ps -aq);sudo docker system prune -a -->
docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker rmi $(docker images -aq)
docker build -t test1 .;sleep 3;docker run -d --name nginx_test -p 8080:80 test1