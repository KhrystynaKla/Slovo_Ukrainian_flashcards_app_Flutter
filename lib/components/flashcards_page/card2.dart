
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/animation/half_flip_animation.dart';
import 'package:project/animation/slide_animation.dart';
import 'package:project/animation/slide_direction.dart';
import 'package:project/components/app/tts_button.dart';
import 'package:project/components/flashcards_page/card_display.dart';
import 'package:project/configs/constants.dart';
import 'package:project/notifiers/flashcards_notifier.dart';
import 'package:provider/provider.dart';

class Card2 extends StatelessWidget {
  const Card2({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FlashcardsNotifier>(
      builder: (_,notifier,__) => GestureDetector(
        onHorizontalDragEnd: (details){
          print(details.primaryVelocity);
          if(details.primaryVelocity! > 100){
            notifier.runSwipeCard2(direction: SlideDirection.leftAway);
            notifier.runSlideCard1();
            notifier.setIgnoreTouch(ignore: true);
            notifier.generateCurrentWord(context: context);
          }
          if(details.primaryVelocity! < -100){
            notifier.runSwipeCard2(direction: SlideDirection.rightAway);
            notifier.runSlideCard1();
            notifier.setIgnoreTouch(ignore: true);
            notifier.generateCurrentWord(context: context);
          }
        },
        child: HalfFlipAnimation(
          animate: notifier.flipCard2,
          reset: notifier.resetFlipCard2,
          flipFromHalfWay: true,
          animationCompleted: (){
            notifier.setIgnoreTouch(ignore: false);
            print('flip back animation');
          },
          child: SlideAnimation (
            animationCompleted: (){
              notifier.resetCard2();
            },
            reset: notifier.resetSwipedCard2,
            animate: notifier.swipedCard2,
            direction: notifier.swipedDirection,
            child: Center(
              child: Container(
                width: size.width*0.9,
                height: size.height*0.70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kCircularBorderRadius),
                  border: Border.all(color: Colors.white, width: kCardBorderWidth),
                  color: Theme.of(context).primaryColor, ),
                child: Center(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                      child: CardDisplay(isCard1: false,)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

