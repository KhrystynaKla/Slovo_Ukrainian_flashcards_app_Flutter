class Word {
  int? id;
  final String topic;
  final String english;
  final String ukrainian;
  final String spelling;

  Word(
      {required this.topic,
      required this.english,
      required this.ukrainian,
      required this.spelling});

  Map<String, dynamic> toMap() {
    return {
      'topic': topic,
      'english': english,
      'ukrainian': ukrainian,
      'spelling': spelling,
    };
  }

  factory Word.fromMap({required Map<String, dynamic> map}) {
    return Word(
        topic: map['topic'],
        english: map['english'],
        ukrainian: map['ukrainian'],
        spelling: map['spelling'],
      );
  }
}