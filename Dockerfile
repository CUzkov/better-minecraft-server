FROM openjdk:17.0.2-oracle

COPY ./server /usr/src/server
WORKDIR /usr/src/server
RUN chmod +x run.sh

EXPOSE 25565

CMD ["./run.sh"]
