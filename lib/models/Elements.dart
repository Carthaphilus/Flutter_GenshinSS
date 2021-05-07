import 'dart:convert';
import 'package:http/http.dart' as http;

class URLS {
  static const String BASE_URL = 'http://127.0.0.1:8000/api';
}

class Elements {

  int _elementId;
  String _label;

  Elements(this._elementId,this._label);

  factory Elements.fromJson(Map<String, dynamic> json){
    return Elements(json["elementId"], json["label"]);
  }

  static Future<List<dynamic>> getElements() async {
    final response = await http.get('${URLS.BASE_URL}/elements');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  int get elementId => _elementId;

  set elementId(int value) {
    _elementId = value;
  }

  String get label => _label;

  set label(String value) {
    _label = value;
  }
}
