FROM ubuntu:22.04

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

RUN apt update && apt install -y build-essential unzip vim git curl wget zip

RUN apt-get update &&\
	apt-get upgrade -y &&\
    apt-get install -y  software-properties-common

RUN apt-get install -y python3 python3-pip

RUN pip install flask

RUN useradd -ms /bin/bash kprzystalski
RUN adduser kprzystalski sudo

USER kprzystalski
WORKDIR /home/kprzystalski/

COPY --chown=kprzystalski:kprzystalski main.py /home/kprzystalski/

EXPOSE 80

ENV FLASK_APP=/home/kprzystalski/main.py

CMD flask run --host=0.0.0.0 --port=80 

