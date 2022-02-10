const { decode } = require('../services/jsonwebtoken');

module.exports = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  if (!token) {
    res.status(401).json({ message: 'Unauthorized', status: 401 });
    return;
  }
  try {
    const { id } = decode(req);
    req.userId = id;
    next();
  } catch (error) {
    console.log(error);
    res.status(401).json({ message: 'Unauthorized', status: 401 });
  }
};
