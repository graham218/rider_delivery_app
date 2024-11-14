const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  username: String,
  email: { type: String, required: true, unique: true },
  password: String,
  isVerified: { type: Boolean, default: false },
  googleId: String,
  githubId: String,
});

module.exports = mongoose.model('User', userSchema);