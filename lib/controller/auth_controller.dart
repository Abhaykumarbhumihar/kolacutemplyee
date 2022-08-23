import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../model/LoginPojo.dart';
import '../model/ProfilePojo.dart';
import '../screens/homebottombar.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class AuthController extends GetxController {
  var loginPojo = LoginPojo().obs;
  var profilePojo = ProfilePojo().obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  //email:ajay78@gmail.com
  // password:12345678
  // device_token:123456
  // device_type:android

  void login(email, password) async {
    String? fcm_token = await FirebaseMessaging.instance.getToken();

    Map map;
    map = {
      "email": email,
      "password": password,
      "device_token": "SDF SDF SDF SDF SD F",
      "device_type": "$fcm_token"
    };
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response = await APICall().registerUrse(map, AppConstant.LOGIN);
      print(response);
      CommonDialog.hideLoading();
      final body = json.decode(response);
      if(body["status"]==200)
        {
          loginPojo.value = loginPojoFromJson(response);
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('session', loginPojo.value.data!.token.toString());
          await prefs.setString('name', loginPojo.value.data!.name.toString());
          await prefs.setString('email', loginPojo.value.data!.email.toString());
          await prefs.setString('phoneno', loginPojo.value.data!.phone.toString());
          await prefs.setString('image', loginPojo.value.data!.image.toString());
          Get.off(HomeBottomBar());
        }else{
        CommonDialog.showsnackbar(body["message"]);
      }

    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }

//session_id:PqtoOdpQ0SBVTMT0a15gnT7euR9x8fO6
  void getProfile(session_id) async {
    Map map;
    map = {"session_id": "PqtoOdpQ0SBVTMT0a15gnT7euR9x8fO6"};
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.GET_PROFILE);
      print(response);
      CommonDialog.hideLoading();
      profilePojo.value = profilePojoFromJson(response);
      if (loginPojo.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }
}
