const Joi = require('joi');
const { parseError }= require('./utils');

const create = (data) => {
  const JoiSchema = Joi.object({
    value: Joi.number().min(1).required(),
  }).options({ abortEarly: false });

  const output = JoiSchema.validate(data);
  return parseError(output);
};


module.exports.create = create;
