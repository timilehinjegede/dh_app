import 'package:dexter_health/features/dashboard/presentation/widgets/app_bar.dart';
import 'package:dexter_health/utils/utils.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appStyles = AppStyles();
    // var listeningService = SpeechToTextService(
    //   onData: (file) {
    //     // Do something with the file, e.g., update the UI or process the file
    //     print("New WAV file created: ${file.path}");
    //    DioHttpApi().uploadFile(
    //   appEndpoints.speechToText,
    //   file: wavFile,
    // );
    //   },
    // );

    // listeningService.startListening();

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
            Align(
              child: Text(
                '03',
                style: appStyles.medium40,
              ),
            ),
            YBox(50.dy),
            Text(
              'Last STT transcripts',
              style: appStyles.medium14,
            ),
            YBox(10.dy),
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              separatorBuilder: (_, __) => Divider(
                color: appColors.text,
                height: 30,
              ),
              itemBuilder: (context, index) {
                return Text(
                  'Hello Hello, are you still listening? This is the third test.',
                  style: appStyles.medium16,
                );
              },
              itemCount: 3,
            ),
          ],
        ),
      ),
    );
  }
}
