const express = require('express');
const router = express.Router();

const {
  login: loginValidation,
  register: registerValidation,
} = require('../validation/authentication');

const { register, login } = require('../services/authentication');

router.post('/login', async (req, res) => {
  const error = loginValidation(req.body);
  if (error) {
    const message = error.replace(/"/g, '');
    return res.status(400).json({ message, status: 400 });
  }
  const { status, message, result } = await login(req.body);
  res.status(status).json({ message, result, status });
});

router.post('/sign_up', async (req, res) => {
  const error = registerValidation(req.body);
  if (error) {
    const message = error.replace(/"/g, '');
    return res.status(400).json({ message, status: 400 });
  }
  const { status, message } = await register(req.body);

  res.status(status).json({ message,  status });
});

module.exports = router;
