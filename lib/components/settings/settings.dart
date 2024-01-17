import 'package:flutter/material.dart';
import 'package:project/notifiers/settings_notifier.dart';
import 'package:project/utils/methods.dart';
import 'package:provider/provider.dart';

enum Settings {englishFirst, showSpelling, audioOnly}



class SwitchButton extends StatelessWidget {
  const SwitchButton({ required this.setting, this.disabled = false, 
    super.key,
  });

  final Settings setting;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (_, notifier, __) => 
      Column(
        children: [
          SwitchListTile(
            inactiveThumbColor: Colors.black.withOpacity(0.5),
            tileColor: disabled ? Colors.black.withOpacity(0.10) : Colors.transparent,
            title: Text(setting.toText()),
            value: notifier.displayOptions.entries.firstWhere((element) => element.key == setting).value, 
            onChanged: disabled ? null : (value){
            notifier.updateDisplayOptions(setting: setting, isToggled: value);
          }),
          Divider(height: 1, thickness: 1,)
        ],
      ));
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({ required this.title, required this.icon, required this.callback,
    super.key,
  });

  final Icon icon;
  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider( thickness: 1, height: 1,),
        ListTile(
          leading: icon,
          title: Text(title),
          onTap: callback,
        ),
      ],
    );
  }
}
