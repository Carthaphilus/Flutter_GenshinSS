import 'package:genshin_android_app/models/ArmeType.dart';
import 'package:genshin_android_app/models/Elements.dart';

class Personnage {

  int _personnageId;
  String _nom;
  int _rarete;
  String _image;
  ArmeType _armeType;
  Elements _element;

  Personnage(this._personnageId, this._nom, this._rarete, this._image, this._armeType, this._element);

  factory Personnage.fromJson(Map<String, dynamic> json){
    return Personnage(
        json["personnageId"],
        json["nom"],
        json["rarete"],
        json["image"],
        ArmeType.fromJson(json["armeType"]),
        Elements.fromJson(json["element"])
    );
  }

  Map<String, dynamic> toJson() => {
    'personnageId':personnageId,
    'nom':nom,
    'rarete':rarete,
    'image':image,
   'armeType':armeType,
    'element':element
  };

  int get personnageId => _personnageId;

  set personnageId(int value) {
    _personnageId = value;
  }

  String get nom => _nom;

  set nom(String value) {
    _nom = value;
  }

  int get rarete => _rarete;

  set rarete(int value) {
    _rarete = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  ArmeType get armeType => _armeType;

  set armeType(ArmeType value) {
    _armeType = value;
  }

  Elements get element => _element;

  set element(Elements value) {
    _element = value;
  }
}




