class SoundboxException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorBody;

  const SoundboxException({required this.message, this.statusCode, this.errorBody});

  @override
  String toString() => 'SoundboxException: $message${statusCode != null ? ' (HTTP $statusCode)' : ''}';
}

class SoundboxAuthException extends SoundboxException {
  const SoundboxAuthException({required super.message, super.statusCode, super.errorBody});
}

class SoundboxRateLimitException extends SoundboxException {
  final int retryAfter;

  const SoundboxRateLimitException({required this.retryAfter, required super.message, super.statusCode, super.errorBody});
}

class SoundboxNetworkException extends SoundboxException {
  const SoundboxNetworkException({required super.message, super.errorBody});
}
