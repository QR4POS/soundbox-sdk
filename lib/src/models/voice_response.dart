class VoiceResponse {
  final String audioUrl;
  final int expiresIn;

  const VoiceResponse({
    required this.audioUrl,
    required this.expiresIn,
  });

  factory VoiceResponse.fromJson(Map<String, dynamic> json) {
    return VoiceResponse(
      audioUrl: json['audio_url'] as String,
      expiresIn: json['expires_in'] as int,
    );
  }
}
