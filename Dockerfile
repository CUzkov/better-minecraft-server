FROM openjdk:17.0.2-oracle

COPY ./server /usr/src/server
WORKDIR /usr/src/server

EXPOSE 25565

CMD ["./start.sh"]
