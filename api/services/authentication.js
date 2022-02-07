const uuid = require('uuid');
const bcrypt = require('bcrypt');

const { createJwt } = require('../services/jsonwebtoken');

const User = require('../models/User');

const hashPassword = async (password) => {
  const salt = await bcrypt.genSalt(10);
  const hashedPass = await bcrypt.hash(password, salt);
  return hashedPass;
};

const isvalidPassword = async (user, password) => {
  return await bcrypt.compare(password, user.password);
}

const login = async ({ username, password }) => {
  const user = await User.findOne({ username });
  if (!user) {
    return {
      status: 401,
      message: "The email or password you've entered is incorrect.",
    };
  }
  const isvalid = await isvalidPassword(user, password);
  if (!isvalid) {
    return {
      status: 401,
      message: "The email or password you've entered is incorrect.",
    };
  }
  const jwt = createJwt(user);
  return {
    status: 200,
    result: jwt,
  };
};

const register = async ({ username, firstName, lastName, password }) => {
  const userNameExist = await User.findOne({ username });
  if (userNameExist) {
    return {
      status: 409,
      message: 'User with email already exist.',
    };
  }
  try {
    const hashedPass = await hashPassword(password);
    await new User({
      username,
      firstName,
      lastName,
      password: hashedPass,
      _id: uuid.v4(),
    }).save();

    return {
      message: 'Registration successfuly',
      status: 201,
    };
  } catch (error) {
    return {
      message: 'An error occured while creating your account',
      status: 500,
    };
  }
};

module.exports.login = login;
module.exports.register = register;
