FROM gliderlabs/alpine:3.4

ADD tmp-app /usr/bin/tmp-app

CMD ["tmp-app"]