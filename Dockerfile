FROM ghcr.io/linuxserver/baseimage-alpine:3.20
LABEL maintainer="Julio Gutierrez julio.guti+nordlynx@pm.me"

HEALTHCHECK CMD [ $(( $(date -u +%s) - $(wg show wg0 latest-handshakes | awk '{print $2}') )) -le 120 ] || exit 1

COPY /root /
RUN apk add --no-cache -U iptables ip6tables iptables-legacy wireguard-tools curl jq patch && \
    patch --verbose -d / -p 0 -i /patch/wg-quick.patch && \
    apk del --purge patch && \
    rm -rf /tmp/* /patch && \
    cd /sbin && \
    for i in ! !-save !-restore; do \
        rm -rf iptables$(echo "${i}" | cut -c2-) && \
        rm -rf ip6tables$(echo "${i}" | cut -c2-) && \
        ln -s iptables-legacy$(echo "${i}" | cut -c2-) iptables$(echo "${i}" | cut -c2-) && \
        ln -s ip6tables-legacy$(echo "${i}" | cut -c2-) ip6tables$(echo "${i}" | cut -c2-); \
    done
