class Competences {

  int _competence_id;
  String _personnage_competence_label;
  int _ascension;
  double _pourcentage_degats;

  Competences(this._competence_id, this._personnage_competence_label, this._ascension, this._pourcentage_degats);

  factory Competences.fromJson(Map<String, dynamic> json){
    return Competences(json["competenceId"], json["personnageCompetenceLabel"], json["ascension"], json["pourcentageDegats"].toDouble());
  }

  double get pourcentage_degats => _pourcentage_degats;

  set pourcentage_degats(double value) {
    _pourcentage_degats = value;
  }

  int get ascension => _ascension;

  set ascension(int value) {
    _ascension = value;
  }

  String get personnage_competence_label => _personnage_competence_label;

  set personnage_competence_label(String value) {
    _personnage_competence_label = value;
  }

  int get competence_id => _competence_id;

  set competence_id(int value) {
    _competence_id = value;
  }
}
