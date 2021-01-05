FROM postgres

ADD gen_shortid.sh /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/gen_shortid.sh