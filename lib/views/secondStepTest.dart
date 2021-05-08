import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:genshin_android_app/controller/secondStepController.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/models/Armes.dart';

class secondStepPage extends StatefulWidget {
  List<dynamic> listParams;
  secondStepPage({Key key, this.listParams}) : super(key: key);

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
        ListView(
            children: [
              Container(
                  padding: const EdgeInsets.all(32),
                  child : Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Image.asset(
                                        'images/personnages/icones/'+widget.listParams[0].image.replaceAll('.jpg','.png'),
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(widget.listParams[0].nom +" | "+ widget.listParams[1].nomArme),
                                      subtitle: Text('Set 1 | Set 2'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Text("Stats de base", style: TextStyle(fontSize: 20)),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart),
                                  hintText: 'PV max',
                                  labelText: 'PV max *',
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart),
                                  hintText: 'ATQ',
                                  labelText: 'ATQ *',
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.shield),
                                  hintText: 'DEF',
                                  labelText: 'DEF *',
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart),
                                  hintText: 'Maitrise élémentaire',
                                  labelText: 'Maitrise élémentaire *',
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
                              Divider(),
                              Text("Stats avancées",style: TextStyle(fontSize: 20)),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart),
                                  hintText: 'Taux critique',
                                  labelText: 'Taux critique *',
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart),
                                  hintText: 'DGT critique',
                                  labelText: 'DGT critique *',
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
                              Divider(),
                              Text("Stats Elémentaires",style: TextStyle(fontSize: 20)),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Image.asset(
                                    'images/elements/Element_Pyro.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  hintText: 'DGT Pyro',
                                  labelText: 'DGT Pyro *',
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Image.asset(
                                    'images/elements/Element_Hydro.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  hintText: 'DGT Hydro',
                                  labelText: 'DGT Hydro *',
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Image.asset(
                                    'images/elements/Element_Dendro.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  hintText: 'DGT Dendro',
                                  labelText: 'DGT Dendro *',
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Image.asset(
                                    'images/elements/Element_Electro.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  hintText: 'DGT Electro',
                                  labelText: 'DGT Electro *',

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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Image.asset(
                                    'images/elements/Element_Anemo.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  hintText: 'DGT Anémo',
                                  labelText: 'DGT Anémo *',
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Image.asset(
                                    'images/elements/Element_Cryo.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  hintText: 'DGT Cryo',
                                  labelText: 'DGT Cryo *',
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Image.asset(
                                    'images/elements/Element_Geo.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  hintText: 'DGT Geo',
                                  labelText: 'DGT Geo *',
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart),
                                  hintText: 'DGT Physique',
                                  labelText: 'DGT Physique *',

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
                      )
                    ],
                  )
              ),
            ]
        )
    );
  }
}