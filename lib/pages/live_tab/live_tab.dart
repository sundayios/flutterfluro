import 'package:flutter/material.dart';

class LiveTabPage extends StatefulWidget {
  LiveTabPage({Key key}) : super(key: key);

  @override
  _LiveTabPageState createState() => _LiveTabPageState();
}

class _LiveTabPageState extends State<LiveTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Text("livePage"),
    );
  }
}
