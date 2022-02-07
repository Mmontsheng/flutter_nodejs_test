const parseError = ({error}) => {
  if (error) {
    return error.details[0].message;
  }
  return null;
}

module.exports.parseError = parseError;
