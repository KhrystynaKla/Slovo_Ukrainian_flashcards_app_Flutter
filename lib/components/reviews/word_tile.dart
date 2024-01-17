import 'package:flutter/material.dart';
import 'package:project/data_sqlite/word_model.dart';

class WordTile extends StatelessWidget {
  const WordTile({ required this.word,
    super.key,
  });

  final Word word;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(word.english),
            Text(word.ukrainian),
            Text(word.spelling),
          ],
        ),
        trailing: IconButton(icon: Icon(Icons.clear), onPressed: (){}),
      ),
    );
  }
}