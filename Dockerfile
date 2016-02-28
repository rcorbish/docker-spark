FROM ubuntu:latest

RUN apt-get update \
  && apt-get install -y curl net-tools unzip python \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# JAVA
ENV JAVA_HOME /usr/jdk1.8.0_73
ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/8u73-b02/server-jre-8u73-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

# SPARK
ENV SPARK_VERSION 1.6.0
ENV HADOOP_VERSION 2.6
ENV SPARK_HOME /usr/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}
ENV PATH $PATH:$SPARK_HOME/bin

RUN curl http://mirror.symnds.com/software/Apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | gunzip | tar x -C /usr/ && ln -s ${SPARK_HOME} /usr/spark

CMD export SPARK_MASTER_IP=$(hostname -I | cut -d' ' -f1) && /usr/spark/sbin/start-master.sh && /usr/spark/sbin/start-slave.sh -h ${SPARK_MASTER_IP}  spark://${SPARK_MASTER_IP}:7077 && tail -f ${SPARK_HOME}/logs/*

