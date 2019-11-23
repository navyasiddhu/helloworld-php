FROM debian:jessie-slim

ENV NGINX_VERSION 1.14.0-1~jessie
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN gpg --keyserver keys.gnupg.net --recv-key 89DF5277 \
    && gpg -a --export 89DF5277 | apt-key add - \
    && echo "deb http://ftp.hosteurope.de/mirror/packages.dotdeb.org/ jessie all" > /etc/apt/sources.list.d/dotdeb.list
RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y ca-certificates \
    php5-fpm php5-mysql php5-json php-mbstring \
    php-xml php-zip php5-curl php5-gmp php5-mcrypt \
    libphp-predis php5-imagick php5-intl php5-gd \
    php5-redis

RUN gpg --keyserver keys.gnupg.net --recv-key 7BD9BF62 \
    && gpg -a --export 7BD9BF62 | apt-key add - \
    && echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
    && apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
            ca-certificates \
            nginx=${NGINX_VERSION} \
            nginx-module-xslt \
            nginx-module-geoip \
            nginx-module-image-filter \
            nginx-module-perl \
            nginx-module-njs \
            gettext-base \
    && rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log


EXPOSE 8080

STOPSIGNAL SIGTERM

WORKDIR /var/www/app

CMD /usr/sbin/php5-fpm -R --fpm-config /etc/php5/fpm/php-fpm.conf && nginx -g 'daemon off;'
