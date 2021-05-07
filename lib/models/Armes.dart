
import 'dart:convert';
import 'package:http/http.dart' as http;



class URLS {
  static const String BASE_URL = 'http://127.0.0.1:8000/api';
}
class Armes {

//armes
  static Future<List<dynamic>> getArmes() async {
    final response = await http.get('${URLS.BASE_URL}/armes');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
