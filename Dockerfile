FROM cr.yandex/crper7r61g5617jljv9e/nginx:1.25.3-alpine3.18 
# as builder

WORKDIR /var/www
# RUN apk update && apk upgrade

COPY index.html /var/www/
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# FROM nginx:latest

# RUN adduser -D testuser
# USER testuser

# WORKDIR /app

# EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]