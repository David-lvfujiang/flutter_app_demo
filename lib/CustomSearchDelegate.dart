import 'dart:math';

import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  String searchHint = "请输入搜索内容...";

  @override
  String get searchFieldLabel {
    return searchHint;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(primaryColor: Colors.amber, cursorColor: Colors.white);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          query = '';

        },
      ), IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,

        ),
        onPressed: () {
          buildResults(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          height: 60,
          alignment: Alignment.center,
          child: ListTile(
            title: Text(
              '搜索结果$index',
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: 10,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('记录 $index'),
          onTap: () {
            query = '记录 $index';
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: Random().nextInt(5),
    );
  }
}
