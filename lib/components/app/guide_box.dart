import 'package:flutter/material.dart';
import 'package:project/animation/fading.dart';

class GuideBox extends StatelessWidget {
  const GuideBox({required this.isFirst, super.key});

  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightPadding = size.height*0.2;
    final widthPadding = size.width*0.1;
    return FadeInAnimation(
      child: AlertDialog( 
        insetPadding: EdgeInsets.fromLTRB(widthPadding, heightPadding, widthPadding, heightPadding),
        content: Column(
          children: [
            if(isFirst) ... [
            Text("Double Tap\nTo Reveal the Answer", textAlign: TextAlign.center,),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset('assets/images/GuideDoubleTap1.png'),
            )),] else ...[
              Expanded(
                child: Row(
                  children: [
                    GuideSwipe(isLeft: true,),
                    GuideSwipe(isLeft: false,),
                  ],
                ),
              )
            ]
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: size.width*0.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                Navigator.maybePop(context);
              
              }, child: Text('Got It!')),
            ),
          )
        ],
        ),
    );
  }
}

class GuideSwipe extends StatelessWidget {
  const GuideSwipe({ required this.isLeft,
    super.key,
  });

  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          isLeft ? 
          Text('Swipe Left\nIf Incorrect', textAlign: TextAlign.center,):
          Text('Swipe Right\nIf Correct', textAlign: TextAlign.center,),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: isLeft?  Image.asset('assets/images/GuideSwipeLeft1.png'): Image.asset('assets/images/GuideSwipeRight1.png'),
          )),
        ],
      ),
    );
  }
}