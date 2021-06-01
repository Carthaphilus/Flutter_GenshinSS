import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:genshin_android_app/controller/calculateController.dart';
import 'package:shared_preferences/shared_preferences.dart';


class savePage extends StatefulWidget {

  calculateController paramOperation;
  savePage({Key key, this.paramOperation}) : super(key: key);

  @override
  _savePageState createState() => _savePageState();
}

class _savePageState extends State<savePage> {

  calculateController operation;
  final _formKey = GlobalKey<FormState>();
  String DataSave;
  String AllDataSave;
  List<dynamic> ListProfil = [];
  calculateController selectedProfil;
  String nomProfil;
  bool visible = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    operation = widget.paramOperation;
    if(operation.selectedPersonnage != null){
      visible = true;
    }
    getAllDataSave();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Genshin SS'),
        ),
        body:
        ListView(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text("Sélectionner un profil", style: TextStyle(fontSize: 20)),
                        DropdownButton(
                          hint: new Text("Profils"),
                          value: selectedProfil,
                          items: ListProfil.map((list){
                            return DropdownMenuItem(
                                child: Text(list.NomProfil),
                                value: list
                            );
                          },).toList(),
                          onChanged: (newVal){
                            setState(() {
                              selectedProfil = newVal;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (selectedProfil != null) {
                                  delDataSave(selectedProfil.NomProfil);
                                  getAllDataSave();
                                }
                              },
                              child: Text('Supprimé'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (selectedProfil != null) {
                                  Navigator.pushNamed(
                                    context,
                                    '/second',
                                    arguments: selectedProfil,
                                  );
                                }
                              },
                              child: Text('Visionné'),
                            ),
                          ],
                        ),
                        if(operation.selectedPersonnage != null &&
                            operation.selectedArme != null &&
                            operation.selectedRaffinement != null &&
                            operation.aNiveau != null &&
                            operation.pNiveau != null
                        )
                          Column(
                            children: [
                              SizedBox(height: 20),
                              Text("Recapitulatif:", style: TextStyle(fontSize: 20)),
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Image.asset(
                                        'images/personnages/icones/' +
                                            operation.selectedPersonnage.image
                                                .replaceAll('.jpg', '.png'),
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(operation.resumeData()),
                                      subtitle: Text('Set 1 | Set 2'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Enregistrer un profil",
                                            style: TextStyle(fontSize: 20)),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Nom du profil',
                                            labelText: 'Nom du profil',
                                          ),
                                          keyboardType: TextInputType.text,
                                          onChanged: (String value) {
                                            nomProfil = value;
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Validate will return true if the form is valid, or false if
                                            // the form is invalid.
                                            if (_formKey.currentState.validate()) {
                                              setState(() {
                                                getDataSave(nomProfil);
                                                if (DataSave == null) {
                                                  operation.NomProfil = nomProfil;
                                                  setDataSave(nomProfil, jsonEncode(
                                                      operation.toJson()));
                                                  getAllDataSave();
                                                }
                                              });
                                            }
                                          },
                                          child: Text('Enregistrer'),
                                        ),
                                      ]
                                  )
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }

  Future getDataSave(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      DataSave = prefs.get(key);
    });
  }

  Future getAllDataSave() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> DataSaveKey = prefs.getKeys();
    setState(() {
      selectedProfil = null;
      ListProfil.clear();
      for(String uneKey in DataSaveKey){
        var uneDataSave = jsonDecode(prefs.get(uneKey));
        calculateController operation = new calculateController.fromJson(uneDataSave);
        ListProfil.add(operation);
      }
    });
  }

  setDataSave(key,data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key,data);
  }

  delDataSave(key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clearDataSave() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}