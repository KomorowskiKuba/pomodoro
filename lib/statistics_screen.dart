import 'package:flutter/material.dart';

import 'custom_appbar.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Statistics'),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
