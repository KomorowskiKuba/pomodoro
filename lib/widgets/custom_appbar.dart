import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
    @override
    final Size preferredSize;

    final String title;

    CustomAppBar(
        this.title,
        { Key key,}) : preferredSize = Size.fromHeight(50.0),
            super(key: key);

    @override
    Widget build(BuildContext context) {
        return AppBar(
          backgroundColor: Theme.of(context).accentColor,
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          )),
        );
    }
}