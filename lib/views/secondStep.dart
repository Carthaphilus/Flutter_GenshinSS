import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:genshin_android_app/controller/calculateController.dart';
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
  String pvMax;
  String atk;
  String def;
  String me;
  String tc;
  String dc;
  String dPyro;
  String dHydro;
  String dDendro;
  String dElectro;
  String dAnemo;
  String dCryo;
  String dGeo;
  String dPhys;

  calculateController operation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    operation = new calculateController(pvMax);
  }

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
                                  icon: Icon(Icons.stacked_bar_chart,size: 30),
                                  hintText: 'PV max',
                                  labelText: 'PV max *',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  pvMax = value;
                                  return numberValidator(pvMax);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart,size: 30),
                                  hintText: 'ATQ',
                                  labelText: 'ATQ *',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  atk = value;
                                  return numberValidator(atk);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.shield,size: 30),
                                  hintText: 'DEF',
                                  labelText: 'DEF *',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  def = value;
                                  return numberValidator(def);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart,size: 30),
                                  hintText: 'Maitrise élémentaire',
                                  labelText: 'Maitrise élémentaire *',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  me = value;
                                  return numberValidator(me);
                                },
                              ),
                              Divider(),
                              Text("Stats avancées",style: TextStyle(fontSize: 20)),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart,size: 30),
                                  hintText: 'Taux critique',
                                  labelText: 'Taux critique *',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  tc = value;
                                  return numberValidator(tc);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart,size: 30),
                                  hintText: 'DGT critique',
                                  labelText: 'DGT critique *',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  dc = value;
                                  return numberValidator(dc);
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                //r"^\d+[,|\.]\d?$"
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  dPyro = value;
                                  return numberValidator(dPyro);
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  dHydro = value;
                                  return numberValidator(dHydro);
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
                                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  dDendro = value;
                                  return numberValidator(dDendro);
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  dElectro = value;
                                  return numberValidator(dElectro);
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  dAnemo = value;
                                  return numberValidator(dAnemo);
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  dCryo = value;
                                  return numberValidator(dCryo);
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  dGeo = value;
                                  return numberValidator(dGeo);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart,size: 30),
                                  hintText: 'DGT Physique',
                                  labelText: 'DGT Physique *',

                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  dPhys = value;
                                  return numberValidator(dPhys);
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  if (_formKey.currentState.validate()) {
                                    operation.Calculstat();
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

  String numberValidator(String value) {
    if(value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if(n == null) {
      return '"$value" n\'est pas un nombre valide.';
    }
    return null;
  }
}