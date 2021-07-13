import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

import 'custom_appbar.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final DateFormat dateFormat = DateFormat('mm:ss');
  Duration _shortBreakDuration = Duration(minutes: 5, seconds: 00);
  Duration _longBreakDuration = Duration(minutes: 15, seconds: 00);
  Duration _sessionDuration = Duration(minutes: 25, seconds: 00);
  int _amountOfSessions = 4;
  bool _notificationsEnabled = false;
  bool _autoStartBreaksEnabled = false;
  bool _autoStartSessionsEnabled = false;
  bool _vibrationsEnabled = false;
  bool _keepPhoneAwakeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('Settings'),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(children: [
          SizedBox(
            height: 5,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Theme.of(context).accentColor,
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Text(
                                'Short break duration:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              TextButton(
                                child: Text(
                                    dateFormat.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            _shortBreakDuration
                                                .inMilliseconds)),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
                                onPressed: () {
                                  Picker(
                                    adapter: NumberPickerAdapter(
                                        data: <NumberPickerColumn>[
                                          NumberPickerColumn(
                                            begin: 0,
                                            end: 59,
                                            initValue:
                                                (_shortBreakDuration.inSeconds /
                                                        60)
                                                    .floor(),
                                            onFormatValue: (value) {
                                              if (value >= 0 && value <= 9) {
                                                return '0$value';
                                              } else {
                                                return '$value';
                                              }
                                            },
                                          ),
                                          NumberPickerColumn(
                                            begin: 0,
                                            end: 59,
                                            initValue:
                                                (_shortBreakDuration.inSeconds %
                                                    60),
                                            onFormatValue: (value) {
                                              if (value >= 0 && value <= 9) {
                                                return '0$value';
                                              } else {
                                                return '$value';
                                              }
                                            },
                                          ),
                                        ]),
                                    delimiter: <PickerDelimiter>[
                                      PickerDelimiter(
                                          child: Container(
                                              width: 30,
                                              alignment: Alignment.center,
                                              child: Text(
                                                ':',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )))
                                    ],
                                    hideHeader: true,
                                    confirmText: 'Confirm',
                                    title: const Text(
                                        'Select short break duration'),
                                    selectedTextStyle:
                                        TextStyle(color: Colors.blue),
                                    onConfirm:
                                        (Picker picker, List<int> value) {
                                      // You get your duration here
                                      _shortBreakDuration = Duration(
                                          minutes:
                                              picker.getSelectedValues()[0],
                                          seconds:
                                              picker.getSelectedValues()[1]);
                                      setState(() {});
                                      print(_shortBreakDuration.toString());
                                    },
                                  ).showDialog(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Text(
                                'Long break duration:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              TextButton(
                                child: Text(
                                    dateFormat.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            _longBreakDuration.inMilliseconds)),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
                                onPressed: () {
                                  Picker(
                                    adapter: NumberPickerAdapter(
                                        data: <NumberPickerColumn>[
                                          NumberPickerColumn(
                                            begin: 0,
                                            end: 59,
                                            initValue:
                                                (_longBreakDuration.inSeconds /
                                                        60)
                                                    .floor(),
                                            onFormatValue: (value) {
                                              if (value >= 0 && value <= 9) {
                                                return '0$value';
                                              } else {
                                                return '$value';
                                              }
                                            },
                                          ),
                                          NumberPickerColumn(
                                            begin: 0,
                                            end: 59,
                                            initValue:
                                                (_longBreakDuration.inSeconds %
                                                    60),
                                            onFormatValue: (value) {
                                              if (value >= 0 && value <= 9) {
                                                return '0$value';
                                              } else {
                                                return '$value';
                                              }
                                            },
                                          ),
                                        ]),
                                    delimiter: <PickerDelimiter>[
                                      PickerDelimiter(
                                          child: Container(
                                              width: 30,
                                              alignment: Alignment.center,
                                              child: Text(
                                                ':',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )))
                                    ],
                                    hideHeader: true,
                                    confirmText: 'Confirm',
                                    title: const Text(
                                        'Select long break duration'),
                                    selectedTextStyle:
                                        TextStyle(color: Colors.blue),
                                    onConfirm:
                                        (Picker picker, List<int> value) {
                                      // You get your duration here
                                      _longBreakDuration = Duration(
                                          minutes:
                                              picker.getSelectedValues()[0],
                                          seconds:
                                              picker.getSelectedValues()[1]);
                                      setState(() {});
                                      print(_longBreakDuration.toString());
                                    },
                                  ).showDialog(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Text(
                                'Session duration:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              TextButton(
                                child: Text(
                                    dateFormat.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            _sessionDuration.inMilliseconds)),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
                                onPressed: () {
                                  Picker(
                                    adapter: NumberPickerAdapter(
                                        data: <NumberPickerColumn>[
                                          NumberPickerColumn(
                                            begin: 0,
                                            end: 59,
                                            initValue:
                                                (_sessionDuration.inSeconds /
                                                        60)
                                                    .floor(),
                                            onFormatValue: (value) {
                                              if (value >= 0 && value <= 9) {
                                                return '0$value';
                                              } else {
                                                return '$value';
                                              }
                                            },
                                          ),
                                          NumberPickerColumn(
                                            begin: 0,
                                            end: 59,
                                            initValue:
                                                (_sessionDuration.inSeconds %
                                                    60),
                                            onFormatValue: (value) {
                                              if (value >= 0 && value <= 9) {
                                                return '0$value';
                                              } else {
                                                return '$value';
                                              }
                                            },
                                          ),
                                        ]),
                                    delimiter: <PickerDelimiter>[
                                      PickerDelimiter(
                                          child: Container(
                                              width: 30,
                                              alignment: Alignment.center,
                                              child: Text(
                                                ':',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )))
                                    ],
                                    hideHeader: true,
                                    confirmText: 'Confirm',
                                    title:
                                        const Text('Select session duration'),
                                    selectedTextStyle:
                                        TextStyle(color: Colors.blue),
                                    onConfirm:
                                        (Picker picker, List<int> value) {
                                      // You get your duration here
                                      _sessionDuration = Duration(
                                          minutes:
                                              picker.getSelectedValues()[0],
                                          seconds:
                                              picker.getSelectedValues()[1]);
                                      setState(() {});
                                      print(_sessionDuration.toString());
                                    },
                                  ).showDialog(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Theme.of(context).accentColor,
              child: Wrap(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25)),
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
                                        title: const Text(
                                            'Select amount of sessions'),
                                        selectedTextStyle:
                                            TextStyle(color: Colors.blue),
                                        onConfirm:
                                            (Picker picker, List<int> value) {
                                          _amountOfSessions =
                                              picker.getSelectedValues()[0];
                                          setState(() {});
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
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
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
              ])),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Theme.of(context).accentColor,
              child: Wrap(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 5),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                    });
                                  },
                                  activeColor: Colors.orangeAccent,
                                )
                              ]),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
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
                                          });
                                        },
                                        activeColor: Colors.orangeAccent,
                                      )
                                    ]),
                                  )
                                ]),
                          ]),
                    ]),
              ])),
        ]));
  }
}
