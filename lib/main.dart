
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:project/configs/themes.dart';
import 'package:project/notifiers/flashcards_notifier.dart';
import 'package:project/notifiers/settings_notifier.dart';
import 'package:project/utils/methods.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project/data_sqlite/database_helper.dart';
import 'package:project/data_sqlite/word_model.dart';
import 'package:project/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Copy the pre-populated database from assets
  await _copyDatabase();

  // Open the database to retrieve some information
  DatabaseHelper dbHelper = DatabaseHelper();
  Database db = await dbHelper.database;
  // Create the UserPickedWords table if it doesn't exist
  await dbHelper.createUserPickedTable(db);
  
  
  // PRINT EXAMPLE DATA
  // Print some data for verification
  List<Map<String, dynamic>> result = await db.query('Words');
  List<Word> retrievedWords = result.map((map) => Word.fromMap(map)).toList();
  // print all the words
  print("All Words: $retrievedWords");
  // print word data by id
  int desiredWordId = 1;
  Word? desiredWord = await dbHelper.getWordById(desiredWordId);
  if (desiredWord != null) {
    print("Word with ID $desiredWordId: $desiredWord");
  } else {
    print("Word with ID $desiredWordId not found");
  }
  // print all unique topics
  List<String> uniqueTopics = await dbHelper.getUniqueTopics();
  print("Unique Topics: $uniqueTopics");
  // picked words
  // Example of inserting a user-picked word
  int pickedWordId = 9; // replace with the actual picked word ID
  int result1 = await dbHelper.insertUserPickedWord(pickedWordId);
  int result2 = await dbHelper.insertUserPickedWord(10);
  print("Inserted UserPickedWord IDs: $result1, $result2");
  // Example of getting all picked word IDs
  //List<int> allPickedWordIds = await dbHelper.getAllPickedWordIds();
  print(await dbHelper.getAllPickedWordIds());
  // Example of deleting all user-picked words
  // await dbHelper.deleteAllUserPickedWords();
  // // Example of deleting a specific user-picked word by ID
  int userPickedWordIdToDelete = 6; // Replace with the actual id of the user-picked word
  await dbHelper.deleteUserPickedWord(userPickedWordIdToDelete);
  print(await dbHelper.getAllPickedWordIds());
  //the end 
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) =>FlashcardsNotifier()),
      ChangeNotifierProvider(create: (_)=> SettingsNotifier()),
    ],
    
    child: const MyApp()));
}

//Function to create a copy of the prepopulated database
Future<void> _copyDatabase() async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'WordsData.db');  // Updated database file name
  bool exists = await databaseExists(path);
  if (!exists) {
    ByteData data = await rootBundle.load(join('assets', 'WordsData.db'));  // Updated asset file name
    List<int> bytes = data.buffer.asUint8List();
    await File(path).writeAsBytes(bytes);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    updatePreferencesOnRestart(context: context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ukrainian Flashcards',
      theme: appTheme,
      home: const HomePage(),
    );
  }
}

