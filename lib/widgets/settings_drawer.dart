import 'package:flutter/material.dart';
import 'package:pomodoro/screens/settings_screen.dart';
import 'package:pomodoro/screens/statistics_screen.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'More',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(color: Theme.of(context).accentColor,)
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen())
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Statistics'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatisticsScreen())
              )
            },
          ),
        ],
      ),
    );
  }
}