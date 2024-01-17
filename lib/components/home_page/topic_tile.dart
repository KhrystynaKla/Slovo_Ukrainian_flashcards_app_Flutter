import 'package:flutter/material.dart';
import 'package:project/animation/fading.dart';
import 'package:project/configs/constants.dart';
import 'package:project/functionality/methods.dart';

class TopicTile extends StatelessWidget {
  const TopicTile({
    super.key,
    required this.topic,
  });

  final String topic;


  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      child: GestureDetector(
        onTap: () {
          print('tile tapped topic: $topic');
          loadSession(context: context, topic: topic);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(kCircularBorderRadius)
           ),
          
          child: Column(
            children: [
              Expanded(
                flex:2,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Hero(
                    tag: topic,
                    child: Image.asset('assets/images/$topic.png')),
                )),
              Expanded(child: Text(topic)),
            ],
          ),
        ),
      ),
    );
  }
}