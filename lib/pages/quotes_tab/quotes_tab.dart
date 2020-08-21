import 'package:flutter/material.dart';

class QutoesTabPage extends StatefulWidget {
  QutoesTabPage({Key key}) : super(key: key);

  @override
  _QutoesTabPageState createState() => _QutoesTabPageState();
}

class _QutoesTabPageState extends State<QutoesTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Text("qutesTab"),
    );
  }
}
