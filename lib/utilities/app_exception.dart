sealed class AppException implements Exception {
  AppException({required this.message});

  final String message;
}

class UnknownException extends AppException {
  UnknownException({required super.message});
}

class LocationServiceDisableException extends AppException {
  LocationServiceDisableException()
      : super(message: 'Location services are disabled.');
}

class LocationPermDeniedException extends AppException {
  LocationPermDeniedException()
      : super(message: 'Location permissions are denied.');
}

class LocationPermDeniedPermanentlyException extends AppException {
  LocationPermDeniedPermanentlyException()
      : super(message: 'Location permissions are denied permanently.');
}
