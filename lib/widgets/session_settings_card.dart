import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomodoro/globals.dart' as globals;

class SessionsCardWidget extends StatefulWidget {
  const SessionsCardWidget({Key key}) : super(key: key);

  @override
  _SessionsCardWidgetState createState() => _SessionsCardWidgetState();
}

class _SessionsCardWidgetState extends State<SessionsCardWidget> {
  int _amountOfSessions = 4;
  bool _autoStartBreaksEnabled = false;
  bool _autoStartSessionsEnabled = false;

  _addIntToPreferences(String key, int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(key, value);
  }

  _addBoolToPreferences(String key, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  _loadData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      if (sharedPreferences.getInt(globals.amountOfSessionsName) != null) {
        _amountOfSessions =
            sharedPreferences.getInt(globals.amountOfSessionsName);
      }
    } on NoSuchMethodError {
      _amountOfSessions = 4;
    }

    try {
      _autoStartBreaksEnabled =
          sharedPreferences.getBool(globals.autoStartBreaksEnabledName);
    } on NoSuchMethodError {
      _autoStartBreaksEnabled = false;
    }

    try {
      _autoStartSessionsEnabled =
          sharedPreferences.getBool(globals.autoStartSessionsEnabledName);
    } on NoSuchMethodError {
      _autoStartSessionsEnabled = false;
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
            SizedBox(
              width: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(
                            'Amount of sessions before break:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          child: Text(_amountOfSessions.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                          onPressed: () {
                            Picker(
                              adapter: NumberPickerAdapter(
                                  data: <NumberPickerColumn>[
                                    NumberPickerColumn(
                                        begin: 1,
                                        end: 10,
                                        initValue: _amountOfSessions),
                                  ]),
                              hideHeader: true,
                              confirmText: 'Confirm',
                              title: const Text('Select amount of sessions'),
                              selectedTextStyle: TextStyle(color: Colors.blue),
                              onConfirm: (Picker picker, List<int> value) {
                                _amountOfSessions =
                                    picker.getSelectedValues()[0];
                                setState(() {
                                  _addIntToPreferences(
                                      globals.amountOfSessionsName,
                                      _amountOfSessions);
                                });
                                print(_amountOfSessions.toString());
                              },
                            ).showDialog(context);
                          },
                        ),
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Row(children: [
                              Text(
                                'Autostart breaks:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Switch(
                                value: _autoStartBreaksEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    _autoStartBreaksEnabled = value;
                                    _addBoolToPreferences(
                                        globals.autoStartBreaksEnabledName,
                                        _autoStartBreaksEnabled);
                                  });
                                },
                                activeColor: Colors.orangeAccent,
                              )
                            ]),
                          )
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Row(children: [
                              Text(
                                'Autostart sessions:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Switch(
                                value: _autoStartSessionsEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    _autoStartSessionsEnabled = value;
                                    _addBoolToPreferences(
                                        globals.autoStartSessionsEnabledName,
                                        _autoStartSessionsEnabled);
                                  });
                                },
                                activeColor: Colors.orangeAccent,
                              )
                            ]),
                          )
                        ]),
                  ]),
            ),
          ])
        ]));
  }
}
