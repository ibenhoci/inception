FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

COPY ./requirements/nginx/conf/script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 443

CMD ["/script.sh"]