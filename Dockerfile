FROM debian:10.7-slim AS builder

RUN apt-get update && apt-get install -y curl

ENV VER 1.3.0
RUN curl https://github.com/lorislab/changelog/releases/download/$VER/changelog_${VER}_Linux_x86_64.tar.gz -O -J -L && \
    tar xfz changelog_${VER}_Linux_x86_64.tar.gz changelog && \
    chmod +x changelog
 
RUN apt-get update apt-get install -y --no-install-recommends ca-certificates

FROM debian:10.7-slim

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder changelog /opt/changelog

ENTRYPOINT ["/opt/changelog"]
