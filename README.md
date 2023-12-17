# Dexter Health Assessment

A new Flutter project.

# Technical Assignment Readme

## Difficulties Encountered
1. **Native Android Testing**: I needed more time to write tests for the native Android code due to less frequent use of the platform, which necessitated additional consultation of the documentation.
2. **Comprehensive Flutter Testing**: There was insufficient time to write integration, unit, and golden tests for the Flutter application. My focus was primarily on ensuring correct implementations within the given timeframe.

## Additions and Implementations
1. **Notification Service**: I added a notification service to inform users when the app is recording in the background, enhancing user awareness and app transparency.
2. **Response Differentiation**: As the endpoint consistently returns the same response (`{transcription: Untertitelung des ZDF, 2020}`), I appended a counter to each response. This ensures differentiation and makes it clear which are the three most recent translations displayed in the UI.

## Task Implementation Brief
1. **AlwaysListeningService**: I approached the task by first ensuring that the `AlwaysListeningService` was robust and capable of recording audio seamlessly in the foreground and background. 

2. **SpeechToTextService**: I implemented a service to handle incoming data from the native Android code, buffering audio data and processing it in the specified duration (5 seconds) to generate WAV files.

3. **WavFileCreator**: I created an utility class to convert audio bytes from the recording into a `.wav` file format, which is used by the `SpeechToTextService` for persisting audio recordings to files.

4. Following the services setup, I implemented a `DashboardBloc` to manage the application's state, handling incoming data and user interactions effectively.
