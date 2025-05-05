# Stage 1: сборка nginx с модулем geoip2
FROM cr.yandex/crper7r61g5617jljv9e/alpine:3.21.3 AS build

# Устанавливаем зависимости для сборки
RUN apk add --no-cache \
    build-base \
    pcre-dev \
    zlib-dev \
    openssl-dev \
    libmaxminddb-dev \
    linux-headers \
    git \
    wget

ENV NGINX_VERSION=1.27.5

# Скачиваем исходники nginx
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar zxvf nginx-${NGINX_VERSION}.tar.gz

# Клонируем geoip2 модуль
RUN git clone --depth=1 https://github.com/leev/ngx_http_geoip2_module.git

WORKDIR /nginx-${NGINX_VERSION}

# Конфигурируем сборку с динамическим модулем geoip2
RUN ./configure \
    --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx \
    --modules-path=/usr/lib/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --with-compat \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_stub_status_module \
    --add-dynamic-module=../ngx_http_geoip2_module

    RUN make modules && make

# Stage 2: финальный образ
FROM cr.yandex/crper7r61g5617jljv9e/alpine:3.21.3

# Устанавливаем runtime зависимости добавляем юзера nginx и создаем директорию логов
RUN apk add --no-cache libmaxminddb openssl pcre zlib && \
    adduser -D -g 'nginx' nginx && \
    mkdir -p /var/log/nginx && chown -R nginx:nginx /var/log/nginx

# Копируем бинарник nginx из стадии сборки
COPY --from=build /nginx-1.27.5/objs/nginx /usr/sbin/nginx

# Копируем скомпилированный динамический модуль geoip2
COPY --from=build /nginx-1.27.5/objs/ngx_http_geoip2_module.so /etc/nginx/modules/

