FROM cr.yandex/crper7r61g5617jljv9e/nginx:1.25.3-alpine3.18  
# as build это для мультистейджа

# Чистим кэш в одном слое (rm -r /var/cache/apk/* or --no-cache or apk cache clean)
RUN apk update && apk upgrade && rm -r /var/cache/apk/*

COPY index.html /usr/share/nginx/html/index.html
# COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# FROM cr.yandex/crper7r61g5617jljv9e/nginx:1.25.3-alpine3.18

# COPY --from=build /usr/share/nginx/html /usr/share/nginx/html
# COPY --from=build /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT [ "nginx" ]
CMD ["-g", "daemon off;"]

# RUN adduser -D -H test
WORKDIR /app

# USER test
EXPOSE 80 9113