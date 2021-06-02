class Artefact{
  int _id;
  int _nb_set_artefact;
  String _label;
  String _label_effet;

  Artefact(this._id,this._nb_set_artefact,this._label,this._label_effet);

  factory Artefact.fromJson(Map<String, dynamic> json){
    return Artefact(json["id"], json["nb_set_artefact"], json["label"], json["label_effet"]);
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'nb_set_artefact':nb_set_artefact,
    'label':label,
    'label_effet':label_effet,
  };

  String get label_effet => _label_effet;

  set label_effet(String value) {
    _label_effet = value;
  }

  String get label => _label;

  set label(String value) {
    _label = value;
  }

  int get nb_set_artefact => _nb_set_artefact;

  set nb_set_artefact(int value) {
    _nb_set_artefact = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}