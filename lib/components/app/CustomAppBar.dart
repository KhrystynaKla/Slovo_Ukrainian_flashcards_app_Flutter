import 'package:flutter/material.dart';
import 'package:project/notifiers/flashcards_notifier.dart';
import 'package:project/pages/home_page.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => AppBar(
        actions: [
          IconButton(onPressed: (){
            notifier.reset();
            notifier.resetCard2();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
          }, icon: const Icon(Icons.clear))
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: notifier.topic, 
          child: Image.asset('assets/images/${notifier.topic}.png')),
        ),
        title: Text(notifier.topic),
      ),
    );
  }
}
