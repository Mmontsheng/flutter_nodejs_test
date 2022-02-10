const express = require('express');
const router = express.Router();
const verified = require('../middlerwares/authentication');
const { create, remove, update, get } = require('../services/weights');

const { create: createValidation } = require('../validation/weights');

router.get('/get_weight_history', verified, async (req, res) => {
  const { userId } = req;
  const { status, message, result } = await get(userId);
  res.status(status).json({ message, result, status });
});

router.delete('/delete_weight/:id', verified, async (req, res) => {
  const {
    userId,
    params: { id },
  } = req;
  const { status, message } = await remove(req.params);
  res.status(status).json({ message, status });
});

router.put('/update_weight/:id', verified, async (req, res) => {
  const {
    userId,
    body,
    params: { id },
  } = req;
  const error = createValidation(body);
  if (error) {
    const message = error.replace(/"/g, '');
    return res.status(400).json({ message });
  }

  const { status, message, result } = await update(id, req.body.value, userId);
  res.status(status).json({ message, status, result });
});

router.post('/save_weight', verified, async (req, res) => {
  const { userId, body } = req;
  const error = createValidation(body);
  if (error) {
    const message = error.replace(/"/g, '');
    return res.status(400).json({ message, status: 400 });
  }

  const { status, message, result } = await create(req.body, userId);
  res.status(status).json({ message, status, result });
});
module.exports = router;
