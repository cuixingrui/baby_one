import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  String name_page;
  HomePage({Key key, @required this.name_page}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _HomePageState(name_page);
}

class _HomePageState extends State<HomePage> {
  String aaa="";
  _HomePageState(String name_page){
    aaa=name_page;
    print("111");
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(aaa),
          actions: <Widget>[
            new Container()
          ],
        ),
        body: new Center(
          child: null,
        ),
      ),
    );
  }
}