import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/resetApp.dart';
import 'package:friba_performance_tracker/settingsListItem.dart';

//  This is basically the settings screen. Has a list of
// all the different settings.
//
class Settings extends StatelessWidget {
  final Widget developers = Container(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Juuso Luttinen',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          'Toni Pennanen',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );

  final Widget licenses = Container(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            'percent_indicator by diegoveloper.com (BSD)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          'charts_flutter by google (APACHE 2.0)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
          child: Text(
            'GENERAL',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
        ),
        SettingsListItem(
          title: 'Reset app',
          desc: 'Delete all stats and rounds',
          optionIcon: Icons.delete_forever,
          windowContent: ResetApp(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
          child: Text(
            'EXTRA',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
        ),
        SettingsListItem(
            title: 'Developers',
            desc: 'Information about the app makers',
            optionIcon: Icons.people,
            windowContent: developers),
        SettingsListItem(
            title: 'Licenses',
            desc: 'Used technologies, libraries etc.',
            optionIcon: Icons.code,
            windowContent: licenses),
      ],
    );
  }
}
