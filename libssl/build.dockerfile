FROM base as builder

ARG TARGET="linux-x86_64"
ARG CC="gcc"
ARG CXX="g++"
ARG AR="ar"
ARG RANLIB="ranlib"
ARG RC=""

WORKDIR /tmp/openssl-src
RUN ./Configure ${TARGET} -static no-shared --prefix=/opt/libssl-${TARGET}
RUN make && make install_sw
WORKDIR /opt/
RUN tar cf libssl-${TARGET}.tar.gz libssl-${TARGET}

FROM scratch as final
ARG TARGET="linux-x86_64"
COPY --from=builder /opt/libssl-${TARGET}.tar.gz /
