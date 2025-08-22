FROM scratch

RUN mkdir -p /data

VOLUME /data

RUN ls -alG > /data/test.txt

WORKDIR /app
COPY ./src/open-tmux.sh .

CMD ["open-tmux.sh"]