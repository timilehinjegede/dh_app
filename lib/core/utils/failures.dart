abstract class Failure {
  Failure(this.message);
  final String message;
}

class ApiFailure extends Failure {
  ApiFailure({String message = ''}) : super(message);

  @override
  String toString() => message;
}

class CacheFailure extends Failure {
  CacheFailure({String message = ''}) : super(message);

  @override
  String toString() => message;
}
