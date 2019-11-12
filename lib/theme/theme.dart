import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class ColorsTheme {
  static const Color primaryColor = Color(0xFF1C7AB7);
  static const Color secondaryColor = Color(0xFF1C7AB5);

  static LinearGradient gradient = LinearGradient(
    colors: const [primaryColor, secondaryColor],
  );
}

class Settings {
  static final orientation = SystemChrome.setPreferredOrientations(
      ([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]));
  static final statusBar = SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}
