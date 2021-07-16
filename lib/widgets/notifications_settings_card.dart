import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomodoro/globals.dart' as globals;

class NotificationsCardWidget extends StatefulWidget {
  const NotificationsCardWidget({Key key}) : super(key: key);

  @override
  _NotificationsCardWidgetState createState() =>
      _NotificationsCardWidgetState();
}

class _NotificationsCardWidgetState extends State<NotificationsCardWidget> {
  bool _notificationsEnabled = false;
  bool _vibrationsEnabled = false;
  bool _keepPhoneAwakeEnabled = false;

  _addBoolToPreferences(String key, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  _loadData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      _notificationsEnabled =
          sharedPreferences.getBool(globals.notificationsEnabledName);
    } on NoSuchMethodError {
      _notificationsEnabled = false;
    }

    try {
      _vibrationsEnabled =
          sharedPreferences.getBool(globals.vibrationsEnabledName);
    } on NoSuchMethodError {
      _vibrationsEnabled = false;
    }

    try {
      _keepPhoneAwakeEnabled =
          sharedPreferences.getBool(globals.keepPhoneAwakeEnabledName);
    } on NoSuchMethodError {
      _keepPhoneAwakeEnabled = false;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Theme.of(context).accentColor,
        child: Wrap(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(width: 5),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Row(children: [
                  Text(
                    'Notifications:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                        _addBoolToPreferences(globals.notificationsEnabledName,
                            _notificationsEnabled);
                      });
                    },
                    activeColor: Colors.orangeAccent,
                  )
                ]),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Row(children: [
                    Text(
                      'Vibrations:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Switch(
                      value: _vibrationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _vibrationsEnabled = value;
                          _addBoolToPreferences(globals.vibrationsEnabledName,
                              _vibrationsEnabled);
                        });
                      },
                      activeColor: Colors.orangeAccent,
                    )
                  ]),
                )
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Row(children: [
                    Text(
                      'Keep phone awake:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Switch(
                      value: _keepPhoneAwakeEnabled,
                      onChanged: (value) {
                        setState(() {
                          _keepPhoneAwakeEnabled = value;
                          _addBoolToPreferences(
                              globals.keepPhoneAwakeEnabledName,
                              _keepPhoneAwakeEnabled);
                        });
                      },
                      activeColor: Colors.orangeAccent,
                    )
                  ]),
                )
              ]),
            ]),
          ]),
        ]));
  }
}
