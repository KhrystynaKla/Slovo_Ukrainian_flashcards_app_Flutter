import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// Add this import for File class

import 'word_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'WordsData.db');

    bool exists = await databaseExists(path);

    if (!exists) {
      // Should not reach here, as the database copy is done in main.dart
      throw Exception("Database does not exist in the expected location");
    }

    return await openDatabase(path, version: 1);
  }

  // No need for _createDb function here, as the database is pre-populated

  Future<void> insertWords(Database db) async {
    // No need to insert words in this function, as the database is pre-populated
    // You can add additional functions for inserting new words if needed
  }
  
  
  Future<List<Word>> getWordsByTopic(String topic) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('Words',
        where: 'topic = ?',
        whereArgs: [topic]);

    return result.map((map) => Word.fromMap(map)).toList();
  }

  Future<List<String>> getUniqueTopics() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT DISTINCT topic FROM Words');

    return result.map((map) => map['topic'] as String).toList();
  }

  Future<Word?> getWordById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('Words',
        where: 'id = ?',
        whereArgs: [id]);

    if (result.isNotEmpty) {
      return Word.fromMap(result.first);
    } else {
      return null;
    }
  }

  // picked words table

  Future<void> createUserPickedTable(Database db) async {
    bool tableExists = await doesTableExist(db, 'UserPickedWords');
    if (!tableExists) {
      await db.execute('''
        CREATE TABLE UserPickedWords (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pickedWordId INTEGER
        )
      ''');
    }
  }

  Future<bool> doesTableExist(Database db, String tableName) async {
    List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'"
    );
    return result.isNotEmpty;
  }

  Future<int> insertUserPickedWord(int pickedWordId) async {
    Database db = await database;

    // Check if the pickedWordId already exists in the table
    List<Map<String, dynamic>> existingRows = await db.query(
      'UserPickedWords',
      where: 'pickedWordId = ?',
      whereArgs: [pickedWordId],
    );

    if (existingRows.isNotEmpty) {
      // If the pickedWordId already exists, you can handle it as needed
      print("PickedWordId $pickedWordId already exists in the table");
      return -1; // Or any other value to indicate that insertion failed
    }

    // If the pickedWordId is unique, proceed with the insertion
    int result = await db.insert(
      'UserPickedWords',
      {'pickedWordId': pickedWordId},
    );

    return result;
  }


  Future<void> deleteAllUserPickedWords() async {
    Database db = await database;
    await db.delete('UserPickedWords');
  }

  // Future<List<int>> getAllPickedWordIds() async {
  //   Database db = await database;
  //   List<Map<String, dynamic>> result = await db.query('UserPickedWords');
  //   List<int> pickedWordIds = result.map((map) => map['pickedWordId'] as int).toList();
  //   print("All Picked Word IDs: $pickedWordIds");
  //   return pickedWordIds;
  // }

  // Future<void> deleteUserPickedWord(int id) async {
  //   Database db = await database;
  //   await db.delete(
  //     'UserPickedWords',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }

    Future<void> deleteUserPickedWord(int pickedWordId) async {
    Database db = await database;
    int rowsDeleted = await db.delete(
      'UserPickedWords',
      where: 'pickedWordId = ?',
      whereArgs: [pickedWordId],
    );
    print('Deleted $rowsDeleted row(s)');

    // Update the list of picked word IDs after deletion
    _updatePickedWordIds();
  }

  void _updatePickedWordIds() async {
  // Fetch the latest list of picked word IDs from the database
    List<int> updatedPickedWordIds = await getAllPickedWordIds();

    // Update the list in the DatabaseHelper instance only if it's not empty
    if (updatedPickedWordIds.isNotEmpty) {
      _pickedWordIds = updatedPickedWordIds;
      print('Updated Picked Word IDs: $_pickedWordIds');
    } else {
      // If the list is empty, reset _pickedWordIds to an empty list
      _pickedWordIds = [];
      print('No Picked Word IDs found');
    }
  }

  // Add a private variable to store the list of picked word IDs
  List<int> _pickedWordIds = [];

  // Update the getAllPickedWordIds method to return the private variable
  Future<List<int>> getAllPickedWordIds() async {
    if (_pickedWordIds.isEmpty) {
      final db = await database;
      List<Map<String, dynamic>> result = await db.query('UserPickedWords');
      _pickedWordIds = result.map((map) => map['pickedWordId'] as int).toList();
    }
    return _pickedWordIds;
  }
}
