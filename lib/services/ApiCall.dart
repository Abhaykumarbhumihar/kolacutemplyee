import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kolacut_employee/utils/CommomDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login.dart';
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
    final body = json.decode(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonString;
    } else if(response.statusCode==403){
      SharedPreferences prefrences = await SharedPreferences.getInstance();
      await prefrences.remove("session");
       print(body["message"]);
       CommonDialog.showsnackbar(body["message"]);
       Get.off(LoginPage());
       return "null";
    }else {
      return "null";
    }
  }

  Future<String> registerUrseWithoutbody( url) async {
    var apiUrl = Uri.parse(AppConstant.BASE_URL + url);
    print(apiUrl);
    final response = await http.get(
      apiUrl,
    );

    print(response);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonString;
    } else {
      return "null";
    }
  }


}
