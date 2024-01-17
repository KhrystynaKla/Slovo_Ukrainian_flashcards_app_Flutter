class UserPickedWord {
  int id; // id of the picked word
  int pickedWordId;

  UserPickedWord({
    required this.id,
    required this.pickedWordId,
  });

  // A constructor to create UserPickedWord from a map
  factory UserPickedWord.fromMap(Map<String, dynamic> map) {
    return UserPickedWord(
      id: map['id'],
      pickedWordId: map['pickedWordId'],
    );
  }

  // A method to convert UserPickedWord to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pickedWordId': pickedWordId,
    };
  }

  // @override
  // String toString() {
  //   return '{id: $id, pickedWordId: $pickedWordId}';
  // }
}
