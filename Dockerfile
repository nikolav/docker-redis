FROM redis

WORKDIR /home/app

COPY . ./

CMD [ "./wserver.sh" ]
