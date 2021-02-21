import 'dart:ui';

import 'package:flutter/material.dart';

class DoctorSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search for your Doctor",
          style: TextStyle(
            fontFamily: 'Comfortaa',
          ),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.cyan,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final doctors = [
    'Dr. Poal ',
    'Dr. Adam',
    'Dr. Peter',
    'Dr. John',
    'Dr. William',
    'Dr. David',
    'Dr. Joseph',
    'Dr. Ethan',
    'Dr. Michael',
    'Dr. Jacob',
    'Dr. James',
    'Dr. Harry',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // action for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? doctors
        : doctors.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.person),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa'),
                children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey, fontFamily: 'Comfortaa'))
            ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
