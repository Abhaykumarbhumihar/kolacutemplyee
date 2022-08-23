import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../model/ProfilePojo.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class ProfileController extends GetxController {
  var profilePojo = ProfilePojo().obs;
  var lodaer = true;
  late SharedPreferences sharedPreferences;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
  var sessionId="".obs;
  void getData()async{
    final prefs = await SharedPreferences.getInstance();

    var session = prefs.getString('session');
    sessionId.value=session!;
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var  _testValue = sharedPreferences.getString("session");
      // will be null if never previously saved
      //print("SDFKLDFKDKLFKDLFKLDFKL  "+"${_testValue}");
      getProfile(_testValue);
    });

  }



//session_id:PqtoOdpQ0SBVTMT0a15gnT7euR9x8fO6
  void getProfile(session_id) async {
    Map map;
    map = {"session_id": session_id};
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
      await APICall().registerUrse(map, AppConstant.GET_PROFILE);
      print(response);
      CommonDialog.hideLoading();
      profilePojo.value = profilePojoFromJson(response);
      if (profilePojo.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
        update();
        lodaer = false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }
}
