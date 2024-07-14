FROM golang:1.22.5-alpine3.17 AS builder

ENV CGO_ENABLED 0

COPY . /build
WORKDIR /build
RUN go build -o rest-server ./cmd/rest-server




FROM alpine:3.17

ENV DATA_DIRECTORY /data
ENV PASSWORD_FILE /data/.htpasswd
ENV DISABLE_AUTHENTICATION true

RUN adduser -u 506 -G users -D restic-server

RUN apk add --no-cache --update apache2-utils

COPY docker/create_user /usr/bin/
COPY docker/delete_user /usr/bin/
COPY docker/entrypoint.sh /entrypoint.sh
COPY --from=builder /build/rest-server /usr/bin

USER restic-server

VOLUME /data
EXPOSE 8000

CMD [ "/entrypoint.sh" ]
