import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  int _start = 10;
  int _max = 10;
  Timer _timer;

  void startTimer() {
    if (!_isStart) {
      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          if (_start == 0) {
            setState(() {
              timer.cancel();
              _start = 10;
              _isStart = !_isStart;
            });
          } else {
            setState(() {
              _start--;
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
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(45),
          )),
        ),
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
                        '$_start',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40
                        ),
                      ),
                      radius: MediaQuery.of(context).size.width * 0.9,
                      lineWidth: 20,
                      backgroundColor: Theme.of(context).accentColor,
                      percent: (_max - _start) / 10,
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
