FROM node:latest

RUN mkdir -p /usr/app

WORKDIR /usr/app

COPY . /usr/app

COPY init.js /docker-entrypoint-initdb.d/

RUN npm install

EXPOSE 4200

RUN ["chmod", "+x", "/usr/app/wait-for-it.sh"]

CMD ["./wait-for-it.sh", "api:3000", "--", "npm", "start"]
