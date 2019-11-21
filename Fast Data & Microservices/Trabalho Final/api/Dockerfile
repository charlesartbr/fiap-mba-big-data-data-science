FROM node

RUN mkdir -p /usr/api

WORKDIR /usr/api

COPY . /usr/api

RUN npm install

EXPOSE 3000

CMD ["./wait-for-it.sh", "database:27017", "--", "npm", "start"]
