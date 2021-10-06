FROM alpine

RUN apk update

RUN DEBIAN_FRONTEND="noninteractive" apk add tzdata

RUN apk update && apk add apache2

COPY ./webpage/ /var/www/html

EXPOSE 80

CMD ["apache2ctl","-D","FOREGROUND"]
