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
      child: ListView(
        children: <Widget>[
          Text('overline  10  normal  gray',
              style: Theme.of(context).textTheme.overline),
          Divider(),
          Text('subtitle  14  medium  black',
              style: Theme.of(context).textTheme.subtitle),
          Text('subtitle2 14  medium  black',
              style: Theme.of(context).textTheme.subtitle2),
          Text('button  14  medium  black',
              style: Theme.of(context).textTheme.button),
          Divider(),
          Text('caption 12  normal  grey',
              style: Theme.of(context).textTheme.caption),
          Divider(),
          Text('body1 14  normal  black',
              style: Theme.of(context).textTheme.body1),
          Text('bodyText2 14  normal  black',
              style: Theme.of(context).textTheme.bodyText2),
          Divider(),
          Text('body2 14  medium  black',
              style: Theme.of(context).textTheme.body2),
          Text('bodyText1 14  medium  black',
              style: Theme.of(context).textTheme.bodyText1),
          Divider(),
          Text('subhead 16  normal  black',
              style: Theme.of(context).textTheme.subhead),
          Text('subtitle1 16  normal  black',
              style: Theme.of(context).textTheme.subtitle1),
          Divider(),
          Text('title 20  medium  black',
              style: Theme.of(context).textTheme.title),
          Text('headline6 20  medium  black',
              style: Theme.of(context).textTheme.headline6),
          Divider(),
          Text('headline  24  normal  black',
              style: Theme.of(context).textTheme.headline),
          Text('headline5 24  normal  black',
              style: Theme.of(context).textTheme.headline5),
          Divider(),
          Text('display1 34  normal  grey',
              style: Theme.of(context).textTheme.display1),
          Text('headline4 34  normal  grey',
              style: Theme.of(context).textTheme.headline4),
          Divider(),
          Text('display2 45  normal  grey',
              style: Theme.of(context).textTheme.display2),
          Text('headline3 45  normal  grey',
              style: Theme.of(context).textTheme.headline3),
          Divider(),
          Text('display3 56  normal  grey',
              style: Theme.of(context).textTheme.display3),
          Text('headline2 56  normal  grey',
              style: Theme.of(context).textTheme.headline2),
          Divider(),
          Text('display4 112  thin  grey',
              style: Theme.of(context).textTheme.display4),
          Text('headline1 112  thin  grey',
              style: Theme.of(context).textTheme.headline1),
        ],
      ),
    );
  }
}
