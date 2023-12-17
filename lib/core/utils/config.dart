enum Environment { development, production }

class AppConfig {
  AppConfig._();

  static late Map<String, String> _constants;

  static void setEnvironment(Environment environment) {
    switch (environment) {
      case Environment.development:
        _constants = _Constants.developmentConstants;
        break;

      case Environment.production:
        _constants = _Constants.prodConstants;
        break;
    }
  }

  static String get baseUrl {
    return _constants[_Constants.baseUrl]!;
  }

  static String get appName {
    return _constants[_Constants.appName]!;
  }
}

class _Constants {
  static const baseUrl = 'BASE_URL';

  static const appName = 'APP_NAME';

  static Map<String, String> developmentConstants = {
    baseUrl: '',
    appName: 'Dexter Health Test',
  };

  static Map<String, String> prodConstants = {
    baseUrl: '',
    appName: 'Dexter Health',
  };
}
