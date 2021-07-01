import 'package:flutter/material.dart';

import 'custom_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Settings'),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
