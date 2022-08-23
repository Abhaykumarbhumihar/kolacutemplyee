import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controller/LeaveApplyController.dart';
import '../model/LeaveApplyPojo.dart';
import '../model/LeaveModel.dart';

class MyData extends StatefulWidget {
  const MyData({Key? key}) : super(key: key);

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  LeaveApplyController leaveapplyController = Get.put(LeaveApplyController());

  DateTime _stringToDateTimeObject(String dateString) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    return format.parse(dateString);
  }

  @override
  Widget build(BuildContext context) {

    final List<Color> colors = [
      Colors.pink,
      Colors.yellow,
      Colors.purpleAccent,
      Colors.orange,
      Colors.pink,
    ];




    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Leaves Events'),
      ),
      body: GetBuilder<LeaveApplyController>(builder: (leaveapplyController) {
        if (leaveapplyController.lodaer) {
          return Container();
        } else {
          List<Datum>? events = leaveapplyController.leaveApplyPojo.value!.data;
          return
            Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: TableCalendar(

                focusedDay: DateTime.now(),
                firstDay: DateTime(2022),
                lastDay: DateTime(2060),
                onPageChanged: (DateTime date) {
                  //
                },
                onFormatChanged: (format) {
                  //
                },
                onDaySelected: (selectedTime, focusedTime) {
                  //
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (ctx, day, focusedDay) {
                    int index = 0;
                    for (var leaveEvent = 0;
                        leaveEvent < events!.length;
                        leaveEvent++) {
                      index++;
                      final DateTime event = _stringToDateTimeObject(
                          events[leaveEvent].calenderDate.toString());
                      if (day.day == event.day &&
                          day.month == event.month &&
                          day.year == event.year) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Material(
                            elevation: 6.0,
                            borderRadius: BorderRadius.circular(6.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                      borderRadius: BorderRadius.circular(6.0),
                                      color: events[leaveEvent].holidayType ==
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
          );
        }
      }),
    );
  }
}
