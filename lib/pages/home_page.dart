import 'package:flutter/material.dart';
import 'package:project/animation/fading.dart';
import 'package:project/components/home_page/topic_tile.dart';
import 'package:project/data_sqlite/database_helper.dart';
import 'package:project/notifiers/flashcards_notifier.dart';
import 'package:project/pages/review_page.dart';
import 'package:project/pages/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  late Database db;
  List<String> uniqueTopics = [];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  // Initialize the database and get unique topics
  void initDatabase() async {
    try {
      db = await dbHelper.database;
      List<String> topics = await dbHelper.getUniqueTopics();
      topics.sort();
      setState(() {
        uniqueTopics = topics;
      });
    } catch (e) {
      // Handle initialization error, show a message to the user or log the error.
      print('Error initializing the database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthPadding = size.width * 0.04;

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        toolbarHeight: size.height * 0.12,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Provider.of<FlashcardsNotifier>(context, listen: false).setTopic(topic: 'Settings');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                  },
                  child: SizedBox(
                    width: size.width *0.1,
                    child: Image.asset('assets/images/Settings.png'),),
                ),
                SizedBox( height: size.height * 0.05,)
              ],
            ),
            const FadeInAnimation(child: Text('Ukrainian Slovo \n Українське слово', textAlign: TextAlign.center,)),
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Provider.of<FlashcardsNotifier>(context, listen: false).setTopic(topic: 'Reviews');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewPage()));
                  },
                  child: SizedBox(
                    width: size.width *0.1,
                    child: Image.asset('assets/images/Reviews.png'),),
                ),
                SizedBox( height: size.height * 0.05,)
              ],
            ),

          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthPadding),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              expandedHeight: size.height * 0.4,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.all(size.width * 0.01),
                  child: FadeInAnimation(child : Image.asset('assets/images/logo3.png')), // Replace with an actual image or placeholder
                ),
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => TopicTile(topic: uniqueTopics[index]),
                childCount: uniqueTopics.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



