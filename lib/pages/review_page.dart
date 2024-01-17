import 'package:flutter/material.dart';
import 'package:project/components/app/CustomAppBar.dart';
import 'package:project/components/reviews/header_button.dart';
import 'package:project/components/reviews/language_button.dart';
import 'package:project/components/reviews/word_tile.dart';
import 'package:project/configs/constants.dart';
import 'package:project/data_sqlite/word_model.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {


  final _listKey = GlobalKey<AnimatedListState>();
  final _reviewWords = [

  Word(topic: "Family", english: "Brother", ukrainian: "Брат", spelling: "Brat"),
  Word(topic: "Family", english: "Sister", ukrainian: "Сестра", spelling: "Sestra"),

  Word(topic: "Weather", english: "Sun", ukrainian: "Сонце", spelling: "Sontse"),
  Word(topic: "Weather", english: "Spring", ukrainian: "Весна", spelling: "Vesna"),
  
  Word(topic: "Travel", english: "Bus", ukrainian: "Автобус", spelling: "Avtobus"),
  Word(topic: "Travel", english: "Car", ukrainian: "Автомобіль", spelling: "Avto-mobil"),

  Word(topic: "Food", english: "Menu", ukrainian: "Меню", spelling: "Menu"),
  Word(topic: "Food", english: "Dish", ukrainian: "Страва", spelling: "Strava"),

  Word(topic: "Hobbies", english: "Traveling", ukrainian: "Подорожі", spelling: "Podorozhi"),
  Word(topic: "Hobbies", english: "Cooking", ukrainian: "Готування", spelling: "Gotuvannya"),

  Word(topic: "Shopping", english: "Cashier", ukrainian: "Касир", spelling: "Kasyr"),
  Word(topic: "Shopping", english: "Price", ukrainian: "Ціна", spelling: "Tsina"),
 
];

  





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
                  key: _listKey,
                  initialItemCount: _reviewWords.length,
                  itemBuilder: (context, index, animation) =>WordTile(word: _reviewWords[index],),
                ),
                ),
                Expanded(
                  flex:1,
                  child: Row(
                    children: [
                      LanguageButton(languageType: LanguageType.english,),
                      LanguageButton(languageType: LanguageType.ukrainian,),
                      LanguageButton(languageType: LanguageType.spelling,),
                    ],
                  ),
                ),
        ],)
    );
  }

  _insertWord({required Word word}){
    _listKey.currentState?.insertItem(_reviewWords.length);
    _reviewWords.insert(_reviewWords.length, word);
  }
}





