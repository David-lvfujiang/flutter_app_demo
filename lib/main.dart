import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_demo/CustomSearchDelegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  List tabs = ["最新博文", "最新项目", "最新热点"];
  String _selectedSort = "最新博文";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('demo',style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
          PopupMenuButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              itemBuilder: (context) {
                return tabs.map((e) {
                  return PopupMenuItem(
                    child: Text(e),
                    value: e,
                  );
                }).toList();
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('SimpleDialog'),
              onPressed: () async {
                var result = await showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('语言选择'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.of(context).pop('中文');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '中文',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.of(context).pop('英文');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('英文', style: TextStyle(fontSize: 16)),
                            ),
                          )
                        ],
                      );
                    });
                print(result);
              },
            ),
            RaisedButton(
              child: Text('AlertDialog'),
              onPressed: () async {
                var result = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('提示'),
                        content: Text('我是一条消息'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop("确定");
                            },
                            color: Colors.white,
                            child: Text(
                              '确定',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop("取消");
                            },
                            color: Colors.white,
                            child: Text('取消',
                                style: TextStyle(color: Colors.blue)),
                          )
                        ],
                      );
                    });
              },
            ),
            RaisedButton(
              child: Text('ListDialog'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: 50,
                            itemBuilder: (context, index) {
                              return Padding(
                                child: Text(
                                  '$index',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                padding: EdgeInsets.only(top: 10),
                              );
                            }),
                      ));
                    });
              },
            ),
            DropdownButton(
              value: _selectedSort,
              items: tabs.map((e) {
                return DropdownMenuItem(
                  child: Container(
                    child: Text(e),
                  ),
                  value: e,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSort = value;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
