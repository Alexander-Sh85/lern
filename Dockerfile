# FROM cr.yandex/crper7r61g5617jljv9e/nginx:1.22.1-geoip-alpine3.14.10
# FROM cr.yandex/crper7r61g5617jljv9e/nginx:1.27.5-geoip-alpine3.21.3
FROM cr.yandex/crper7r61g5617jljv9e/php:8.4.2-fpm-alpine-3.21-nocb-GEOIP
# as build это для мультистейджа

RUN apk add --no-cache libmaxminddb openssl pcre zlib && \
    adduser -D -g 'nginx' nginx && \
    mkdir -p /var/log/nginx && chown -R nginx:nginx /var/log/nginx

ADD https://raw.githubusercontent.com/nginx/nginx/master/conf/mime.types /etc/nginx/mime.types
# Чистим кэш в одном слое (rm -r /var/cache/apk/* or --no-cache or apk cache clean)
RUN apk update && apk upgrade && rm -r /var/cache/apk/*

COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY whitelist.conf /etc/nginx/whitelist.conf

ADD --chmod=664 https://github.com/P3TERX/GeoLite.mmdb/raw/download/GeoLite2-Country.mmdb /usr/share/geoip/
# ADD --chmod=664 https://github.com/P3TERX/GeoLite.mmdb/raw/download/GeoLite2-City.mmdb /usr/share/geoip/

# FROM cr.yandex/crper7r61g5617jljv9e/nginx:1.25.3-alpine3.18

# COPY --from=build /usr/share/nginx/html /usr/share/nginx/html
# COPY --from=build /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT [ "nginx" ]
CMD ["-g", "daemon off;"]

# RUN adduser -D -H test
#WORKDIR /app

# USER test
EXPOSE 80 9113
