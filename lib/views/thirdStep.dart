import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/controller/calculateController.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class thirdStepPage extends StatefulWidget {
  @override
  _thirdStepPageState createState() => _thirdStepPageState();
}

class _thirdStepPageState extends State<thirdStepPage> {
  final _formKey = GlobalKey<FormState>();
  String val1;
  String val2;
  String val3;
  String val4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Gesnhin SS')
      ),
    );
  }
}