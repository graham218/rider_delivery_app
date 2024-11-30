import 'package:flutter/material.dart';

mixin Constants {
  // if you deploy on any server you just need to change this, only in one place
  static String uri = "http://localhost:3000";
}
// for getting IP use ipconfig on cmd

// Color Constants
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

// Padding Constants
const defaultPadding = 16.0;
