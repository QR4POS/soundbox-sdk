import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/voice_request.dart';
import 'models/voice_response.dart';
import 'models/soundbox_exception.dart';

class SoundboxClient {
  final String baseUrl;
  final String token;
  final http.Client _http;

  SoundboxClient({
    required this.baseUrl,
    required this.token,
    http.Client? httpClient,
  }) : _http = httpClient ?? http.Client();

  void dispose() {
    _http.close();
  }

  Future<VoiceResponse> createVoice({
    required double amount,
    String lang = 'si',
    required String mid,
  }) async {
    final request = VoiceRequest(amount: amount, lang: lang, mid: mid);

    final uri = Uri.parse('$baseUrl/api/v1/voice');
    final response = await _http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return VoiceResponse.fromJson(data);
    }

    throw _mapError(response.statusCode, response.body);
  }

  SoundboxException _mapError(int statusCode, String body) {
    String message;
    try {
      final data = jsonDecode(body) as Map<String, dynamic>;
      message = data['error'] as String? ?? 'Unknown error';
    } catch (_) {
      message = 'HTTP $statusCode';
    }

    switch (statusCode) {
      case 401:
      case 403:
        return SoundboxAuthException(message: message, statusCode: statusCode, errorBody: body);
      case 429:
        return SoundboxRateLimitException(
          message: message,
          statusCode: statusCode,
          errorBody: body,
          retryAfter: 60,
        );
      default:
        return SoundboxException(message: message, statusCode: statusCode, errorBody: body);
    }
  }
}
