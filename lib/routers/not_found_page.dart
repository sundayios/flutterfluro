import 'package:flutter/material.dart';
// import 'package:flutter_deer/widgets/my_app_bar.dart';
// import 'package:flutter_deer/widgets/state_layout.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return const Scaffold(
    //   appBar: MyAppBar(
    //     centerTitle: '页面不存在',
    //   ),
    //   body: StateLayout(
    //     type: StateType.account,
    //     hintText: '页面不存在',
    //   ),
    // );
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('页面不存在'),
        // actions: <Widget>[
        //   new IconButton(
        //     // action button
        //     icon: new Icon(Icons.fast_forward),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Text('页面不存在'),
      ),
    );
  }
}
