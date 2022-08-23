import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../utils/appconstant.dart';

class APICall {
  final apiBaseUri = "http://bltechno.atwebpages.com/index.php/Dashboard";

  Future<String> registerUrse(Map map, url) async {
    var apiUrl = Uri.parse(AppConstant.BASE_URL + url);
    print(apiUrl);
    print(map);
    final response = await http.post(
      apiUrl,
      body: map,
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonString;
    } else {
      return "null";
    }
  }

}
