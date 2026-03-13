class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}

class AppTimeoutException implements Exception {
  final String message;
  AppTimeoutException(this.message);

  @override
  String toString() => message;
}

class CacheException implements Exception {}
