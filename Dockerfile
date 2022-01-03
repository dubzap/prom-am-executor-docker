FROM golang:1.17.5-buster as builder
WORKDIR /srv
RUN apt update \
    && apt install git
RUN git clone https://github.com/imgix/prometheus-am-executor.git ./
RUN go test -count 1 -v ./...
RUN go build
FROM alpine:3.15.0
WORKDIR /srv
COPY --from=builder /srv/prometheus-am-executor .
CMD ["/srv/prometheus-am-executor"]
EXPOSE 8080