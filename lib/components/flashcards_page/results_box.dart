import 'package:flutter/material.dart';
import 'package:project/notifiers/flashcards_notifier.dart';
import 'package:project/pages/flashcards_page.dart';
import 'package:project/pages/home_page.dart';
import 'package:provider/provider.dart';

class ResultsBox extends StatefulWidget {
  const ResultsBox({super.key});

  @override
  State<ResultsBox> createState() => _ResultsBoxState();
}

class _ResultsBoxState extends State<ResultsBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder:(_, notifier, __) => AlertDialog(
        title: Text(
          notifier.isSessionCompleted ?'Session Completed!':'Round Completed!', 
          textAlign: TextAlign.center,),
        actions: [
          Table(
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            children: [
              buildTableRow(title : 'Total Rounds', stat: notifier.roundTally.toString()),
              buildTableRow(title : '№ Cards', stat: notifier.cardTally.toString()),
              buildTableRow(title : '№ Correct', stat: notifier.correctTally.toString()),
              buildTableRow(title : '№ Incorrect', stat: notifier.incorrectTally.toString()),
              buildTableRow(title : 'Correct Percentage', stat: '${notifier.correctPercentage.toString()} %'),
            ]
          ,),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  notifier.isSessionCompleted ? SizedBox() : ElevatedButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FlashcardsPage(),),);
                  }, child: Text('Retest Incorrect Cards'),),
              
                  ElevatedButton(onPressed: (){
                    notifier.reset();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
                  }, child: Text('Home'),),
              
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // TableRow buildTableRow({required String title, required String stat}) {
  //   return TableRow(
  //             children: [
  //               TableCell(child: Text(title)),
  //               TableCell(child: Text(stat, textAlign: TextAlign.right,)),

  //             ]
  //           );
  // }
  TableRow buildTableRow({required String title, required String stat}) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
          child: Text(title),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
          child: Text(stat, textAlign: TextAlign.right),
        ),
      ),
    ],
  );
}
}