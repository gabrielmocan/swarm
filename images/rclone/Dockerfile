FROM golang AS builder

ENV RCLONE_VERSION=v1.61.1
ENV CGO_ENABLED=0

RUN git clone https://github.com/rclone/rclone --branch ${RCLONE_VERSION} --depth 1 --single-branch \
    && cd rclone \
    && make

FROM alpine

RUN apk add --no-cache brotli tzdata

COPY --from=builder /go/bin/rclone /usr/local/bin/

COPY volume_backup.sh /usr/local/bin/
