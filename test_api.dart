import 'dart:io';
import 'package:soundbox_sdk/soundbox_sdk.dart';

String? _readEnv(String key) {
  final file = File('.env');
  if (!file.existsSync()) return null;
  for (final line in file.readAsLinesSync()) {
    final t = line.trim();
    if (t.isEmpty || t.startsWith('#')) continue;
    final i = t.indexOf('=');
    if (i > 0 && t.substring(0, i).trim() == key) {
      return t.substring(i + 1).trim();
    }
  }
  return null;
}

void main() async {
  final token = _readEnv('PARTNER_TOKEN') ?? 'YOUR_TOKEN';
  if (token == 'YOUR_TOKEN') {
    print('❌ Set PARTNER_TOKEN in .env file');
    exit(1);
  }

  final client = SoundboxClient(
    baseUrl: 'https://soundbox.qr4pos.com',
    token: token,
  );

  try {
    final res = await client.createVoice(
      amount: 1520.75,
      lang: 'si',
      mid: 'TERM-001',
    );

    print('✅ Audio URL: ${res.audioUrl}');
    print('✅ Expires in: ${res.expiresIn}s');
  } on SoundboxAuthException catch (e) {
    print('❌ Auth failed: ${e.message}');
  } on SoundboxException catch (e) {
    print('❌ API error: ${e.message}');
  } finally {
    client.dispose();
  }
}
