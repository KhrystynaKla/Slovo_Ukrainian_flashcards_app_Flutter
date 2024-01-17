// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:project/components/app/CustomAppBar.dart';
// import 'package:project/components/settings/settings.dart';
// import 'package:project/configs/constants.dart';
// import 'package:project/notifiers/settings_notifier.dart';
// import 'package:provider/provider.dart';



// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SettingsNotifier>(
//       builder: (_, notifier, __) {


//         final audioFirst = notifier.displayOptions.entries.firstWhere((element)=>
//         element.key == Settings.audioOnly).value;




//         return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(kAppBarHeight),
//           child: CustomAppBar()),
//         body: Stack(
//           children: [
//             Column(children: [
//               SwitchButton(disabled: audioFirst, setting: Settings.englishFirst,),
//               SwitchButton(setting: Settings.showSpelling,),
//               SwitchButton(setting: Settings.audioOnly,),
//             ]),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SettingsTile(title: 'Reset', icon: Icon(Icons.refresh), callback: (){notifier.resetSettings();},),
//                 SettingsTile(
//                   title: 'Exit App',
//                   icon: Icon(Icons.exit_to_app),
//                   callback: () {
//                     SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//                   },
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//       },
//     );
//   }
// }
import 'dart:io'; // Import the dart:io library

import 'package:flutter/material.dart';
import 'package:project/components/app/CustomAppBar.dart';
import 'package:project/components/settings/settings.dart';
import 'package:project/configs/constants.dart';
import 'package:project/notifiers/settings_notifier.dart';
import 'package:project/utils/methods.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (_, notifier, __) {
        final audioFirst = notifier.displayOptions.entries
            .firstWhere((element) => element.key == Settings.audioOnly)
            .value;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kAppBarHeight),
            child: CustomAppBar(),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  SwitchButton(disabled: audioFirst, setting: Settings.englishFirst),
                  SwitchButton(setting: Settings.showSpelling),
                  SwitchButton(setting: Settings.audioOnly),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SettingsTile(
                    title: 'Reset',
                    icon: Icon(Icons.refresh),
                    callback: () {
                      notifier.resetSettings();
                      runQuickBox(context: context, text: 'Settings reset');
                    },
                  ),
                  SettingsTile(
                    title: 'Exit App',
                    icon: Icon(Icons.exit_to_app),
                    callback: () {
                      // Use exit(0) to exit the app
                      exit(0);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}


