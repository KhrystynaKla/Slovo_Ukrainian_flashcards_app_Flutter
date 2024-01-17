import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/components/app/tts_button.dart';
import 'package:project/components/settings/settings.dart';
import 'package:project/notifiers/flashcards_notifier.dart';
import 'package:project/notifiers/settings_notifier.dart';
import 'package:provider/provider.dart';

class CardDisplay extends StatelessWidget {
  const CardDisplay({ required this.isCard1,
    super.key,
  });

  final bool isCard1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<SettingsNotifier>(
        builder: (_, notifier,__) {

          final setEnglishFirst =notifier.displayOptions.entries.firstWhere((element) => 
          element.key == Settings.englishFirst).value;

          final showSpelling = notifier.displayOptions.entries.firstWhere((element) => 
          element.key == Settings.showSpelling).value;

          final audioOnly = notifier.displayOptions.entries.firstWhere((element) => 
          element.key == Settings.audioOnly).value;


          return Consumer<FlashcardsNotifier>(
          builder: (_, notifier, __) => isCard1 ? Center(
            child: Column(
              children: [
                if (audioOnly) ... [
                  const TTSButton(),
                  
                ]else if(!setEnglishFirst) ... [
                  Padding(
                  padding: const EdgeInsets.all(10.0),
                    child: Text(notifier.word1.ukrainian, style: Theme.of(context).textTheme.displayLarge,),
                  ),
                  showSpelling ? Text(notifier.word1.spelling, style: Theme.of(context).textTheme.bodyMedium,) : SizedBox(),
                  const TTSButton(),
                ] else ... [
                  Text(notifier.word1.english, style: Theme.of(context).textTheme.displayLarge,),
                ]
              ],
            )):
            Column(
              children: [
                if (audioOnly) ... [
                  Padding(
                  padding: const EdgeInsets.all(10.0),
                    child: Text(notifier.word2.ukrainian, style: Theme.of(context).textTheme.displayLarge,),
                  ),
                  showSpelling ? Text(notifier.word2.spelling, style: Theme.of(context).textTheme.bodyMedium,) : SizedBox(),

                  const TTSButton(),
                  Text(notifier.word2.english, style: Theme.of(context).textTheme.displayLarge,),
                  
                ]else if(!setEnglishFirst)... [
                  Text(notifier.word2.english, style: Theme.of(context).textTheme.displayLarge,),
                ] else ... [
                  Padding(
                  padding: const EdgeInsets.all(10.0),
                    child: Text(notifier.word2.ukrainian, style: Theme.of(context).textTheme.displayLarge,),
                  ),
                  showSpelling ? Text(notifier.word2.spelling, style: Theme.of(context).textTheme.bodyMedium,) : SizedBox(),
                  const TTSButton(),
                ]
              ],
            )
        );
        },
      ),
    );
      
  }
}
