
import 'dart:convert';
import 'package:http/http.dart' as http;


class URLS {
  static const String BASE_URL = 'http://127.0.0.1:8000/api';
}

class Competences {

// competences
  static Future<List<dynamic>> getCompetences() async {
    final response = await http.get('${URLS.BASE_URL}/competences');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
