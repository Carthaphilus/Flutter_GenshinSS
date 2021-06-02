class ArtefactStatEffet{
  int _id;
  int _valeur;
  int _type_statistiques_id;

  ArtefactStatEffet(this._id,this._valeur,this._type_statistiques_id);


  factory ArtefactStatEffet.fromJson(Map<String, dynamic> json){
    return ArtefactStatEffet(json["0"]["id"], json["0"]["valeur"], json["type_statistiques_id"]);
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'valeur':valeur,
    'type_statistiques_id':type_statistiques_id
  };

  static fromJsonTab(List<dynamic> json){
    List<ArtefactStatEffet> ListArtefactStatEffet = [];
    for(dynamic uneValeur in json){
      ArtefactStatEffet artefactStatEffet = new ArtefactStatEffet(uneValeur["id"], uneValeur["valeur"], uneValeur["type_statistiques_id"]);
      ListArtefactStatEffet.add(artefactStatEffet);
    }
    return ListArtefactStatEffet;
  }

  int get type_statistiques_id => _type_statistiques_id;

  set type_statistiques_id(int value) {
    _type_statistiques_id = value;
  }

  int get valeur => _valeur;

  set valeur(int value) {
    _valeur = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}