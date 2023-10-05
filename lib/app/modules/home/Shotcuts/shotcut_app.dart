

import 'package:flutter/material.dart';
import 'package:quick_actions_android/quick_actions_android.dart';
import 'package:smartmasjid_v1/app/modules/qiblafinderpage/views/qiblafinderpage_view.dart';

class ShotcutApp extends StatefulWidget {
  const ShotcutApp({super.key});

  @override
  State<ShotcutApp> createState() => _MyShotcutAppState();
}

class _MyShotcutAppState extends State<ShotcutApp> {
  String shortcut = 'no action set';

  @override
  void initState() {
    super.initState();

    final QuickActionsAndroid quickActions = QuickActionsAndroid();
    quickActions.initialize((String shortcutType) {
      setState(() {
        shortcut = '$shortcutType has launched';
      });
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'qibla_finder',
        localizedTitle: 'Qibla Finder',
        //icon: 'AppIcon',
      ),
      const ShortcutItem(
          type: 'masjid_near_me',
          localizedTitle: 'Masjid Near Me',
          //icon: 'ic_launcher'
    ),
    ]);
    
    quickActions.initialize((type) {
      if(type == "qibla_finder") {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => QiblaFinder()));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shortcut),
      ),
      body: const Center(
        child: Text('On home screen, long press the app icon to '
            'get Action one or Action two options. Tapping on that action should  '
            'set the toolbar title.'),
      ),
    );
  }
}