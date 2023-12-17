import 'package:dexter_health/features/dashboard/domain/bloc/dashboard_bloc.dart';
import 'package:dexter_health/features/dashboard/presentation/widgets/app_bar.dart';
import 'package:dexter_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appStyles = AppStyles();

    final dashboardBloc = context.watch<DashboardBloc>();

    return Scaffold(
      appBar: const DexterAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: hPadding,
          vertical: vPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Always Listening',
              style: appStyles.medium20,
            ),
            YBox(20.dy),
            Text(
              'This app is always listening to you.\nEvery 10 seconds, we send that audio to our\nSTT API.\nThe last 3 transcripts will be shown on the screen. Additionally, we show a timer that indicates since when the app is listening.',
              style: appStyles.medium14,
            ),
            YBox(50.dy),
            Align(
              child: Text(
                'API call counter',
                style: appStyles.medium14,
              ),
            ),
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state.error != null) {
                  return SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        state.error.toString(),
                        style: appStyles.medium16,
                      ),
                    ),
                  );
                }

                // final loadedState = state as DashboardLoaded;
                final translations = state.translations;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: Text(
                        '0${dashboardBloc.translations.length}',
                        style: appStyles.medium40,
                      ),
                    ),
                    YBox(50.dy),
                    Text(
                      'Last STT transcripts',
                      style: appStyles.medium14,
                    ),
                    YBox(20.dy),
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (_, __) => Divider(
                        color: appColors.text,
                        height: 30,
                      ),
                      itemBuilder: (context, index) {
                        final translation = translations[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            translation,
                            style: appStyles.medium16,
                          ),
                        );
                      },
                      itemCount: state.translations.length,
                    ),
                    if (state.isLoading) ...[
                      YBox(20.dy),
                      const Align(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
