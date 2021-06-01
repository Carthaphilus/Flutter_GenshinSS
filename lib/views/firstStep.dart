import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:genshin_android_app/controller/calculateController.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/models/Armes.dart';
import 'package:genshin_android_app/models/Niveau.dart';

import 'package:genshin_android_app/globals.dart';


class firstStepPage extends StatefulWidget {
  calculateController paramOperation;
  firstStepPage({Key key, this.paramOperation}) : super(key: key);

  @override
  _firstStepPageState createState() => _firstStepPageState();
}

class _firstStepPageState extends State<firstStepPage> {

  calculateController operation;
  List<Personnage> ListPersonnage = [];
  List<Armes> ListArme = [];
  List<dynamic> ListRaffinement = [];
  List<Niveau> ListNiveau = [];
  List<dynamic> listJsonData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    operation = widget.paramOperation ?? new calculateController();
    getPersonnages();
    getNiveau();
    getRaffinement();
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              operation.selectedPersonnage == null ? 'images/personnages/cards/Character_Aether_Thumb.jpg' : 'images/personnages/cards/'+operation.selectedPersonnage.image ,
                              width: 200,
                              height: 400,
                              fit: BoxFit.cover,
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DropdownButton(
                              hint: new Text("Personnage"),
                              value: operation.selectedPersonnage,
                              items: ListPersonnage.map((list){
                                return DropdownMenuItem(
                                    child: Text(list.nom),
                                    value: list
                                );
                              },).toList(),
                              onChanged: (newVal){
                                setState(() {
                                  operation.selectedPersonnage = newVal;
                                  operation.selectedArme = null;
                                  getArmes(operation.selectedPersonnage.armeType.armeTypeId.toString());
                                });
                              },
                            ),
                            DropdownButton(
                              hint: new Text("Niveau"),
                              value: operation.pNiveau,
                              items: ListNiveau.map((list){
                                return DropdownMenuItem(
                                    child: Text(list.nb_niveau.toString()),
                                    value: list
                                );
                              },).toList(),
                              onChanged: (newVal){
                                setState(() {
                                  operation.pNiveau = newVal;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DropdownButton(
                              hint: new Text("Arme"),
                              value: operation.selectedArme,
                              items: ListArme.map((list){
                                return DropdownMenuItem(
                                    child: Text(list.nomArme),
                                    value: list
                                );
                              },).toList(),
                              onChanged: (newVal){
                                setState(() {
                                  operation.selectedArme = newVal;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children : [
                              DropdownButton(
                                hint: new Text("Raffinement"),
                                value: operation.selectedRaffinement,
                                items: ListRaffinement.map((list){
                                  return DropdownMenuItem(
                                      child: Text(list.toString()),
                                      value: list
                                  );
                                },).toList(),
                                onChanged: (newVal){
                                  setState(() {
                                    operation.selectedRaffinement = newVal;
                                  });
                                },
                              ),
                              DropdownButton(
                                hint: new Text("Niveau"),
                                value: operation.aNiveau,
                                items: ListNiveau.map((list){
                                  return DropdownMenuItem(
                                      child: Text(list.nb_niveau.toString()),
                                      value: list
                                  );
                                },).toList(),
                                onChanged: (newVal){
                                  setState(() {
                                    operation.aNiveau = newVal;
                                  });
                                },
                              ),
                            ]
                        ),
                        Row(
                          mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                          children: [
                            DropdownButton(
                              hint: new Text("Set 1"),
                              value: operation.selectedPersonnage,
                              items: ListPersonnage.map((list){
                                return DropdownMenuItem(
                                    child: Text(list.nom),
                                    value: list
                                );
                              },).toList(),
                              onChanged: (newVal){
                                setState(() {
                                  operation.selectedPersonnage = newVal;
                                });
                              },
                            ),
                            DropdownButton(
                              hint: new Text("Set 2"),
                              value: operation.selectedPersonnage,
                              items: ListPersonnage.map((list){
                                return DropdownMenuItem(
                                    child: Text(list.nom),
                                    value: list
                                );
                              },).toList(),
                              onChanged: (newVal){
                                setState(() {
                                  operation.selectedPersonnage = newVal;
                                });
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: (){
                              if(operation.selectedPersonnage != null && operation.selectedArme != null
                                  && operation.pNiveau != null &&  operation.pNiveau != null
                                  && operation.selectedRaffinement != null) {
                                Navigator.pushNamed(
                                  context,
                                  '/second',
                                  arguments: operation,
                                );
                              }else{
                                _showMyDialog();
                              }
                            },
                            child: Text("Suivant")
                        )
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

  Future getPersonnages() async {
    final response = await http.get(BASE_URL+'/personnages');
    if (response.statusCode == 200) {
      setState(() {
        listJsonData = json.decode(response.body);
        for(Map<String, dynamic> uneDataJson in listJsonData) {
          Personnage unPersonnage = new Personnage.fromJson(uneDataJson);
          ListPersonnage.add(unPersonnage);
        }
      });
      return "success";
    } else {
      return null;
    }
  }

  Future getArmes(String id) async {
    final response = await http.get(BASE_URL+'/armes?armeType='+id);
    if (response.statusCode == 200) {
      setState(() {
        ListArme.clear();
        listJsonData = json.decode(response.body);
        for(Map<String, dynamic> uneDataJson in listJsonData) {
          Armes uneArmes = new Armes.fromJson(uneDataJson);
          ListArme.add(uneArmes);
        }
      });
      return "success";
    } else {
      return null;
    }
  }

  Future getNiveau() async {
    final response = await http.get(BASE_URL+'/niveaux');
    if (response.statusCode == 200) {
      setState(() {
        ListNiveau.clear();
        listJsonData = json.decode(response.body);
        for(Map<String, dynamic> uneDataJson in listJsonData) {
          Niveau unNiveaux = new Niveau.fromJson(uneDataJson);
          ListNiveau.add(unNiveaux);
        }
      });
      return "success";
    } else {
      return null;
    }
  }

  Future getRaffinement() async {
    final response = await http.get(BASE_URL+'/custom/arme/type/statistique/raffinement');
    if (response.statusCode == 200) {
      setState(() {
        ListRaffinement.clear();
        listJsonData = json.decode(response.body);
        for(dynamic uneDataJson in listJsonData) {
          dynamic unRaffinement = uneDataJson["1"];
          ListRaffinement.add(unRaffinement);
        }
      });
      return "success";
    } else {
      return null;
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur: Champ incomplet'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Veullez remplir l\'ensemble des champs précédents'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}