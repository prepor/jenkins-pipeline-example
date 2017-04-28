FROM gliderlabs/alpine:3.4

ADD tmp-app /usr/bin/tmp-app

EXPOSE 8080

CMD ["tmp-app"]