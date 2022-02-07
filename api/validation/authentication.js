const Joi = require('joi');
const { parseError }= require('./utils');

const register = (data) => {
  const JoiSchema = Joi.object({
    username: Joi.string().email().required(),
    password: Joi.string().min(6).required(),
    firstName: Joi.string().required(),
    lastName: Joi.string().required(),
  }).options({ abortEarly: false });

  const output = JoiSchema.validate(data);
  return parseError(output);
};

const login = (data) => {
  const JoiSchema = Joi.object({
    username: Joi.string().email().required(),
    password: Joi.string().required(),
  }).options({ abortEarly: false });

  const output = JoiSchema.validate(data);
  return parseError(output);
};


module.exports.register = register;
module.exports.login = login;
