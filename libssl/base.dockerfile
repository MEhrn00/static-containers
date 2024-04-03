FROM docker.io/debian:bookworm-slim

ARG OPENSSL_VERSION=3.2.1
ARG OPENSSL_HASH=83c7329fe52c850677d75e5d0b0ca245309b97e8ecbcfdc1dfdc4ab9fac35b39

RUN dpkg --add-architecture i386
RUN apt-get update -y && apt-get install -y \
    wget \
    gcc \
    gcc-multilib \
    make \
    mingw-w64 \
    libfindbin-libs-perl

WORKDIR /tmp

RUN wget "https://github.com/openssl/openssl/releases/download/openssl-${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION}.tar.gz"

RUN echo "${OPENSSL_HASH} openssl-${OPENSSL_VERSION}.tar.gz" > openssl.sha256sum
RUN sha256sum -c openssl.sha256sum
RUN rm -vf openssl.sha256sum

RUN tar xf openssl-${OPENSSL_VERSION}.tar.gz
RUN rm -vf openssl-${OPENSSL_VERSION}.tar.gz

RUN mv openssl-${OPENSSL_VERSION} openssl-src
WORKDIR /
