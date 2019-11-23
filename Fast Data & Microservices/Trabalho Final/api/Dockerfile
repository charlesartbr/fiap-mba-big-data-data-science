FROM node

RUN mkdir -p /usr/api

WORKDIR /usr/api

COPY . /usr/api

RUN npm install

EXPOSE 3000

RUN ["chmod", "+x", "/usr/api/wait-for-it.sh"]

CMD ["./wait-for-it.sh", "database:27017", "--", "npm", "start"]
