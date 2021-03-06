import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:genshin_android_app/controller/calculateController.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/models/Armes.dart';
import 'package:genshin_android_app/models/Artefact.dart';
import 'package:genshin_android_app/models/Niveau.dart';

import 'package:genshin_android_app/globals.dart';

/**
 * Sur cette page nous retrouvons la sélection du personnage, de l'armes, du raffinement, des niveaux et des artefacts
 */
class firstStepPage extends StatefulWidget {
  calculateController paramOperation;
  firstStepPage({Key key, this.paramOperation}) : super(key: key);

  @override
  _firstStepPageState createState() => _firstStepPageState();
}

class _firstStepPageState extends State<firstStepPage> {

  calculateController operation; //Attribut pour utilisé la classe controller operation

  //Enssemble des liste pour gerer les données des selecteurs
  List<Personnage> ListPersonnage = [];
  List<Armes> ListArme = [];
  List<dynamic> ListRaffinement = [];
  List<Niveau> ListNiveau = [];
  List<Artefact> ListArtefact = [];
  List<Artefact> ListArtefact2 = [];
  List<dynamic> listJsonData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Recuperation on instanciation de l'objet calculateController
    operation = widget.paramOperation ?? new calculateController();

    //Lancement des methodes pour la recuperation des données via l'API
    getPersonnages();
    getNiveau();
    getRaffinement();
    getArtefact();
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
                        //Affichage de l'image
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
                              value: operation.artefactSet1,
                              items: ListArtefact.map((list){
                                return DropdownMenuItem(
                                    child: Text(list.label),
                                    value: list
                                );
                              },).toList(),
                              onChanged: (newVal){
                                setState(() {
                                  operation.artefactSet1 = newVal;
                                  getArtefact2(operation.artefactSet1.id, operation.artefactSet1.label);
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                          children: [
                            DropdownButton(
                              hint: new Text("Set 2"),
                              value: operation.artefactSet2,
                              items: ListArtefact2.map((list){
                                return DropdownMenuItem(
                                    child: Text(list.label),
                                    value: list
                                );
                              },).toList(),
                              onChanged: (newVal){
                                setState(() {
                                  operation.artefactSet2 = newVal;
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

  //Methode pour récupéré les personnage via l'API
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

  //Methode pour récupéré l'arme en focntion du type d'arme du personnage
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

  //Methode pour récupéré le niveau
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

  //Methode pour récupéré les valeurs des raffinement
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

  //Recupération des artefacts ayant l'effet de deux piece
  Future getArtefact() async {
    final response = await http.get(BASE_URL+'/custom/artefact/');
    if (response.statusCode == 200) {
      setState(() {
        ListArtefact.clear();
        listJsonData = json.decode(response.body);
        for(dynamic uneDataJson in listJsonData) {
          Artefact unSetArt = new Artefact.fromJson(uneDataJson);
          ListArtefact.add(unSetArt);
        }
      });
      return "success";
    } else {
      return null;
    }
  }

  //Recuperation des artefactes ayant l'effet de deux piece + l'artefact de quatre piece de l'artefact sélectionné
  Future getArtefact2(int artefactid, String labelartefact) async {
    final response = await http.get(BASE_URL+'/custom/artefact/'+artefactid.toString()+'/'+labelartefact);
    if (response.statusCode == 200) {
      setState(() {
        ListArtefact2.clear();
        listJsonData = json.decode(response.body);
        for(dynamic uneDataJson in listJsonData) {
          Artefact unSetArt = new Artefact.fromJson(uneDataJson);
          ListArtefact2.add(unSetArt);
        }
      });
      return "success";
    } else {
      return null;
    }
  }

  //Methode permettant l'affichage d'une boite de dialogue dans le cas ou les sélecteur ne sont pas sélectionné
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