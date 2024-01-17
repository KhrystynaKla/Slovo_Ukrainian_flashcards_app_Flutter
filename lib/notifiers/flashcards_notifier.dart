import 'dart:ffi';
// ignore: avoid_web_libraries_in_flutter
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:project/animation/slide_direction.dart';
import 'package:project/components/flashcards_page/results_box.dart';
import 'package:project/configs/constants.dart';
import 'package:project/data_sqlite/database_helper.dart';
import 'package:project/data_sqlite/word_model.dart';
import 'package:sqflite/sqflite.dart';
class FlashcardsNotifier extends ChangeNotifier {

  int roundTally=0, cardTally = 0, correctTally = 0, incorrectTally =0, correctPercentage = 0;

  calculateCorrectPercentage(){
    final percentage = correctTally/cardTally;
    correctPercentage = (percentage*100).round();
    return correctPercentage;
  }

  double percentageComplete = 0.0;

  calculateCompletedPercentage(){
    percentageComplete =(correctTally+incorrectTally)/cardTally;
    notifyListeners();

  }

  resetProgressBar(){
    percentageComplete = 0.0;
    notifyListeners();
  }

  List<Word> incorectCards =[];


  DatabaseHelper dbHelper = DatabaseHelper();
  late Database db;

  String topic = '';
  Word word1 = Word(topic: "", english: "", ukrainian: "", spelling: "");
  Word word2 = Word(topic: "", english: "Loading Arrow", ukrainian: "", spelling: "");
  List<Word> selectedWords = [];

  bool isFirstRound = true, isRoundCompleted = false, isLastWord =false, isSessionCompleted=false;


  reset(){
    isFirstRound = true;
    isRoundCompleted = false;
    isLastWord = false;
    isSessionCompleted = false;
    incorectCards.clear(); 
    roundTally = 0;

  }

  setTopic({required String topic}) {
    this.topic = topic;
    notifyListeners();
  }

  Future<void> generateAllSelectedWords(BuildContext context) async {
    roundTally ++;
    selectedWords.clear();
    isRoundCompleted = false;
    if(isFirstRound){
      isLastWord=false;
      try {
        db = await dbHelper.database;
        List<Word> words = await dbHelper.getWordsByTopic(topic);
        words.shuffle();
        selectedWords = words;
        print(selectedWords.length);

        generateCurrentWord(context: context);
      } catch (e) {
        // Handle initialization error, show a message to the user or log the error.
        print('Error initializing the database: $e');
      }

      notifyListeners();
    } else {
      selectedWords = incorectCards.toList();
      incorectCards.clear();
    }

    cardTally = isFirstRound? 10: selectedWords.length;
    correctTally = 0;
    incorrectTally =0;
    resetProgressBar();
  }

  generateCurrentWord({required BuildContext context}) {
  if (selectedWords.isNotEmpty) {
    final result = Random().nextInt(selectedWords.length);
    word1 = selectedWords[result];
    selectedWords.removeAt(result);
    if ((selectedWords.length)==1){
      isLastWord = true;
    }
  } else if ( isLastWord){
    if(incorectCards.isEmpty){
      isSessionCompleted = true;
      print('sessionCompleted $isSessionCompleted');
    }
    isFirstRound = false;
    isRoundCompleted = true;
    calculateCorrectPercentage();
    Future.delayed(Duration(milliseconds: 500),(){
      showDialog(context: context, builder: (context)=>ResultsBox());
    });
    // Handle the case where selectedWords is empty.
  }

  Future.delayed(Duration(milliseconds: kSlideAwayDuration), (){
    word2 = word1;
  });
}

  Future<void> setTopicAndGenerateWords({required String topic, context,}) async {
    setTopic(topic: topic);
    await generateAllSelectedWords(context);
    // generateCurrentWord();
  }

  updateCardOutcome({required Word word, required bool isCorrect}) {
    if (!isCorrect) {
      incorrectTally++;
      incorectCards.add(word);
    } else{
      correctTally++;
    }
    calculateCompletedPercentage();
    incorectCards.forEach((element) => print(element),);
    notifyListeners();
  }

  // Code for animation flashcards
  bool ignoreTouches = true;

  setIgnoreTouch({required bool ignore}) {
    ignoreTouches = ignore;
    notifyListeners();
  }

  SlideDirection swipedDirection = SlideDirection.none;

  bool slidecard1 = false, flipCard1 = false, flipCard2 = false, swipedCard2 = false;

  bool resetSlidecard1 = false, resetFlipCard1 = false, resetFlipCard2 = false, resetSwipedCard2 = false;

  runSlideCard1() {
    resetSlidecard1 = false;
    slidecard1 = true;
    notifyListeners();
  }

  runFlipCard1() {
    resetFlipCard1 = false;
    flipCard1 = true;
    notifyListeners();
  }

  runFlipCard2() {
    resetFlipCard2 = false;
    flipCard2 = true;
    notifyListeners();
  }

  runSwipeCard2({required SlideDirection direction}) {
    updateCardOutcome(word: word1, isCorrect: direction == SlideDirection.leftAway);
    resetSwipedCard2 = false;
    swipedDirection = direction;
    swipedCard2 = true;
    notifyListeners();
  }

  resetCard1() {
    resetSlidecard1 = true;
    resetFlipCard1 = true;
    slidecard1 = false;
    flipCard1 = false;
  }

  resetCard2() {
    resetSwipedCard2 = true;
    resetFlipCard2 = true;
    swipedCard2 = false;
    flipCard2 = false;
  }
}
