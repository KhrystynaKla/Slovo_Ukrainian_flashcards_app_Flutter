import 'package:flutter/material.dart';
import 'package:project/components/app/CustomAppBar.dart';
import 'package:project/components/reviews/header_button.dart';
import 'package:project/configs/constants.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarHeight),
        child: CustomAppBar()),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                HeaderButton(title: 'Insert Card', onPressed: (){print('i');},),
                HeaderButton(title: 'Clear Cards', onPressed: (){print('c');},)
              ],
              )
              ),
              Expanded(
                flex: 10,
                child: AnimatedList(
                  itemBuilder: (context, index, animation) =>ListTile(),
                ),
                )
        ],)
    );
  }
}

