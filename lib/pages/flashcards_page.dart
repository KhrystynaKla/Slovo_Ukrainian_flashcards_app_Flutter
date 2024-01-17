import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/components/app/CustomAppBar.dart';
import 'package:project/components/flashcards_page/card1.dart';
import 'package:project/components/flashcards_page/card2.dart';
import 'package:project/components/flashcards_page/progress_bar.dart';
import 'package:project/configs/constants.dart';
import 'package:project/notifiers/flashcards_notifier.dart';
import 'package:project/utils/methods.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key});

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final flashcardsNotifier = Provider.of<FlashcardsNotifier>(context, listen: false);
      flashcardsNotifier.runSlideCard1();
      flashcardsNotifier.generateAllSelectedWords(context);
      flashcardsNotifier.generateCurrentWord(context: context);
      SharedPreferences.getInstance().then((prefs){
        if (prefs.getBool('guidebox')==null){
          runGuideBox(context: context, isFirst: true);
        }
      });
      
    });
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kAppBarHeight),
          child: CustomAppBar()),
        body: IgnorePointer(
          ignoring: notifier.ignoreTouches,
          child: const Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ProgressBar()),
              Card2(),
              Card1(),
            ],
          ),
        ),
      ),
    );
  }
}

