const express = require('express');
const { signup } = require('../controllers/authController');

const router = express.Router();

router.post('/signup', signup);
// Add other routes for login, email verification, etc.

module.exports = router;