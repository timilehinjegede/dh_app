import 'package:dexter_health/features/dashboard/domain/bloc/dashboard_bloc.dart';
import 'package:dexter_health/service_locator.dart';
import 'package:dexter_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/dashboard/presentation/pages/dashboard_page.dart';

class DexterApp extends StatelessWidget {
  const DexterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dashboardBloc = serviceLocator<DashboardBloc>();

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
            child: BlocProvider<DashboardBloc>(
              create: (context) {
                dashboardBloc.add(const DashboardSetupEvent());

                return dashboardBloc;
              },
              child: const DashboardPage(),
            ),
          );
        },
      ),
    );
  }
}
