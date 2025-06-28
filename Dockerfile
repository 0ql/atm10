FROM alpine:latest

ARG RCON_PWD

RUN apk update && apk add --no-cache \
		curl \
		unzip \
		bash \
		openjdk21-jre-headless

WORKDIR /server

ADD https://edge.forgecdn.net/files/6696/937/ServerFiles-4.2.zip /tmp/server.zip
RUN unzip /tmp/server.zip -d /server && \
    chmod +x startserver.sh && \
    echo "eula=true" > eula.txt && \
    sed -i '/^enable-rcon=/c\enable-rcon=true' server.properties && \
    sed -i '/^rcon\.password=/c\rcon.password=${RCON_PWD}' server.properties && \
    rm /tmp/server.zip

EXPOSE 25565 25575

CMD ["bash", "startserver.sh"]
