# docker-spark
A Dockerfile to start a spark environment

# Build the image

`docker build -t rcorbish/spark .`

Set the tag (`rcorbish/spark`) to be whatever you want.

# Running the image

`docker run --net=host rcorbish/spark &`

Run using the host network environment (`--net=host`) or it is necessary
to publish all exposed ports explicitly.

`docker run -p 8080-8081:8080-8081 -p 6066:6066 -p 7077:7077 rcorbish/spark &`

Good luck
