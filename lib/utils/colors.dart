// app colors
import 'package:flutter/material.dart';

const appColors = ThemeModel(
  text: Color(0xFF353535),
  blue: Color(0xFF70AFED),
  icon: Color(0xFF33363F),
  black: Colors.black,
  white: Colors.white,
  transparent: Colors.transparent,
);

// theme model
class ThemeModel {
  const ThemeModel({
    required this.text,
    required this.blue,
    required this.icon,
    required this.white,
    required this.black,
    required this.transparent,
  });

  final Color text;
  final Color blue;
  final Color icon;
  final Color white;
  final Color black;
  final Color transparent;
}
