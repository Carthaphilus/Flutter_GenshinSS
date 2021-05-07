

class ArmeType{
 int _armeTypeId;
 String _labelType;

 ArmeType(this._armeTypeId, this._labelType);

 factory ArmeType.fromJson(Map<String, dynamic> json){
   return ArmeType(json["armeTypeId"], json["labelType"]);
 }


 int get armeTypeId => _armeTypeId;

  set armeTypeId(int value) {
    _armeTypeId = value;
  }

 String get labelType => _labelType;

  set labelType(String value) {
    _labelType = value;
  }
}