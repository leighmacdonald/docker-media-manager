##############################################################################
# Source: https://github.com/linuxserver/docker-baseimage-alpine-python3/blob/master/Dockerfile
# Simply using it as a baseimage fails:
# - installing g++ fails (baseimage already installs it and purges it afterwards, so let's keep it)
# - installing python 3.7.3 because that is what py3-libtorrent-rasterbar requires (doesn't work with 3.6.8)
FROM python:3.8-alpine
RUN apk add --no-cache git
#RUN curl -L https://github.com/Flexget/Flexget/releases/download/v3.1.90/FlexGet-3.1.90.tar.gz --output flexget.tar.gz
#RUN mkdir /flexget && tar -zxvf flexget.tar.gz -C /flexget && ls -la /flexget
#RUN git clone https://github.com/Flexget/Flexget.git --branch master --single-branch /flexget
#RUN cd /flexget && python3 -m venv . && 
RUN pip install flexget
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS="2"

# Set python to use utf-8 rather than ascii.
# Also, for python3: https://bugs.python.org/issue19846
ENV LANG C.UTF-8

# Copy local files.
# COPY etc/ /etc
#RUN chmod -v +x \
#    /etc/cont-init.d/*  \
#    /etc/services.d/*/run
#COPY requirements.txt /

# Ports and volumes.
EXPOSE 5050/tcp
VOLUME /config

# Flexget looks for config.yml automatically inside:
# /root/.flexget, /root/.config/flexget
# Since the uid/gid for user abc can be changed on the fly, set 777.
RUN CONFIG_SYMLINK_DIR=/root \
    && ln -s /config "$CONFIG_SYMLINK_DIR/.flexget" \
    && chmod 777 "$CONFIG_SYMLINK_DIR/" \
    && chmod 777 "$CONFIG_SYMLINK_DIR/.flexget/"
ENTRYPOINT ["flexget"]

