import 'dart:convert';
import 'package:http/http.dart' as http;

class PersonnageNiveau{

  int _id;
  String _stat_ascension;
  int _atk;
  int _hp;
  int _def;

  PersonnageNiveau(this._id, this._stat_ascension, this._atk, this._hp, this._def);

  factory PersonnageNiveau.fromJson(Map<String, dynamic> json){
    return PersonnageNiveau(json["id"], json["stat_ascension"], json["atk"], json["hp"], json["def"]);
  }

  int get def => _def;

  set def(int value) {
    _def = value;
  }

  int get hp => _hp;

  set hp(int value) {
    _hp = value;
  }

  int get atk => _atk;

  set atk(int value) {
    _atk = value;
  }

  String get stat_ascension => _stat_ascension;

  set stat_ascension(String value) {
    _stat_ascension = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}