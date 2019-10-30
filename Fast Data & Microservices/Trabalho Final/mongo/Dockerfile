FROM mongo

MAINTAINER Charles Cavalcante <e-mail@charles.art.br>

ENV MONGO_INITDB_ROOT_USERNAME=alunos \
    MONGO_INITDB_ROOT_PASSWORD=fiap123

COPY init.js /docker-entrypoint-initdb.d/
