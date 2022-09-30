import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/LeaveApplyPojo.dart';
import '../utils/CommomDialog.dart';
import '../utils/Utils.dart';
import '../controller/LeaveApplyController.dart';
import 'package:get/get.dart';

import 'sidenavigation.dart';

class TableBasicsExample extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  LeaveApplyController leaveapplyController = Get.put(LeaveApplyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  DateTime _stringToDateTimeObject(String dateString) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    return format.parse(dateString);
  }

  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  var name = "";
  var email = "";
  var phone = "";
  var iamge = "";
  late SharedPreferences sharedPreferences;
  var focuseddaate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var _testValue = sharedPreferences.getString("name");
      var emailValue = sharedPreferences.getString("email");
      var _imageValue = sharedPreferences.getString("image");
      var _phoneValue = sharedPreferences.getString("phoneno");
      setState(() {
        name = _testValue!;
        email = emailValue!;
        phone = _phoneValue!;
        iamge = _imageValue!;
      });
      // will be null if never previously saved
      //  print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
    final List<Color> colors = [
      Colors.pink,
      Colors.yellow,
      Colors.purpleAccent,
      Colors.orange,
      Colors.pink,
    ];

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: scaffolKey,
        drawer:
            SideNavigatinPage("${name}", "${iamge}", "${email}", "${phone}"),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              scaffolKey.currentState!.openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Leave Management',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins Medium',
                fontSize: width * 0.04),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            CommonDialog.showBottomSheet();
          },
        ),
        body: GetBuilder<LeaveApplyController>(builder: (leaveapplyController) {
          if (leaveapplyController.lodaer) {
            return Container();
          } else {
            List<Datum>? events = leaveapplyController.data;
            return Container(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:6.0,right: 6.0),
                      child: Center(
                        child: SizedBox(
                          width: width,
                          height: height * 0.4,
                          child: TableCalendar(
                            focusedDay: focuseddaate,
                            firstDay: DateTime(2022),
                            lastDay: DateTime(2060),
                            calendarStyle: CalendarStyle(
                                todayTextStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    color: Colors.white),
                                weekendTextStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                outsideTextStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                defaultTextStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03)),
                            selectedDayPredicate: (day) =>
                                isSameDay(day, focuseddaate),
                            headerStyle: HeaderStyle(
                                titleCentered: true,
                                titleTextFormatter: (date, locale) =>
                                    DateFormat.yMMM(locale).format(date),
                                formatButtonVisible: false,
                                titleTextStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05)),
                            shouldFillViewport: true,
                            onPageChanged: (DateTime date) {
                              setState(() {
                                focuseddaate = date;
                              });
                            },
                            onFormatChanged: (format) {
                              //
                            },
                            onDaySelected: (selectedTime, focusedTime) {
                              setState(() {
                                focuseddaate = selectedTime;
                              });
                              var mon = "";
                              var datee = "";
                              if (int.parse(selectedTime.month.toString()) >
                                  9) {
                                mon = selectedTime.month.toString();
                              } else {
                                mon = "0" + selectedTime.month.toString();
                              }

                              if (int.parse(selectedTime.day.toString()) > 9) {
                                datee = selectedTime.day.toString();
                              } else {
                                datee = "0" + selectedTime.day.toString();
                              }
                              var date = selectedTime.year.toString() +
                                  "-" +
                                  mon +
                                  "-" +
                                  datee;
                              //  print(date);
                              var newlist = leaveapplyController
                                  .leaveApplyPojo.value.data!
                                  .where((x) => x.calenderDate
                                      .toString()
                                      .toLowerCase()
                                      .contains(date))
                                  .toList();
                              print(newlist);
                              if(newlist.isNotEmpty){
                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child:
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minHeight: 0.2,
                                          maxHeight: height * 0.5,
                                        ),
                                        child: recentleavelistbottom(
                                            width, height, context, newlist),
                                      ),
                                    ),
                                  ),
                                 // barrierDismissible: false,
                                );
                              }else{
                                CommonDialog.showsnackbar("No data found for this date");
                              }


                            },
                            calendarBuilders: CalendarBuilders(
                              defaultBuilder: (ctx, day, focusedDay) {
                                int index = 0;
                                for (var leaveEvent = 0;
                                    leaveEvent < events!.length;
                                    leaveEvent++) {
                                  index++;
                                  final DateTime event =
                                      _stringToDateTimeObject(events[leaveEvent]
                                          .calenderDate
                                          .toString());
                                  if (day.day == event.day &&
                                      day.month == event.month &&
                                      day.year == event.year) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Material(
                                        elevation: 6.0,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                child: Center(
                                                  child: Text('${day.day}'),
                                                ),
                                              ),
                                              Container(
                                                width: 15,
                                                height: 6,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  color: events[leaveEvent]
                                                              .holidayType ==
                                                          "Fully off"
                                                      ? Colors.cyan
                                                      : Colors.orange,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(width * 0.03),
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Holidays',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: width * 0.03,
                                    fontFamily: 'Poppins Medium'),
                              ),
                              Text(
                                'List of holidays except weekly holidays',
                                style: TextStyle(
                                    color: Color(
                                        Utils.hexStringToHexInt('A3A2A2')),
                                    fontSize: width * 0.02,
                                    fontFamily: 'Poppins Medium'),
                              ),
                            ],
                          ),
                          PopupMenuButton(
                              child: Container(
                                margin: EdgeInsets.only(right: width * 0.01),
                                child: SvgPicture.asset(
                                  "images/svgicons/filtertext.svg",
                                ),
                              ),
                              icon: null,
                              // add this line
                              itemBuilder: (_) => <PopupMenuItem<String>>[
                                    PopupMenuItem<String>(
                                        child: Container(
                                            width: 100,
                                            // height: 30,
                                            child: const Text(
                                              "All",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                        value: 'All'),
                                    PopupMenuItem<String>(
                                        child: Container(
                                            width: 100,
                                            // height: 30,
                                            child: const Text(
                                              "Fully off",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                        value: 'Fully off'),
                                    PopupMenuItem<String>(
                                        child: Container(
                                            width: 100,
                                            // height: 30,
                                            child: const Text(
                                              "Partial off",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                        value: 'Partial off')
                                  ],
                              onSelected: (index) async {
                                print(index);
                                leaveapplyController.filterStatus(index);
                              }),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 0.2,
                        maxHeight: height * 0.5,
                      ),
                      child: recentleavelist(
                          width, height, context, leaveapplyController.data),
                    ),
                    const SizedBox(
                      height: 18,
                    )
                  ],
                ),
              ),
            );
          }
        }));
  }
  Widget recentleavelistbottom(width, height, contet, List<Datum>? data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data!.length,
        shrinkWrap: true,
        itemBuilder: (context, position) {
          return Container(
            margin: EdgeInsets.only(
                left: width * 0.04, right: width * 0.04, top: 2, bottom: 2),
            child: Material(
              borderRadius: BorderRadius.circular(4),
              elevation: 4,
              child: Container(
                padding: EdgeInsets.only(left: 4, right: 4, top: 6, bottom: 6),
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.004,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: width * 0.01),
                                  width: width * 0.2,
                                  height: height * 0.03,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(width * 0.01),
                                      color: data[position].holidayType ==
                                          "Fully off"
                                          ? Color(Utils.hexStringToHexInt(
                                          "#ecfafb"))
                                          : Colors.orange),
                                  child: Center(
                                    child: Text(
                                      '${data[position].holidayType.toString()}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.02),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.003,
                            ),
                            Text(
                              "${DateFormat.yMMMMd('en_US').format(DateTime.parse("${data[position].calenderDate}"))}",
                              style: TextStyle(
                                  fontSize: width * 0.02,
                                  color:
                                  Color(Utils.hexStringToHexInt('8D8D8D')),
                                  fontFamily: 'Poppins Regular'),
                            ),
                            SizedBox(
                              height: height * 0.003,
                            ),
                            Text(
                              ' ${data[position].holidayReason}',
                              style: TextStyle(
                                  fontSize: width * 0.03,
                                  color: Colors.black,
                                  fontFamily: 'Poppins Regular'),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.01,
                                fontFamily: 'Poppins Medium'),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: data[position].holidayType ==
                                      "Fully off"
                                      ? Container(
                                      width: width * 0.2 - width * 0.09,
                                      height: height * 0.02,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            width * 0.04),
                                        color: data[position].holidayType ==
                                            "Fully off"
                                            ? Colors.cyan
                                            : Colors.orange,
                                      ))
                                      : Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            width * 0.04),
                                        color: data[position].holidayType ==
                                            "Fully off"
                                            ? Colors.cyan
                                            : Colors.orange,
                                      )),
                                ),
                                // Container(
                                //   width: width * 0.2 - width * 0.09,
                                //   height: height * 0.02,
                                //   decoration: BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.circular(width * 0.04),
                                //       color: data![position].holidayType=="Fully off"?Colors.cyan:Colors.orange,)
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  Widget recentleavelist(width, height, contet, List<Datum>? data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data!.length,
        shrinkWrap: true,
        itemBuilder: (context, position) {
          return Container(
            margin: EdgeInsets.only(
                left: width * 0.04, right: width * 0.04, top: 2, bottom: 2),
            child: Material(
              borderRadius: BorderRadius.circular(4),
              elevation: 4,
              child: Container(
                padding: EdgeInsets.only(left: 4, right: 4, top: 6, bottom: 6),
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.004,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: width * 0.01),
                                  width: width * 0.2,
                                  height: height * 0.03,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.01),
                                      color: data[position].holidayType ==
                                              "Fully off"
                                          ? Color(Utils.hexStringToHexInt(
                                              "#ecfafb"))
                                          : Colors.orange),
                                  child: Center(
                                    child: Text(
                                      '${data[position].holidayType.toString()}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins Regular',
                                          fontSize: width * 0.02),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.003,
                            ),
                            Text(
                              "${DateFormat.yMMMMd('en_US').format(DateTime.parse("${data[position].calenderDate}"))}",
                              style: TextStyle(
                                  fontSize: width * 0.02,
                                  color:
                                      Color(Utils.hexStringToHexInt('8D8D8D')),
                                  fontFamily: 'Poppins Regular'),
                            ),
                            SizedBox(
                              height: height * 0.003,
                            ),
                            Text(
                              ' ${data[position].holidayReason}',
                              style: TextStyle(
                                  fontSize: width * 0.03,
                                  color: Colors.black,
                                  fontFamily: 'Poppins Regular'),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: width * 0.02),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${data[position].startFrom}-'
                                '${data[position].endFrom}  ',
                            style: TextStyle(
                                color: Color(
                                    Utils.hexStringToHexInt(
                                        '8D8D8D')),
                                fontFamily:
                                'Poppins Regular',
                                fontSize:
                                width *
                                    0.02),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: data[position].holidayType ==
                                          "Fully off"
                                      ? Container(
                                          width: width * 0.2 - width * 0.09,
                                          height: height * 0.02,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                width * 0.04),
                                            color: data[position].holidayType ==
                                                    "Fully off"
                                                ? Colors.cyan
                                                : Colors.orange,
                                          ))
                                      : Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                width * 0.04),
                                            color: data[position].holidayType ==
                                                    "Fully off"
                                                ? Colors.cyan
                                                : Colors.orange,
                                          )),
                                ),
                                // Container(
                                //   width: width * 0.2 - width * 0.09,
                                //   height: height * 0.02,
                                //   decoration: BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.circular(width * 0.04),
                                //       color: data![position].holidayType=="Fully off"?Colors.cyan:Colors.orange,)
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
