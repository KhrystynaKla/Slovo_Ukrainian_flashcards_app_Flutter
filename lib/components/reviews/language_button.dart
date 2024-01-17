import 'package:flutter/material.dart';

enum LanguageType {english, ukrainian, spelling}

class LanguageButton extends StatelessWidget {
  const LanguageButton({ required this.languageType,
    super.key,
  });

  final LanguageType languageType;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Padding(
      padding: const EdgeInsets.fromLTRB(6, 1, 6,1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor
        ),
        onPressed: (){}, child: Text(languageType.name)),
    ));
  }
}
