import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/globals.dart';

class firstStepController{
  static Personnage selectedPersonnage = null;
  static List<DropdownMenuItem<Personnage>> items = [];
  static List<Personnage> ListPersonnage = [];

  static Future<List<dynamic>> getPersonnages() async {
    final response = await http.get(BASE_URL+'/personnages');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static List<DropdownMenuItem<Personnage>> buildDropDownMenuItems(List<dynamic> jsonData) {
    for(Map<String, dynamic> uneDataJson in jsonData) {
      Personnage unPersonnage = new Personnage.fromJson(uneDataJson);
      ListPersonnage.add(unPersonnage);
    }

    for(Personnage unPersonnage in ListPersonnage) {
      firstStepController.items.add(
        DropdownMenuItem(
          child: Text(unPersonnage.nom),
          value: unPersonnage,
        ),
      );
    }

    selectedPersonnage = firstStepController.items[0].value;
    print(selectedPersonnage);
    return firstStepController.items;
  }
}