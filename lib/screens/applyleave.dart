import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/LeaveApplyController.dart';
import '../utils/CommomDialog.dart';
import '../utils/Utils.dart';

class ApplyLeave extends StatefulWidget {
  const ApplyLeave({Key key}) : super(key: key);

  @override
  State<ApplyLeave> createState() => _ApplyLeaveState();
}

class FruitsList {
  String name;
  int index;

  FruitsList({ this.name,  this.index});
}

class _ApplyLeaveState extends State<ApplyLeave> {
  LeaveApplyController leaveapplyController = Get.put(LeaveApplyController());
   SharedPreferences sharedPreferences;
  bool holidaytype = false;
  bool _value = false;
  int val = -1;

  // Default Radio Button Item
  String radioItem = 'Partial off';
  String holidayItem = 'Weekend';

  // Group Value for Radio Button.
  int id = 1;
  int holidayid = 1;
  TimeOfDay openingTime = TimeOfDay.now();
  TimeOfDay closingTime = TimeOfDay.now();
  var opent = "";
  var opentimeformat = "";
  var closetimeformat = "";
  var closet = "";
  List<FruitsList> typeofHolidayList = [
    FruitsList(
      index: 1,
      name: "Partial off ",
    ),
    FruitsList(
      index: 2,
      name: "Fully off",
    ),
  ];

  List<FruitsList> reasonOfHoliday = [
    FruitsList(
      index: 1,
      name: "Weekend ",
    ),
    FruitsList(
      index: 2,
      name: "National Holiday",
    ),
    FruitsList(
      index: 3,
      name: "Festival",
    ),
    FruitsList(
      index: 4,
      name: "Lockdown",
    ),
    FruitsList(
      index: 5,
      name: "Other",
    ),
  ];
  var datee = "";
  var monthh = "";
  var yee = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime tempDate = DateFormat("hh:mm").parse(
        openingTime.hour.toString() + ":" + openingTime.minute.toString());
    var dateFormat = DateFormat("hh:mm"); // you can change the format here
    print(dateFormat.format(tempDate));
    opentimeformat = dateFormat.format(tempDate);

    DateTime tempDatee = DateFormat("hh:mm").parse(
        closingTime.hour.toString() + ":" + closingTime.minute.toString());
    var dateFormattt = DateFormat("hh:mm"); // you can change the format here
    print(dateFormattt.format(tempDatee));
    closetimeformat = dateFormattt.format(tempDatee);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: width * 0.06, top: 6.0),
                child: Text(
                  'Add a date',
                  style: TextStyle(
                      fontFamily: 'Poppins Regular',
                      color: Color(Utils.hexStringToHexInt('8D8D8D')),
                      fontSize: width * 0.04),
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              InkWell(
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2025),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      setState(() {
                        datee = DateFormat('dd').format(selectedDate);
                        monthh = DateFormat('MM').format(selectedDate);
                        yee = DateFormat('yyyy').format(selectedDate);
                        print("${yee}-${monthh}-${datee}");
                      });
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: width * 0.05),
                  child: Row(
                    children: <Widget>[
                      Utils.applyLeavdd(datee, width, height, "dd"),
                      SizedBox(
                        width: 3.0,
                      ),
                      Utils.applyLeavdd(monthh, width, height, "MM"),
                      SizedBox(
                        width: 3.0,
                      ),
                      Utils.applyLeavdd(yee, width, height, "yyyy"),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: width * 0.06, top: 8.0),
                child: Text(
                  'Type of Holiday ',
                  style: TextStyle(
                      fontFamily: 'Poppins Regular',
                      color: Color(Utils.hexStringToHexInt('8D8D8D')),
                      fontSize: width * 0.04),
                ),
              ),
              Container(
                height: height * 0.1,
                width: width,
                child: Row(
                  children: typeofHolidayList
                      .map((data) => Expanded(
                            child: RadioListTile(
                              title: Text(
                                "${data.name}",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('8D8D8D')),
                                    fontSize: width * 0.03),
                              ),
                              groupValue: id,
                              value: data.index,
                              onChanged: (val) {
                                setState(() {
                                  radioItem = data.name;
                                  id = data.index;
                                });
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: width * 0.06, top: 8.0),
                child: Text(
                  'Store Operational Hours for Partial off ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'Poppins Regular',
                      color: Color(Utils.hexStringToHexInt('8D8D8D')),
                      fontSize: width * 0.04),
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: width * 0.06, right: width * 0.02),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(width * 0.003),
                            alignment: Alignment.center,
                            width: width * 0.1 + width * 0.06,
                            height: height * 0.05,
                            margin: EdgeInsets.only(right: width * 0.01),
                            decoration: BoxDecoration(
                                color: Color(Utils.hexStringToHexInt('E5E5E5')),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              // "${openingTime.hour}:${openingTime.minute}",
                              "${opentimeformat}",
                              style: TextStyle(
                                  fontSize: width * 0.02,
                                  color: Colors.black,
                                  fontFamily: 'Poppins Regular'),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'AM',
                              style: TextStyle(
                                  color: openingTime.period
                                              .toString()
                                              .split('.')[1] ==
                                          "am"
                                      ? Color(Utils.hexStringToHexInt('46D0D9'))
                                      : Colors.black,
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.02),
                            ),
                            Text(
                              'PM',
                              style: TextStyle(
                                  color: openingTime.period
                                              .toString()
                                              .split('.')[1] ==
                                          "pm"
                                      ? Colors.blueAccent
                                      : Colors.black,
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.02),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width * 0.1,
                    height: height * 0.02,
                    child: Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.02),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _closingTime(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(width * 0.003),
                            alignment: Alignment.center,
                            width: width * 0.1 + width * 0.06,
                            height: height * 0.05,
                            margin: EdgeInsets.only(right: width * 0.01),
                            decoration: BoxDecoration(
                                color: Color(Utils.hexStringToHexInt('E5E5E5')),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              "$closetimeformat",
                              style: TextStyle(
                                  fontSize: width * 0.02,
                                  color: Colors.black,
                                  fontFamily: 'Poppins Regular'),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'AM',
                              style: TextStyle(
                                  color: closingTime.period
                                              .toString()
                                              .split('.')[1] ==
                                          "am"
                                      ? Color(Utils.hexStringToHexInt('46D0D9'))
                                      : Colors.black,
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.02),
                            ),
                            Text(
                              'PM',
                              style: TextStyle(
                                  color: closingTime.period
                                              .toString()
                                              .split('.')[1] ==
                                          "pm"
                                      ? Colors.blueAccent
                                      : Colors.black,
                                  fontFamily: 'Poppins Regular',
                                  fontSize: width * 0.02),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: width * 0.08, top: 8.0),
                child: Text(
                  'Reason of the Holiday  ',
                  style: TextStyle(
                      fontFamily: 'Poppins Regular',
                      color: Color(Utils.hexStringToHexInt('8D8D8D')),
                      fontSize: width * 0.04),
                ),
              ),
              Container(
                height: height * 0.3,
                child: Column(
                  children: reasonOfHoliday
                      .map((data) => Expanded(
                            child: RadioListTile(
                              title: Text(
                                "${data.name}",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('8D8D8D')),
                                    fontSize: width * 0.03),
                              ),
                              groupValue: holidayid,
                              value: data.index,
                              onChanged: (val) {
                                setState(() {
                                  holidayItem = data.name;
                                  holidayid = data.index;
                                });
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  applyLeave();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.4,
                      height: height * 0.1 - height * 0.02,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.05),
                          color: Color(Utils.hexStringToHexInt('4285F4'))),
                      child: Center(
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins Semibold',
                              fontSize: width * 0.04),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    ));
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: openingTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != openingTime) {
      setState(() {
        openingTime = timeOfDay;
        DateTime tempDate = DateFormat("hh:mm").parse(
            openingTime.hour.toString() + ":" + openingTime.minute.toString());
        var dateFormat = DateFormat("hh:mm"); // you can change the format here
        print(dateFormat.format(tempDate));
        opentimeformat = dateFormat.format(tempDate);
        opent =
            "${openingTime.hour}:${openingTime.minute}:${openingTime.period.toString().split('.')[1].toString()}";
      });
    }
  }

  _closingTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != closingTime) {
      setState(() {
        closingTime = timeOfDay;
        DateTime tempDatee = DateFormat("hh:mm").parse(
            closingTime.hour.toString() + ":" + closingTime.minute.toString());
        var dateFormattt =
            DateFormat("hh:mm"); // you can change the format here
        print(dateFormattt.format(tempDatee));
        closetimeformat = dateFormattt.format(tempDatee);
        closet =
            "${closingTime.hour}:${closingTime.minute}:${closingTime.period.toString().split('.')[1].toString()}";
      });
    }
  }

//leaveapplyController.leaveApplyPojo.value.data!.clear();
//                   leaveapplyController.leaveList("PqtoOdpQ0SBVTMT0a15gnT7euR9x8fO6");
  void applyLeave() {
    if (datee == "") {
      CommonDialog.showsnackbar("Please Enter dd mm yyyy");
    } else {
      var date = "${yee}-${monthh}-${datee}";

      // print(ddController.text.toString());
      // print(mmController.text.toString());
      // print(yyyyController.text.toString());
      // print(openingTime.toString());
      //
      // print(
      //     "${openingTime.hour}:${openingTime.minute}  ${openingTime.period.toString().split('.')[1]}");
      var start =
          "${openingTime.hour}:${openingTime.minute} ${openingTime.period.toString().split('.')[1]}";
      var close =
          "${closingTime.hour}:${closingTime.minute} ${closingTime.period.toString().split('.')[1].toString()}";
      // print(radioItem + "  " + id.toString());
//session_id, date, leavetype, starttime, endtime, reason
      // print(holidayItem + "  " + holidayid.toString());
      //"session_id": "PqtoOdpQ0SBVTMT0a15gnT7euR9x8fO6",
      print(radioItem);
      var sessio = "";
      SharedPreferences.getInstance().then((SharedPreferences sp) {
        sharedPreferences = sp;
        var _testValue = sharedPreferences.getString("session");
        // will be null if never previously saved
        setState(() {
          sessio = _testValue;
        });
        print("ABHAY ABHAY ABHYA ABHYA ABHAY  " + "${sessio}");
        leaveapplyController.applyLeave(
            _testValue, date, radioItem, start, close, holidayItem);
      });
    }
  }
}
