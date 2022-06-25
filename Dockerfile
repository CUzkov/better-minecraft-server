FROM openjdk:17.0.2-oracle

COPY ./server /usr/src/server
WORKDIR /usr/src/server
RUN chmod +x startserver.sh

EXPOSE 25565

CMD ["./startserver.sh"]
