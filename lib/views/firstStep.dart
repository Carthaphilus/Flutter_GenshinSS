import 'package:flutter/material.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/controller/firstStepController.dart';


class fistStepPage extends StatefulWidget {
  @override
  _fisrtStepPageState createState() => _fisrtStepPageState();
}

class _fisrtStepPageState extends State<fistStepPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gesnhin SS'),
        ),
        body:
        Container(
          child:
          FutureBuilder(
            future: firstStepController.getPersonnages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return DropdownButton(
                  items: firstStepController.buildDropDownMenuItems(snapshot.data),
                  value: firstStepController.selectedPersonnage,
                  onChanged: (newVal){
                    firstStepController.selectedPersonnage = newVal;
                  },
                );
              }else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
    );
  }
}