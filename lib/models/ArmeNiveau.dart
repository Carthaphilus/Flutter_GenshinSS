class ArmeNiveau{
  int _arme_niveau_id;
  int _atk;
  String _stat_secondaire;

  ArmeNiveau(this._arme_niveau_id, this._atk, this._stat_secondaire);

  factory ArmeNiveau.fromJson(Map<String, dynamic> json){
    return ArmeNiveau(json["arme_niveau_id"], json["atk"], json["stat_secondaire"]);
  }

  Map<String, dynamic> toJson() => {
    'arme_niveau_id':arme_niveau_id,
    'atk':atk,
    'stat_secondaire':stat_secondaire
  };

  int get arme_niveau_id => _arme_niveau_id;

  set arme_niveau_id(int value) {
    _arme_niveau_id = value;
  }

  int get atk => _atk;

  set atk(int value) {
    _atk = value;
  }

  String get stat_secondaire => _stat_secondaire;

  set stat_secondaire(String value) {
    _stat_secondaire = value;
  }
}