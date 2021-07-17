import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/durations_settings_card.dart';
import 'package:pomodoro/widgets/notifications_settings_card.dart';
import 'package:pomodoro/widgets/session_settings_card.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_appbar.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final DateFormat dateFormat = DateFormat('mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('Settings'),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(children: [
          SizedBox(
            height: 5,
          ),
          DurationCardWidget(),
          SessionsCardWidget(),
          NotificationsCardWidget(),
        ]));
  }
}
