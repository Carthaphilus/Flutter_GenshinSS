import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:genshin_android_app/controller/calculateController.dart';
import 'package:genshin_android_app/models/Competences.dart';
import 'package:genshin_android_app/globals.dart';

/**
 * Sur cette page nous retrouvons l'enssemble des tableaux avec les données calculé
 */
class thirdStepPage extends StatefulWidget {

  calculateController paramOperation;
  thirdStepPage({Key key, this.paramOperation}) : super(key: key);

  @override
  _thirdStepPageState createState() => _thirdStepPageState();
}

class _thirdStepPageState extends State<thirdStepPage> {

  calculateController operation; //Attribut pour récupéré l'objet calculateController

  //Attribut stockant la liste des dataRow pour chaque type de compétence
  List<DataRow> RowAtkNormale = [];
  List<DataRow> RowCompetenceElementaire = [];
  List<DataRow> RowDechainementElementaire = [];
  List<dynamic> listJsonData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    operation = widget.paramOperation; //Recuperation de l'objet calculateController

    //Envoie des methodes recuperant les competances en fonction du personnage, de son type et insertion dans la liste de DataRow
    getCompetence(operation.selectedPersonnage.personnageId.toString(), "1", "1", RowAtkNormale);
    getCompetence(operation.selectedPersonnage.personnageId.toString(), "2", "1", RowCompetenceElementaire);
    getCompetence(operation.selectedPersonnage.personnageId.toString(), "3", "1", RowDechainementElementaire);
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
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                      children: [
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
                        Text("Dgt Attaque Normale", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Ascension',
                            labelText: 'Ascension *',
                          ),
                          initialValue: "1",
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (String value) {
                            if(numberValidator(value)){
                              getCompetence(operation.selectedPersonnage.personnageId.toString(), "1" ,value, RowAtkNormale);
                            }
                          },
                        ),
                        DataTable(
                            columns: [
                              DataColumn(label: Text("Coup")),
                              DataColumn(label: Text("Basique")),
                              DataColumn(label: Text("Critique"))
                            ],
                            rows: RowAtkNormale
                        ),
                        SizedBox(height: 20),
                        Text("Dgt Compétence élementaire", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Ascension',
                            labelText: 'Ascension *',
                          ),
                          initialValue: "1",
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (String value) {
                            if(numberValidator(value)){
                              getCompetence(operation.selectedPersonnage.personnageId.toString(), "2" ,value, RowCompetenceElementaire);
                            }
                          },
                        ),
                        DataTable(
                            columns: [
                              DataColumn(label: Text("Coup")),
                              DataColumn(label: Text("Basique")),
                              DataColumn(label: Text("Critique"))
                            ],
                            rows: RowCompetenceElementaire
                        ),
                        SizedBox(height: 20),
                        Text("Dgt Déchainement élementaire", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Ascension',
                            labelText: 'Ascension *',
                          ),
                          initialValue: "1",
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (String value) {
                            if(numberValidator(value)){
                              getCompetence(operation.selectedPersonnage.personnageId.toString(), "3" ,value, RowDechainementElementaire);
                            }
                          },
                        ),
                        DataTable(
                            columns: [
                              DataColumn(label: Text("Coup")),
                              DataColumn(label: Text("Basique")),
                              DataColumn(label: Text("Critique"))
                            ],
                            rows: RowDechainementElementaire
                        ),
                      ],
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //Methode pour recupere les compétences en focntion du personnage, du type et insertion dans sa Liste de dataRow après ca création
  Future getCompetence(String idPersonnage, String idTypeCompetence ,String idAscencion, List<DataRow> ListRow) async {
    final response = await http.get(BASE_URL+'/competences?personnage='+idPersonnage+'&typeCompetence='+idTypeCompetence+'&ascension='+idAscencion);
    if (response.statusCode == 200) {
      setState(() {
        ListRow.clear();
        listJsonData = json.decode(response.body);
        for(Map<String, dynamic> uneDataJson in listJsonData) {
          Competences uneCompetence = new Competences.fromJson(uneDataJson);
          uneCompetence.typeCompetence = int.parse(idTypeCompetence);
          operation.Calculstat(uneCompetence);
          ListRow.add(
              DataRow(
                  cells: [
                    DataCell(
                        Text(uneCompetence.personnage_competence_label)
                    ),
                    DataCell(
                        Text(operation.totAtk.ceil().toString())
                    ),
                    DataCell(
                        Text(operation.totAtkCrit.ceil().toString())
                    ),
                  ]
              )
          );
        }
      });
      return "success";
    } else {
      return null;
    }
  }

  //Fonction pour valider les champ de type numerique
  bool numberValidator(String value) {
    if(value == null) {
      return false;
    }
    final n = num.tryParse(value);
    if(n == null) {
      return false;
    }
    return true;
  }

}