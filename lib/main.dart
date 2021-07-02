import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro/settings_drawer.dart';

import 'custom_appbar.dart';

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
  bool _isStart = false;
  int _current = -1;
  int _max = 10;
  double _percent = 0.0;
  Timer _timer;
  final DateFormat dateFormat = DateFormat('mm:ss');

  void startTimer() {
    if (!_isStart) {
      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          if (_current == -1) {
            _current = _max;
          }
          else if (_current == 0) {
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

  @override
  void initState() {
    super.initState();
    _current = _max;
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
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
                    child: CircularPercentIndicator(
                      center: Text(
                        '${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(1000 * _current))}',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      radius: MediaQuery.of(context).size.width * 0.9,
                      lineWidth: 20,
                      backgroundColor: Theme.of(context).accentColor,
                      percent: _percent,
                      progressColor: Colors.white,
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animateFromLastPercent: true,
                    )),
                SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                    ),
                    onPressed: startTimer,
                    child: Text(
                      _isStart == true ? 'Stop' : 'Start',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
              ]),
        ));
  }
}
