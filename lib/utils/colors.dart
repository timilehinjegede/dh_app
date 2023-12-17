// app colors
import 'package:flutter/material.dart';

const appColors = ThemeModel(
  black: Colors.black,
  white: Colors.white,
  transparent: Colors.transparent,
);

// theme model
class ThemeModel {
  const ThemeModel({
    required this.white,
    required this.black,
    required this.transparent,
  });

  final Color white;
  final Color black;
  final Color transparent;
}
