import 'package:soundbox_sdk/soundbox_sdk.dart';

void main() async {
  final client = SoundboxClient(
    baseUrl: 'https://soundbox.qr4pos.com',
    token: 'YOUR_PARTNER_TOKEN',
  );

  try {
    final response = await client.createVoice(
      amount: 1520.75,
      lang: 'si',
      mid: 'TERM-001',
    );

    print('Audio URL: ${response.audioUrl}');
    print('Expires in: ${response.expiresIn} seconds');
  } on SoundboxAuthException catch (e) {
    print('Auth failed: ${e.message}');
  } on SoundboxRateLimitException catch (e) {
    print('Rate limited. Retry after ${e.retryAfter}s');
  } on SoundboxException catch (e) {
    print('API error: ${e.message}');
  } finally {
    client.dispose();
  }
}
