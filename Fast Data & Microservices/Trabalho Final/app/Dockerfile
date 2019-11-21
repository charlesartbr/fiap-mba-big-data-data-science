FROM node:latest

RUN mkdir -p /usr/app

WORKDIR /usr/app

COPY . /usr/app

RUN npm install

EXPOSE 4200

CMD ["./wait-for-it.sh", "api:3000", "--", "npm", "start"]
