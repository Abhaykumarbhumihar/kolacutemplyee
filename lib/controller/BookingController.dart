import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/AcceptBookigPojo.dart';
import '../model/AllBookingPojoo.dart';
import '../model/Graphpojjo.dart';
import '../services/ApiCall.dart';
import '../utils/CommomDialog.dart';
import '../utils/appconstant.dart';

class BookingController extends GetxController {
  var bookingPojo = AllBookingPojoo().obs;
  var lodaer = true;
  var shopId = "".obs;
  var sessionId="".obs;
  List<SlotDetail> element = [];
  var acceptBookingPojo=AcceptBookigPojo().obs;
  late SharedPreferences sharedPreferences;
  var graphPojo = Graphpojjo().obs;
  void getData()async{
    final prefs = await SharedPreferences.getInstance();

    var session = prefs.getString('session');
    sessionId.value=session!;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    //session_id
    super.onReady();
    print("SDLKFJKLSDFJDSprofile");
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var  _testValue = sharedPreferences.getString("session");
      // will be null if never previously saved
     // print("SDFKLDFKDKLFKDLFKLDFKL  "+"${_testValue}");
      getBookingList(_testValue);
      getChart();
    });

  }

  void acceptBooking(bookingId) async {
    print("Session iodd"+"${sessionId.value}");
    Map map;
    map = {"session_id":sessionId.value,
      "booking_id":bookingId};
    //map = {"session_id": "TXKe48DXicKoAjkyEOgXWqU3VuVZqdHm"};
    print("API HIT HIT HIT HIT");
    try {
      // CommonDialog.showLoading(title: "Please waitt...");
      final response = await APICall().registerUrse(map, AppConstant.ACCEPT_BOOKING);
      print(response);
      // CommonDialog.hideLoading();
      final body = json.decode(response);
      // lodaer = false;
      //         leaveListUpdated("PqtoOdpQ0SBVTMT0a15gnT7euR9x8fO6");
      //         update();
      if (body['status'] == 200){
        lodaer = false;
        acceptBookingPojo.value=acceptBookigPojoFromJson(response);
        CommonDialog.showsnackbar(acceptBookingPojo.value.message);
        getUpdatedBookingList();
        update();
      }else{
        CommonDialog.showsnackbar("Please try again,or contact to kolacut admin");
      }
      update();

    } catch (error) {
      print(error);
      // CommonDialog.hideLoading();
    }
  }

  void filterStatus(selectedDate) {
    if (selectedDate == "All") {
      element = bookingPojo.value.slotDetail!;
      update();
    } else {
      var newlist = bookingPojo.value.slotDetail!
          .where((x) => x.status
          .toString()
          .toLowerCase()
          .contains(selectedDate.toLowerCase()))
          .toList();
      element = newlist;
      update();
    }

    update();
    print("here pring ${selectedDate}");
  }

  void getUpdatedBookingList() async {
    lodaer = false;
    update();
    Map map;
    map = {"session_id":sessionId.value};
    //map = {"session_id": "TXKe48DXicKoAjkyEOgXWqU3VuVZqdHm"};
    print("API HIT HIT HIT HIT");
    try {
      //CommonDialog.showLoading(title: "Please waitt...");
      final response = await APICall().registerUrse(map, AppConstant.GET_ALL_BOOKING);
      print(response);
      // Navigator.pop(context);
      if (bookingPojo.value.message == "No Data found") {
        //   print(response);

        CommonDialog.showsnackbar("No Data found");
      } else {
        bookingPojo.value.slotDetail!.clear();
        update();
        bookingPojo.value = allBookingPojoFromJson(response);
        if(bookingPojo.value.slotDetail!.isNotEmpty){
          element=bookingPojo.value.slotDetail!;
        }
        update();
        lodaer = false;
      }
    } catch (error) {
      print(error);

    }
  }
  void getChart() async {
    Map map;
    try {
     // CommonDialog.showLoading(title: "Please waitt...");
      final response =
      await APICall().registerUrseWithoutbody("public/api/get-data");
      print(response);
      CommonDialog.hideLoading();
      if (response != "null") {
        // print("CODE IS RUNNING HERE");
        graphPojo.value = graphpojjoFromJson(response);
        update();
      //  lodaer = false;
      } else {
        print("CODE IS RUNNING HERE");

      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      CommonDialog.hideLoading();
    }
  }

  void getBookingList(_testValue) async {
    Map map;
    map = {"session_id": _testValue};
    //map = {"session_id": "TXKe48DXicKoAjkyEOgXWqU3VuVZqdHm"};
    print("API HIT HIT HIT HIT");
    try {
      CommonDialog.showLoading(title: "Please waitt...");
      final response = await APICall().registerUrse(map, AppConstant.GET_ALL_BOOKING);
      print(response);
      if (bookingPojo.value.message == "No Data found") {
        //   print(response);
        CommonDialog.hideLoading();
        CommonDialog.showsnackbar("No Data found");
      } else {
        CommonDialog.hideLoading();
        bookingPojo.value = allBookingPojoFromJson(response);
        if(bookingPojo.value.slotDetail!.isNotEmpty){
          element=bookingPojo.value.slotDetail!;
        }
        update();
        lodaer = false;
      }
    } catch (error) {
      print(error);
      CommonDialog.hideLoading();
    }
  }
}
