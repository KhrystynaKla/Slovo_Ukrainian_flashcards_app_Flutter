import 'package:flutter/material.dart';
import 'package:project/components/settings/settings.dart';
import 'package:project/utils/methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends ChangeNotifier {
  Map<Settings, bool> displayOptions = {
    Settings.englishFirst: true,
    Settings.showSpelling: true,
    Settings.audioOnly: false,
  };

  updateDisplayOptions({required Settings setting, required bool isToggled}) {
    displayOptions.update(setting, (value) => isToggled);
    SharedPreferences.getInstance().then((prefs)=>{
      prefs.setBool(setting.name, isToggled)
    });
    notifyListeners(); // Notify listeners of the change
  }

  resetSettings(){
    displayOptions.update(Settings.englishFirst, (value) => true);
    displayOptions.update(Settings.showSpelling, (value) => true);
    displayOptions.update(Settings.audioOnly, (value) => false);
    clearPreferences();
    notifyListeners();
  }
}
