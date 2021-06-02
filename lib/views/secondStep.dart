import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:genshin_android_app/models/ArmeNiveau.dart';
import 'package:genshin_android_app/models/ArtefactStatEffet.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:genshin_android_app/controller/calculateController.dart';
import 'package:genshin_android_app/models/ArmeNiveau.dart';
import 'package:genshin_android_app/models/PersonnageNiveau.dart';
import 'package:genshin_android_app/globals.dart';

class secondStepPage extends StatefulWidget {
  calculateController paramOperation;
  secondStepPage({Key key, this.paramOperation}) : super(key: key);

  @override
  _secondStepPageState createState() => _secondStepPageState();
}

class _secondStepPageState extends State<secondStepPage> {

  final _formKey = GlobalKey<FormState>();
  calculateController operation;
  List<dynamic> listJsonData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    operation = widget.paramOperation;
    getPersonnageNiveau(operation.selectedPersonnage.personnageId.toString(), operation.pNiveau.niveau_id.toString());
    getArmeNiveau(operation.selectedArme.armeId.toString(), operation.aNiveau.niveau_id.toString());
    getSetEffect(operation.artefactSet1.id, operation.artefactStatEffet1);
    getSetEffect(operation.artefactSet2.id, operation.artefactStatEffet2);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Genshin SS'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.save),
                tooltip: 'Sauvegarder',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/save',
                    arguments: operation,
                  );
                },
              ),
            ]
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
                                        'images/personnages/icones/'+operation.selectedPersonnage.image.replaceAll('.jpg','.png'),
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(operation.resumeData()),
                                      subtitle: Text(operation.artefactSet1.label+' | '+operation.artefactSet2.label),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Text("Stats de base", style: TextStyle(fontSize: 20)),
                              TextFormField(
                                initialValue: operation.pvMax ?? '',
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart,size: 30),
                                  hintText: 'PV de base du personnage',
                                  labelText: 'PV max *',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  operation.pvMax = value;
                                  return numberValidator(operation.pvMax);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.atk ?? '',
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
                                  operation.atk = value;
                                  return numberValidator(operation.atk);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.atkP ?? '',
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.stacked_bar_chart,size: 30),
                                  hintText: 'ATQ%',
                                  labelText: 'ATQ% *',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?'))],
                                onSaved: (String value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String value) {
                                  operation.atkP = value;
                                  return numberValidator(operation.atkP);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.def ?? '',
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
                                  operation.def = value;
                                  return numberValidator(operation.def);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.me ?? '',
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
                                  operation.me = value;
                                  return numberValidator(operation.me);
                                },
                              ),
                              Divider(),
                              Text("Stats avancées",style: TextStyle(fontSize: 20)),
                              TextFormField(
                                initialValue: operation.tc ?? '',
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
                                  operation.tc = value;
                                  return numberValidator(operation.tc);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.dc ?? '',
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
                                  operation.dc = value;
                                  return numberValidator(operation.dc);
                                },
                              ),
                              Divider(),
                              Text("Stats Elémentaires",style: TextStyle(fontSize: 20)),
                              TextFormField(
                                initialValue: operation.dPyro ?? '',
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
                                  operation.dPyro = value;
                                  return numberValidator(operation.dPyro);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.dHydro ?? '',
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
                                  operation.dHydro = value;
                                  return numberValidator(operation.dHydro);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.dDendro ?? '',
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
                                  operation.dDendro = value;
                                  return numberValidator(operation.dDendro);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.dElectro ?? '',
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
                                  operation.dElectro = value;
                                  return numberValidator(operation.dElectro);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.dAnemo ?? '',
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
                                  operation.dAnemo = value;
                                  return numberValidator(operation.dAnemo);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.dCryo ?? '',
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
                                  operation.dCryo = value;
                                  return numberValidator(operation.dCryo);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.dGeo ?? '',
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
                                  operation.dGeo = value;
                                  return numberValidator(operation.dGeo);
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: operation.dPhys ?? '',
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
                                  operation.dPhys = value;
                                  return numberValidator(operation.dPhys);
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  if (_formKey.currentState.validate()) {
                                    Navigator.pushNamed(
                                      context,
                                      '/third',
                                      arguments: operation,
                                    );
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

  Future getPersonnageNiveau(String personnageId, String niveauId) async {
    final response = await http.get(BASE_URL+'/personnage_niveaus?personnage='+personnageId+"&niveau="+niveauId);
    if (response.statusCode == 200) {
      setState(() {
        listJsonData = json.decode(response.body);
        for(Map<String, dynamic> uneDataJson in listJsonData){
          PersonnageNiveau unPersonnageNiveau = new PersonnageNiveau.fromJson(uneDataJson);
          operation.personnageNiveau = unPersonnageNiveau;
        }
      });
      return "success";
    } else {
      return null;
    }
  }

  Future getArmeNiveau(String armeId, String niveauId) async {
    final response = await http.get(BASE_URL+'/arme_niveaus?arme='+armeId+"&niveau="+niveauId);
    if (response.statusCode == 200) {
      setState(() {
        listJsonData = json.decode(response.body);
        for(Map<String, dynamic> uneDataJson in listJsonData){
          ArmeNiveau uneArmeNiveau = new ArmeNiveau.fromJson(uneDataJson);
          operation.armeNiveau = uneArmeNiveau;
        }
      });
      return "success";
    } else {
      return null;
    }
  }

  Future getSetEffect(int artefactid, List<ArtefactStatEffet> unartefactStatEffet) async {
    final response = await http.get(BASE_URL+"/custom/artefact/stat/effet/"+artefactid.toString());
    if (response.statusCode == 200) {
      setState(() {
        listJsonData = json.decode(response.body);
        for(Map<String, dynamic> uneDataJson in listJsonData){
          ArtefactStatEffet uneStatArtefactEffet = new ArtefactStatEffet.fromJson(uneDataJson);
          unartefactStatEffet.add(uneStatArtefactEffet);
        }
      });
      return "success";
    } else {
      return null;
    }
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