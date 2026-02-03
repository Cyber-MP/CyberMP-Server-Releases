FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "deb http://security.ubuntu.com/ubuntu focal-security main" \
    | tee /etc/apt/sources.list.d/focal-security.list

RUN apt-get update && apt-get install -y \
    libssl1.1 \
    libnng-dev \
    libc-ares-dev \
    libatomic1 \
    curl \
    libcurl3-gnutls \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/lib/x86_64-linux-gnu/libnng.so.1 /usr/lib/libnng.so.1

WORKDIR /cybermp

COPY ./linux-build /cybermp
RUN chmod +x /cybermp/cybermp-server
RUN chmod +x /cybermp/bin/crashpad-handler

COPY ./server.toml /cybermp/server.toml
RUN mkdir /cybermp/resources

CMD ["./cybermp-server", "-run"]
