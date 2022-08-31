FROM ubuntu:latest
RUN apt update -y
RUN apt install tzdata -y

#installing apache2 
RUN apt install apache2 -y && service apache2 start
EXPOSE 80
CMD apache2ctl -D FOREGROUND
