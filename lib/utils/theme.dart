// base theme
import 'package:dexter_health/utils/colors.dart';
import 'package:flutter/material.dart';

final baseTheme = ThemeData.light(useMaterial3: true);

final ThemeData appTheme = baseTheme.copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  textTheme: baseTheme.copyWith().textTheme.apply(
        fontFamily: 'HelveticaNeue',
        bodyColor: appColors.text,
      ),
);
