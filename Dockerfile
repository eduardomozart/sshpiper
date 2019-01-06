FROM golang:latest
LABEL maintainer="Boshi Lian<farmer1992@gmail.com>"

RUN apt-get update && apt-get install -y libpam0g-dev libpam-google-authenticator

ADD . /go/src/github.com/tg123/sshpiper/
RUN go install -ldflags "$(/go/src/github.com/tg123/sshpiper/sshpiperd/ldflags.sh)" -tags pam github.com/tg123/sshpiper/sshpiperd

EXPOSE 2222

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/go/bin/sshpiperd", "daemon"]
