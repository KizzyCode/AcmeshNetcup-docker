FROM neilpang/acme.sh
COPY ./helper.sh /usr/bin/helper.sh
CMD [ "/usr/bin/helper.sh" ]
