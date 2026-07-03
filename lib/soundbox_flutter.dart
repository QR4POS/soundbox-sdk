library soundbox_flutter;

export 'soundbox_sdk.dart';

import 'soundbox_sdk.dart';
import 'package:just_audio/just_audio.dart';

class SoundboxPlayer {
  final SoundboxClient _client;

  SoundboxPlayer(this._client);

  Future<void> play({
    required double amount,
    String lang = 'si',
    required String mid,
  }) async {
    final response = await _client.createVoice(
      amount: amount,
      lang: lang,
      mid: mid,
    );

    final player = AudioPlayer();
    await player.setAudioSource(AudioSource.uri(Uri.parse(response.audioUrl)));
    await player.play();

    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        player.dispose();
      }
    });
  }
}
