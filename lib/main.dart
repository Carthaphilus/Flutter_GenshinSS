//@dart=2.12
import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:genshin_android_app/views/firstStep.dart';

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
      home: fistStepPage(),
    );
  }
}




