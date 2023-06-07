abstract class UserException implements Exception {
  final String message;

  UserException(this.message);

  @override
  String toString() => 'UserException: $message';
}
