const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const User = require('../models/User');
const { sendVerificationEmail } = require('../utils/mailer');

exports.signup = async (req, res) => {
  const { email, password } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = await new User({ email, password: hashedPassword }).save();

    const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, { expiresIn: '1d' });
    await sendVerificationEmail(email, token);

    res.status(200).json({ message: 'Signup successful. Check your email to verify your account.' });
  } catch (error) {
    res.status(500).json({ message: 'Signup failed', error: error.message });
  }
};
