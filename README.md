# Soundbox SDK

Dart client SDK for the Currency Soundbox API. Converts payment amounts to spoken audio in Sinhala, English, and Tamil.

## Install

```yaml
dependencies:
  soundbox_sdk:
    git:
      url: https://github.com/QR4POS/soundbox_sdk.git
      ref: v1.0.0
```

## Usage

```dart
import 'package:soundbox_sdk/soundbox_sdk.dart';

final client = SoundboxClient(
  baseUrl: 'https://soundbox.qr4pos.com',
  token: 'YOUR_PARTNER_TOKEN',
);

// Get a signed audio URL
final response = await client.createVoice(
  amount: 1520.75,
  lang: 'si',
  mid: 'TERM-001',
);

print('Audio URL: ${response.audioUrl}');
```

### Play audio directly (Flutter only)

```dart
import 'package:soundbox_sdk/soundbox_flutter.dart';

final client = SoundboxClient(baseUrl: '...', token: '...');
final player = SoundboxPlayer(client);

await player.play(amount: 1520.75, lang: 'si', mid: 'TERM-001');
// Audio plays from speaker. Auto-disposes when done.
```

## API

### `SoundboxClient`

| Method | Returns | Description |
|---|---|---|
| `createVoice({amount, lang, mid})` | `VoiceResponse` | Generate audio. Returns a signed expiring URL. |
| `dispose()` | `void` | Close the HTTP client. |

### `VoiceResponse`

| Field | Type | Description |
|---|---|---|
| `audioUrl` | `String` | Signed URL to the MP3. Valid for `expiresIn` seconds. |
| `expiresIn` | `int` | Seconds until the URL expires (default 300). |

### Errors

| Exception | HTTP | Cause |
|---|---|---|
| `SoundboxAuthException` | 401, 403 | Invalid or missing token |
| `SoundboxRateLimitException` | 429 | Too many requests (60/min) |
| `SoundboxNetworkException` | — | Connection failed |
| `SoundboxException` | 400, 500 | Other API errors |

## Languages

| `lang` | Language |
|---|---|
| `si` | Sinhala (default) |
| `en` | English |
| `ta` | Tamil |

## Requirements

- Dart SDK >=3.0.0
- Flutter required for `SoundboxPlayer` audio playback
