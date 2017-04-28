FROM gliderlabs/alpine:3.4

ADD tmp-repo /usr/bin/tmp-app

CMD ["/var/lib/tmp-app"]