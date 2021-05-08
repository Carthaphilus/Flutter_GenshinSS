import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/models/Armes.dart';

import 'package:genshin_android_app/globals.dart';


class firstStepPage extends StatefulWidget {
  @override
  _firstStepPageState createState() => _firstStepPageState();
}

class _firstStepPageState extends State<firstStepPage> {

  Personnage selectedPersonnage = null;
  List<Personnage> ListPersonnage = [];
  Armes selectedArme = null;
  List<Armes> ListArme = [];
  List<dynamic> listJsonData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPersonnages();
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              selectedPersonnage == null ? 'images/personnages/cards/Character_Aether_Thumb.jpg' : 'images/personnages/cards/'+selectedPersonnage.image ,
                              width: 200,
                              height: 400,
                              fit: BoxFit.cover,
                            )
                        ),
                        DropdownButton(
                          hint: new Text("Selectionner le personnage"),
                          value: selectedPersonnage,
                          items: ListPersonnage.map((list){
                            return DropdownMenuItem(
                                child: Text(list.nom),
                                value: list
                            );
                          },).toList(),
                          onChanged: (newVal){
                            setState(() {
                              selectedPersonnage = newVal;
                              selectedArme = null;
                              getArmes(selectedPersonnage.armeType.armeTypeId.toString());
                            });
                          },
                        ),
                        DropdownButton(
                          hint: new Text("Selectionner l'arme"),
                          value: selectedArme,
                          items: ListArme.map((list){
                            return DropdownMenuItem(
                                child: Text(list.nomArme),
                                value: list
                            );
                          },).toList(),
                          onChanged: (newVal){
                            setState(() {
                              selectedArme = newVal;
                            });
                          },
                        ),
                        DropdownButton(
                          hint: new Text("Selectionner un set"),
                          value: selectedPersonnage,
                          items: ListPersonnage.map((list){
                            return DropdownMenuItem(
                                child: Text(list.nom),
                                value: list
                            );
                          },).toList(),
                          onChanged: (newVal){
                            setState(() {
                              selectedPersonnage = newVal;
                            });
                          },
                        ),
                        DropdownButton(
                          hint: new Text("Selectionner un set"),
                          value: selectedPersonnage,
                          items: ListPersonnage.map((list){
                            return DropdownMenuItem(
                                child: Text(list.nom),
                                value: list
                            );
                          },).toList(),
                          onChanged: (newVal){
                            setState(() {
                              selectedPersonnage = newVal;
                            });
                          },
                        ),
                        ElevatedButton(
                            onPressed: (){
                              Navigator.pushNamed(
                                  context,
                                  '/second',
                                arguments: [selectedPersonnage, selectedArme],
                              );
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
}