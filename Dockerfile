FROM openjdk:8-alpine
RUN apk --update add wget tar bash
RUN wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz
RUN tar -xzf spark-3.5.0-bin-hadoop3.tgz && \
mv spark-3.5.0-bin-hadoop3 /spark
COPY start-master.sh start-master.sh
COPY start-worker.sh /start-worker.sh
