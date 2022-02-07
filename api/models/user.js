const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    require: true,
  },
  firstName: {
    type: String,
    required: true,
  },
  lastName: {
    type: String,
    required: true,
  },
  date: {
    type: Date,
    default: Date.now(),
  },
  _id: {
    type: String,
    require: true,
  },
});

module.exports = mongoose.model('User', UserSchema);
