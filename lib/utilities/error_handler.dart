import 'package:domi_labs/utilities/app_exception.dart';

class ErrorHandler {
  T handleError<T>({
    required T Function() function,
  }) {
    try {
      return function();
    } on LocationServiceDisableException catch (_) {
      throw LocationServiceDisableException();
    } catch (error) {
      throw UnknownException(message: error.toString());
    }
  }

  Future<T> handleErrorAsync<T>({
    required Future<T> Function() function,
  }) async {
    try {
      return await function();
    } catch (error) {
      throw UnknownException(message: error.toString());
    }
  }
}
