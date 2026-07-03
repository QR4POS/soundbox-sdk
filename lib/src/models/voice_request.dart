class VoiceRequest {
  final double amount;
  final String lang;
  final String mid;

  const VoiceRequest({
    required this.amount,
    this.lang = 'si',
    required this.mid,
  });

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'lang': lang,
        'mid': mid,
      };
}
