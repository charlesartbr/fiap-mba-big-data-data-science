const express = require('express');
const http = require('http');
const bodyParser = require('body-parser');
const cors = require('cors');

const api = require('./api');
const app = express();

const port = process.env.PORT || '3000';

app.set('port', port);
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use('/', api);

const server = http.createServer(app);

server.listen(port, () => console.log(`API ativa na porta: ${port}`));