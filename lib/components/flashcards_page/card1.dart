
import 'package:flutter/material.dart';
import 'package:project/animation/half_flip_animation.dart';
import 'package:project/animation/slide_animation.dart';
import 'package:project/animation/slide_direction.dart';
import 'package:project/components/flashcards_page/card_display.dart';
import 'package:project/configs/constants.dart';
import 'package:project/notifiers/flashcards_notifier.dart';
import 'package:project/utils/methods.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Card1 extends StatelessWidget {
  const Card1({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FlashcardsNotifier>(
      builder: (_,notifier,__) => GestureDetector(
        onDoubleTap: (){
          notifier.setIgnoreTouch(ignore: true);
          notifier.runFlipCard1();
          
          SharedPreferences.getInstance().then((prefs){
            if (prefs.getBool('guidebox')==null){
              runGuideBox(context: context, isFirst: false);
            }
          });
        },
        child: HalfFlipAnimation(
          animate: notifier.flipCard1,
          reset: notifier.resetFlipCard1,
          flipFromHalfWay: false,
          animationCompleted: (){
            notifier.resetCard1();
            notifier.runFlipCard2();
          },
          child: SlideAnimation (
            // animationDuration: 1000,
            animationDelay: 200,
            animationCompleted: (){
              notifier.setIgnoreTouch(ignore: false);
            },
            reset: notifier.resetSlidecard1,
            animate: notifier.slidecard1 && !notifier.isRoundCompleted,
            direction: SlideDirection.upIn,
            child: Center(
              child: Container(
                width: size.width*0.9,
                height: size.height*0.70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kCircularBorderRadius),
                  border: Border.all(color: Colors.white, width: kCardBorderWidth),
                  color: Theme.of(context).primaryColor, ),
                child: CardDisplay(isCard1: true,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


