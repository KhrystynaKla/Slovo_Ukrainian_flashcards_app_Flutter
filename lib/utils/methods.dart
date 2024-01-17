import 'package:flutter/material.dart';
import 'package:project/components/app/guide_box.dart';
import 'package:project/components/app/quick_box.dart';
import 'package:project/components/settings/settings.dart';
import 'package:project/notifiers/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

runGuideBox({required BuildContext context, required bool isFirst}){
  if(!isFirst){
  SharedPreferences.getInstance().then((prefs){
    prefs.setBool('guidebox', true);
  });
  }

  Future.delayed(Duration(milliseconds: 1200),(){
    showDialog(context: context, builder: (context)=> GuideBox(isFirst: isFirst,));
  });
  

}

extension SettingsToText on Settings {
  String toText(){
    switch(this){
      case Settings.englishFirst:
      return 'Show English First';
      case Settings.showSpelling:
        return 'Show Spelling';
      case Settings.audioOnly:
        return 'Test Listening';
    }
  }
}


updatePreferencesOnRestart({required BuildContext context}){
  final settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);
  for (var e in settingsNotifier.displayOptions.entries){
    SharedPreferences.getInstance().then((prefs){
      final result = prefs.getBool(e.key.name);
      if (result !=null){
        settingsNotifier.displayOptions.update(e.key, (value) => result);}
  });
  }
  
}

clearPreferences(){
  SharedPreferences.getInstance().then((prefs){
     for (var e in SettingsNotifier().displayOptions.entries){
      prefs.remove(e.key.name);
      prefs.remove('guidebox');
     }
  });
}

runQuickBox({required BuildContext context, required String text}){
  showDialog(
    barrierDismissible: false,
      context: context, builder: (context)=> QuickBox(text: text));
  Future.delayed(Duration(milliseconds: 1000), (){
    Navigator.maybePop(context);
  });
}