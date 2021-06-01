class Niveau{
  int _niveau_id;
  int _nb_niveau;

  Niveau(this._niveau_id, this._nb_niveau);

  factory Niveau.fromJson(Map<String, dynamic> json){
    return Niveau(json["niveauId"], json["nbNiveau"]);
  }

  Map<String, dynamic> toJson() => {
    'niveauId':niveau_id,
    'nbNiveau':nb_niveau
  };

  int get niveau_id => _niveau_id;

  set niveau_id(int value) {
    _niveau_id = value;
  }

  int get nb_niveau => _nb_niveau;

  set nb_niveau(int value) {
    _nb_niveau = value;
  }
}