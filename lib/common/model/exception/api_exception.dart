class ApiException implements Exception {
  final String errorCode;
  final String errorMessage;

  ApiException({required this.errorMessage, required this.errorCode});

  @override
  String toString() => 'ApiException($errorCode): $errorMessage';
}
