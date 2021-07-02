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
  Duration _breakDuration = Duration(minutes: 5, seconds: 00);
  Duration _sessionDuration = Duration(minutes: 25, seconds: 00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Settings'),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('Break time:', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  TextButton(
                    child: Text(dateFormat.format(DateTime.fromMillisecondsSinceEpoch(_breakDuration.inMilliseconds)), style: TextStyle(color: Colors.white, fontSize: 25)),
                    onPressed: () {
                      Picker(
                        adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
                          NumberPickerColumn(
                            begin: 0,
                            end: 59,
                            initValue: (_breakDuration.inSeconds / 60).floor(),
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
                            initValue: (_breakDuration.inSeconds % 60),
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
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  )))
                        ],
                        hideHeader: true,
                        confirmText: 'OK',
                        confirmTextStyle: TextStyle(
                            inherit: false, color: Colors.red, fontSize: 22),
                        title: const Text('Select duration'),
                        selectedTextStyle: TextStyle(color: Colors.blue),
                        onConfirm: (Picker picker, List<int> value) {
                          // You get your duration here
                          _breakDuration = Duration(
                              minutes: picker.getSelectedValues()[0],
                              seconds: picker.getSelectedValues()[1]);
                          setState(() {});
                          print(_breakDuration.toString());
                        },
                      ).showDialog(context);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Session time:', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  TextButton(
                    child: Text(dateFormat.format(DateTime.fromMillisecondsSinceEpoch(_sessionDuration.inMilliseconds)), style: TextStyle(color: Colors.white, fontSize: 25)),
                    onPressed: () {
                      Picker(
                        adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
                          NumberPickerColumn(
                            begin: 0,
                            end: 59,
                            initValue: (_sessionDuration.inSeconds / 60).floor(),
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
                            initValue: (_sessionDuration.inSeconds % 60),
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
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  )))
                        ],
                        hideHeader: true,
                        confirmText: 'OK',
                        confirmTextStyle: TextStyle(
                            inherit: false, color: Colors.red, fontSize: 22),
                        title: const Text('Select duration'),
                        selectedTextStyle: TextStyle(color: Colors.blue),
                        onConfirm: (Picker picker, List<int> value) {
                          // You get your duration here
                          _sessionDuration = Duration(
                              minutes: picker.getSelectedValues()[0],
                              seconds: picker.getSelectedValues()[1]);
                          setState(() {});
                          print(_sessionDuration.toString());
                        },
                      ).showDialog(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
