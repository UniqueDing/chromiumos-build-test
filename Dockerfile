FROM python
COPY . /devserver
WORKDIR /devserver

RUN apt update && apt install -y sudo 
RUN rm -rf /var/cache/apt/lists
RUN useradd docker && usermod -G sudo docker && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN pip3 install six cherrypy

USER docker
EXPOSE 8080
VOLUME /devserver/src/build
VOLUME /devserver/static_dir
CMD ["sudo", "python3", "devserver.py", "--static_dir=static_dir"]
