import 'package:genshin_android_app/models/ArmeType.dart';

import 'ArmeType.dart';

class Armes {
  int _armeId;
  String _nomArme;
  String _imageArme;
  int _rarete;

  Armes(this._armeId, this._nomArme, this._imageArme, this._rarete);

  factory Armes.fromJson(Map<String, dynamic> json){
    return Armes(json["armeId"], json["nomArme"], json["imageArme"], json["rarete"]);
  }

  Map<String, dynamic> toJson() => {
    'armeId':armeId,
    'nomArme':nomArme,
    'imageArme':imageArme,
    'rarete':rarete
  };

  int get rarete => _rarete;

  set rarete(int value) {
    _rarete = value;
  }

  String get imageArme => _imageArme;

  set imageArme(String value) {
    _imageArme = value;
  }

  String get nomArme => _nomArme;

  set nomArme(String value) {
    _nomArme = value;
  }

  int get armeId => _armeId;

  set armeId(int value) {
    _armeId = value;
  }
}
