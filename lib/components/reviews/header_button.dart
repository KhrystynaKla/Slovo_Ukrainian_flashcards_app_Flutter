import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({ required this.title, required this.onPressed,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: onPressed, child: Text(title)),
    ));
  }
}