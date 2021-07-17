import 'dart:async';
import 'package:pomodoro/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro/widgets/settings_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';
import 'widgets/custom_appbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color(0xFF4D4D4D),
        accentColor: Color(0xFF3B3B3B),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Simple Pomodoro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _breakAutoStartEnabled = false;
  bool _sessionAutoStartEnabled = false;
  AppState _state;
  Duration _shortBreakDuration = Duration(minutes: 5, seconds: 00);
  Duration _longBreakDuration = Duration(minutes: 15, seconds: 00);
  Duration _sessionDuration = Duration(minutes: 25, seconds: 00);
  bool _isStart = false;
  int _current = -1;
  int _max = 10;
  double _percent = 0.0;
  Timer _timer;
  final DateFormat dateFormat = DateFormat('mm:ss');

  void _changeState() {
    print(_state);
    print(_percent);
    if (_state == globals.AppState.session && _percent == 0.0) {
      _max = _shortBreakDuration.inSeconds;
      _current = _shortBreakDuration.inSeconds;
      _state = globals.AppState.shortBreak;
      if (_sessionAutoStartEnabled) {
        _startTimer();
      }
    } else if (_state == globals.AppState.shortBreak && _percent == 0.0) {
      _max = _sessionDuration.inSeconds;
      _current = _sessionDuration.inSeconds;
      _state = globals.AppState.session;
      if (_breakAutoStartEnabled) {
        _startTimer();
      }
    }
    /* else if (_state == globals.AppState.longBreak && _percent == 100.0) {
      _max = _shortBreakDuration.inSeconds;
    }*/
  }

  void _startTimer() {
    if (!_isStart) {
      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          if (_current == -1) {
            _current = _max;
          } else if (_current == 0) {
            setState(() {
              timer.cancel();
              _current = _max;
              _percent = 0.0;
              _isStart = !_isStart;
            });
          } else {
            setState(() {
              _percent += (1 / _max);
              _current--;
            });
          }
        },
      );
    } else {
      _timer.cancel();
    }

    setState(() {
      _isStart = !_isStart;
    });
  }

  _loadValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (prefs.getInt(globals.longBreakDurationName) != null) {
        _longBreakDuration =
            Duration(seconds: prefs.getInt(globals.longBreakDurationName));
      }
    } on NoSuchMethodError {
      _longBreakDuration = Duration(minutes: 15, seconds: 00);
    }

    try {
      if (prefs.getInt(globals.shortBreakDurationName) != null) {
        _shortBreakDuration =
            Duration(seconds: prefs.getInt(globals.shortBreakDurationName));
      }
    } on NoSuchMethodError {
      _shortBreakDuration = Duration(minutes: 5, seconds: 00);
    }

    try {
      if (prefs.getInt(globals.sessionDurationName) != null) {
        _sessionDuration =
            Duration(seconds: prefs.getInt(globals.sessionDurationName));
      }
    } on NoSuchMethodError {
      _sessionDuration = Duration(minutes: 25, seconds: 00);
    }

    print(_shortBreakDuration);
    print(_sessionDuration);

    _max = _sessionDuration.inSeconds;
    _current = _sessionDuration.inSeconds;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _state = globals.AppState.session;
    _loadValues();
    print(_state);
    print(_shortBreakDuration);
    print(_sessionDuration);

    _max = _sessionDuration.inSeconds;
    _current = _sessionDuration.inSeconds;
    _timer = Timer.periodic(_sessionDuration, (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SettingsDrawer(),
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar('Settings'),
        body: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    child: (_percent >= 0.0 && _percent <= 1.0)
                        ? CircularPercentIndicator(
                            center: Text(
                              '${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(1000 * _current))}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                            radius: MediaQuery.of(context).size.width * 0.9,
                            lineWidth: 20,
                            backgroundColor: Theme.of(context).accentColor,
                            percent: _percent,
                            progressColor: Colors.white,
                            circularStrokeCap: CircularStrokeCap.round,
                            animation: true,
                            animateFromLastPercent: true,
                            onAnimationEnd: _changeState,
                          )
                        : Container()), //TODO: add animation or sth
                SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                    ),
                    onPressed: _startTimer,
                    child: Text(
                      _isStart == true ? 'Stop' : 'Start',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
              ]),
        ));
  }
}
