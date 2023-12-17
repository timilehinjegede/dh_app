import 'dart:io';

import 'package:dexter_health/core/core.dart';
import 'package:dexter_health/dexter_app.dart';
import 'package:dexter_health/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // setup http overrides to bypass the ssl/tls certificate validation
  HttpOverrides.global = DexterHttpOverrides();

  // setup the app config
  AppConfig.setEnvironment(Environment.production);

  // setup the serivce locator
  setupLocator();

  runApp(const DexterApp());
}
