const mongoose = require('mongoose');

const WeightSchema = new mongoose.Schema({
  user_id: {
    type: String,
    required: true,
  },
  value: {
    type: String,
    require: true,
  },
  _id: {
    type: String,
    require: true,
  },
  date: {
    type: Date,
    required:  true,
  },
  updated: {
    type: Date,
  },
});

module.exports = mongoose.model('Weight', WeightSchema);
