import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:pomodoro/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class DurationCardWidget extends StatefulWidget {
  DurationCardWidget({Key key}) : super(key: key);

  @override
  _DurationCardWidgetState createState() => _DurationCardWidgetState();
}

class _DurationCardWidgetState extends State<DurationCardWidget> {
  Duration shortBreakDuration = Duration(minutes: 5, seconds: 00);
  Duration longBreakDuration = Duration(minutes: 15, seconds: 00);
  Duration sessionDuration = Duration(minutes: 25, seconds: 00);

  _addDurationToPreferences(String key, Duration value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(key, value.inSeconds);
  }

   _loadValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      longBreakDuration = Duration(seconds: prefs.getInt(globals.longBreakDuration));
      shortBreakDuration = Duration(seconds: prefs.getInt(globals.shortBreakDuration));
      sessionDuration = Duration(seconds: prefs.getInt(globals.sessionDuration));
    } 
    on NoSuchMethodError {
      shortBreakDuration = Duration(minutes: 5, seconds: 00);
      longBreakDuration = Duration(minutes: 15, seconds: 00);
      sessionDuration = Duration(minutes: 25, seconds: 00);
    }

    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    _loadValues();
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
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
                                    globals.dateFormat.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            shortBreakDuration
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
                                                (shortBreakDuration.inSeconds /
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
                                                (shortBreakDuration.inSeconds %
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
                                      shortBreakDuration = Duration(
                                          minutes:
                                              picker.getSelectedValues()[0],
                                          seconds:
                                              picker.getSelectedValues()[1]);
                                      setState(() {});
                                      _addDurationToPreferences(globals.shortBreakDuration, shortBreakDuration);
                                      //print(widget.shortBreakDuration.toString());
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
                                    globals.dateFormat.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            longBreakDuration.inMilliseconds)),
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
                                                (longBreakDuration.inSeconds /
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
                                                (longBreakDuration.inSeconds %
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
                                      longBreakDuration = Duration(
                                          minutes:
                                              picker.getSelectedValues()[0],
                                          seconds:
                                              picker.getSelectedValues()[1]);
                                      setState(() {});
                                      //print(widget.longBreakDuration.toString());
                                      _addDurationToPreferences(globals.longBreakDuration, longBreakDuration);
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
                                    globals.dateFormat.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            sessionDuration.inMilliseconds)),
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
                                                (sessionDuration.inSeconds /
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
                                                (sessionDuration.inSeconds %
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
                                      sessionDuration = Duration(
                                          minutes:
                                              picker.getSelectedValues()[0],
                                          seconds:
                                              picker.getSelectedValues()[1]);
                                      setState(() {});
                                      _addDurationToPreferences(globals.sessionDuration, sessionDuration);
                                      //print(widget.sessionDuration.toString());
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
          );
  }
}