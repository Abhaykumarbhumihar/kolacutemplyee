import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/ApplyLeave.dart';
import '../model/LeaveApplyPojo.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class LeaveApplyController extends GetxController {
  var leaveApplyPojo = LeaveApplyPojo().obs;
  List<Datum> data = [];
  var applyLeavePojo = ApplyLeavePojo().obs;
  var lodaer = true;
  var sessionId = "".obs;
   SharedPreferences sharedPreferences;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var _testValue = sharedPreferences.getString("session");
      // will be null if never previously saved
      //  print("SDFKLDFKDKLFKDLFKLDFKL  "+"${_testValue}");
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var _testValue = sharedPreferences.getString("session");
      // will be null if never previously saved
      //  print("SDFKLDFKDKLFKDLFKLDFKL  "+"${_testValue}");
      leaveList(_testValue);
    });
  }

//  session_id:PqtoOdpQ0SBVTMT0a15gnT7euR9x8fO6
// leave_date:2022-06-05
// holiday_type:partialy_off
// start_from:10:00
// end_from:01:00
// holiday_reason:urgent work at home

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    var session = prefs.getString('session');
    sessionId.value = session;
    update();
  }

  void filterStatus(selectedDate) {
    if (selectedDate == "All") {
      data = leaveApplyPojo.value.data;
      update();
    } else {
      var newlist = leaveApplyPojo.value.data
          .where((x) => x.holidayType
              .toString()
              .toLowerCase()
              .contains(selectedDate.toLowerCase()))
          .toList();
      data = newlist;
      update();
    }

    update();
    print("here pring ${selectedDate}");
  }

  void applyLeave(
      session_id, date, leavetype, starttime, endtime, reason) async {
    Map map;

    map = {
      "session_id": session_id,
      "leave_date": date,
      "holiday_type": leavetype,
      "start_from": starttime,
      "end_from": endtime,
      "holiday_reason": reason
    };
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.LEAVE_APPLY);
      print(response);
      CommonDialog.hideLoading();
      applyLeavePojo.value = applyLeavePojoFromJson(response);
      if (leaveApplyPojo.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
        Get.back();
        lodaer = false;

        leaveListUpdated(session_id);
        update();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }

  void leaveList(_testValue) async {
    print("HERE SESSION IS ${_testValue}");
    Map map;
    map = {
      "session_id": _testValue,
    };
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.LEAVE_MANAGEMENT);
      print(response);
      CommonDialog.hideLoading();
      leaveApplyPojo.value = leaveApplyPojoFromJson(response);
      if (leaveApplyPojo.value.data.isNotEmpty) {
        data = leaveApplyPojo.value.data;
        update();
      }
      if (leaveApplyPojo.value.message == "No Data found") {
        CommonDialog.showsnackbar("No Data found");
      } else {
        // Get.to(const VerifyOtpPage());
        update();
        lodaer = false;
        update();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }

  void leaveListUpdated(session_id) async {
    Map map;
    map = {
      "session_id": session_id,
    };
    try {
      lodaer = false;
      update();
      CommonDialog.showLoading(title: "Please waitt...");
      final response =
          await APICall().registerUrse(map, AppConstant.LEAVE_MANAGEMENT);
      print(response);
      CommonDialog.hideLoading();
      leaveApplyPojo.value = leaveApplyPojoFromJson(response);
      if (leaveApplyPojo.value.data.isNotEmpty) {
        data = leaveApplyPojo.value.data;
        update();
      }
      if (leaveApplyPojo.value.message == "No Data found") {
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
