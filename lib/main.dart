// @dart=2.7
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:genshin_android_app/controller/Personnages.dart';
import 'package:genshin_android_app/controller/Armes.dart';
import 'package:genshin_android_app/controller/Elements.dart';
import 'package:genshin_android_app/controller/Competences.dart';
void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: PersonnagesPage(),
    );
  }
}


class PersonnagesPage extends StatefulWidget {
  @override
  _PersonnagesPageState createState() => _PersonnagesPageState();
}

class _PersonnagesPageState extends State<PersonnagesPage> {

  @override
  Widget build(BuildContext context) {
          String _mySelection;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter REST API'),
      ),
      body: FutureBuilder(
        future: Personnages.getPersonnages(),
        builder: (context, snapshot) {
          final personnage = snapshot.data;
          List<String> listPerso ;
          if (snapshot.connectionState == ConnectionState.done) {

            return new DropdownButton(
                items: personnage.map((item) => {
                   new DropdownMenuItem(
                    child: Text(item['nom']),
                    value: snapshot.data[0],
                  )
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    _mySelection = newVal;
                  });
                });

          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

    );
  }
}



