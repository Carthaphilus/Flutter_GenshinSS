import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:genshin_android_app/controller/secondStepController.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class secondStepPage extends StatefulWidget {
  @override
  _secondStepPageState createState() => _secondStepPageState();
}

class _secondStepPageState extends State<secondStepPage> {
  final _formKey = GlobalKey<FormState>();
  String val1;
  String val2;
  String val3;
  String val4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gesnhin SS'),
        ),
        body:
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
          child:
          Container(
            width: 250.0,
            child :Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.stacked_bar_chart),
                      hintText: 'the first stat',
                      labelText: 'First stat *',
                    ),
                    keyboardType: TextInputType.phone,
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      val1 = value;
                      return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child:
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.stacked_bar_chart),
                        hintText: 'the second stat',
                        labelText: 'Second stat *',
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String value) {
                        val2 = value;
                        return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                      },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.stacked_bar_chart),
                      hintText: 'the thirst stat',
                      labelText: 'Thirst stat *',
                    ),
                    keyboardType: TextInputType.phone,
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      val3 = value;
                      return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child:
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.stacked_bar_chart),
                        hintText: 'the fourth stat',
                        labelText: 'Fourth stat *',

                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String value) {
                        val4 = value;
                        return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        // Process data.
                        if (val1 == "" || val2 == "" || val3 == "" || val4 == "")
                        {
                          Alert(context: context, title: "Erreur", desc: "Vous n'avez pas remplie l'ensemble des champs.").show();
                        }
                        else{
                          secondtStepController.Calculstat(val1,val2,val3,val4);

                        }
                      }
                    },
                    child: Text('Suivant'),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}