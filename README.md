<!-- docker stop $(docker ps -aq);sudo docker system prune -a -->
docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker rmi $(docker images -aq)
docker build -t test1 .;sleep 3;docker run -d --name nginx_test -p 80:80 test1

docker-compose stop nginx && docker-compose rm -f nginx  && docker-compose up -d --build

1)Чистим кэш (типа rm -r /var/cache/apk/* or --no-cache or apk cache clean)
2).dockerignore не суем в проект лишнее
3)Часто изменяемые слои пишем в конце
4)Используем базовые образы с официальных репозиториев
5)Используем версионирование и образов и пакетов установки
6)ENV
7)Мультистейдж сборку, где возможно
8)1 контейнер - 1 приложение
9)метрики и логи пишем
10)ресурс менеджер
11) Минимум привилегий пользователю в контейнере