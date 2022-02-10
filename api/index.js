require('dotenv').config();
const mongoose = require('mongoose');
const express = require('express');
const bodyParser = require('body-parser');
const PORT = process.env.PORT || 8000;

const authentication = require('./routes/authentication');
const weights = require('./routes/weights');

const app = express();
app.use(express.json());
// app.use(bodyParser.urlencoded({
//   extended: true
// }));
// app.use(bodyParser.json());

app.use('/', authentication);
app.use('/', weights);

app.use(function (req, res) {
  res.status(404).json({
    message: 'Not Found'
  });
});

mongoose
  .connect(process.env.MONGO_DB_STRING, { useNewUrlParser: true, useUnifiedTopology: true }, (err) => {
    if (err) throw err.message;
    console.log('application connected to database');
  });


app.listen(PORT, () => {
  console.log(`running at ${PORT}`);
});
