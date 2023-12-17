import 'package:dexter_health/utils/utils.dart';
import 'package:flutter/material.dart';

import 'features/dashboard/presentation/pages/dashboard_page.dart';

class DexterApp extends StatelessWidget {
  const DexterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dexter Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Builder(
        builder: (context) {
          final media = MediaQuery.of(context);
          Dims.setSize(media);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1),
            ),
            child: const DashboardPage(),
          );
        },
      ),
    );
  }
}
