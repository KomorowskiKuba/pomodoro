import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:pomodoro/widgets/durations_settings_card.dart';
import 'package:pomodoro/widgets/notifications_settings_card.dart';
import 'package:pomodoro/widgets/session_settings_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro/globals.dart' as globals;

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
