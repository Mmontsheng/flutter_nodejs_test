const jsonwebtoken = require('jsonwebtoken');

const createJwt = ({ _id, firstName, lastName }) => {
  return jwt.sign(
    {
      id: _id,
      firstName,
      lastName,
    },
    process.env.JWT_SECRET
  );
};

const decode = (req) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  if (!token) {
    return null;
  }
  return jsonwebtoken.verify(token, process.env.JWT_SECRET);
};

module.exports.createJwt = createJwt;
module.exports.decode = decode;
