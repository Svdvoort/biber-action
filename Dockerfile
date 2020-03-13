FROM ubuntu:18.04

RUN apt-get update && apt-get install -y biber


WORKDIR /root

COPY \
  entrypoint.sh \
  /root/

ENTRYPOINT ["/root/entrypoint.sh"]
