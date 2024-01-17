import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './word_model.dart';

class DatabaseManager {
  // Singleton
  DatabaseManager._internal();
  static final _instance = DatabaseManager._internal();
  factory DatabaseManager() => _instance;

  // Database configuration
  final String _database = 'flashcards.db',
      _table = 'words',
      _column1 = 'topic',
      _column2 = 'english',
      _column3 = 'ukrainian',
      _column4 = 'spelling';

  // Initialize the database
  Future<Database> initDatabase() async {
    final devicesPath = await getDatabasesPath();
    final path = join(devicesPath, _database);

    // Open the database or create a new one if it doesn't exist
    return await openDatabase(path, onCreate: (db, version) {
      // Create the 'words' table with specified columns
      db.execute('CREATE TABLE $_table($_column1 TEXT, $_column2 TEXT PRIMARY KEY, $_column3 TEXT, $_column4 TEXT)');
    }, version: 1);
  }

  // Insert a word into the 'words' table
  Future<void> insertWord({required Word word}) async {
    final db = await initDatabase();
    // Insert or replace the word based on the English column (primary key)
    await db.insert(_table, word.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Select words from the 'words' table with an optional limit and random order
  Future<List<Word>> selectWords({int? limit}) async {
    final db = await initDatabase();
    // Query the 'words' table and return a list of Word objects
    List<Map<String, dynamic>> maps = await db.query(_table, limit: limit, orderBy: 'RANDOM()');
    return List.generate(maps.length, (index) => Word.fromMap(map: maps[index]));
  }

  // Remove a specific word from the 'words' table
  Future<void> removeWord({required Word word}) async {
    final db = await initDatabase();
    // Delete the word based on the English column
    await db.delete(_table, where: '$_column2 = ?', whereArgs: [word.english]);
  }

  // Remove all words from the 'words' table
  Future<void> removeAllWords() async {
    final db = await initDatabase();
    // Delete all rows from the 'words' table
    await db.delete(_table);
  }

  // Remove the entire database
  Future<void> removeDatabase() async {
    final devicesPath = await getDatabasesPath();
    final path = join(devicesPath, _database);
    // Delete the database file
    await deleteDatabase(path);
  }
}
