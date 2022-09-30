import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolacut_employee/controller/BookingController.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:kolacut_employee/utils/CommomDialog.dart';

import '../utils/Utils.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  BookingController bookingController = Get.put(BookingController());
  List<OrdinalSales> losAngeles = [];
  List<OrdinalSales> globalSalesData = [];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Revenue ',
                style: TextStyle(
                    fontFamily: 'Poppins Regular',
                    color: Colors.black,
                    fontSize: width * 0.04),
              ),
            ),
            body: GetBuilder<BookingController>(
              builder: (dashboardController) {
                if (dashboardController.lodaer) {
                  return Container();
                } else {
                  for (var i = 0;
                  i < dashboardController.graphPojo.value.data!.length;
                  i++)
                  {
                    dashboardController.graphPojo.value.data![i].completedOrder;
                    dashboardController.graphPojo.value.data![i].totalOrder;
                    globalSalesData.add(OrdinalSales(
                        dashboardController.graphPojo.value.data![i].Month!,
                        dashboardController
                            .graphPojo.value.data![i].totalOrder!));
                    losAngeles.add(OrdinalSales(
                        '${dashboardController.graphPojo.value.data![i].Month}',
                        dashboardController
                            .graphPojo.value.data![i].completedOrder!));
                    //OrdinalSales('JAIN',  dashboardController.graphPojo.value.data![i].completedOrder!);
                  }
                  return Container(
                    width: width,
                    height: height,
                    child:
                  SingleChildScrollView(
                    child:  Column(
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Center(
                          child: Text(
                            'Total Revenue ',
                            style: TextStyle(
                                fontFamily: 'Poppins Medium',
                                fontSize:
                                MediaQuery.of(context).size.height * 0.03,
                                color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text(
                            '₹ ${dashboardController.dashboardData.value.data![0].totalEarnings}',
                            style: TextStyle(
                                fontFamily: 'Poppins Medium',
                                fontSize:
                                MediaQuery.of(context).size.height * 0.03,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          elevation: 0,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 12, right: 12, top: 12, bottom: 12),
                            width: width,
                            height: height * 0.2,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(width * 0.04),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(Utils.hexStringToHexInt('#76cbfb')),
                                      Color(Utils.hexStringToHexInt('#3ac1ca')),
                                      Color(Utils.hexStringToHexInt('#47c3d4')),
                                    ])),
                            child: Container(
                              margin: EdgeInsets.only(left: 12, right: 12),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Order Received',
                                            style: TextStyle(
                                                fontFamily: 'Poppins Semibold',
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02 -
                                                    height * 0.003,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            '${dashboardController.dashboardData.value.data![0].orderReceved}',
                                            style: TextStyle(
                                                fontFamily: 'Poppins Semibold',
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02 -
                                                    height * 0.003,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Completed Orders ',
                                            style: TextStyle(
                                                fontFamily: 'Poppins Semibold',
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02 -
                                                    height * 0.003,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            '${dashboardController.dashboardData.value.data![0].completedOrder} ',
                                            style: TextStyle(
                                                fontFamily: 'Poppins Semibold',
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02 -
                                                    height * 0.003,
                                                color: Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Total Earnings ',
                                            style: TextStyle(
                                                fontFamily: 'Poppins Semibold',
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02 -
                                                    height * 0.003,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "₹ ${dashboardController.dashboardData.value.data![0].totalEarnings}",
                                            style: TextStyle(
                                                fontFamily: 'Poppins Semibold',
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02 -
                                                    height * 0.003,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Monthly Earnings ',
                                            style: TextStyle(
                                                fontFamily: 'Poppins Semibold',
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02 -
                                                    height * 0.003,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            '₹ ${dashboardController.dashboardData.value.data![0].orderReceved}',
                                            style: TextStyle(
                                                fontFamily: 'Poppins Semibold',
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02 -
                                                    height * 0.003,
                                                color: Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          height: 30,
                          margin: EdgeInsets.only(left: 6,right: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Container(
                                  width: 14,
                                  height: 14,
                                  color: Color(Utils.hexStringToHexInt('4285F4')),
                                ),
                                Text(" Completed  Orders  ",
                                  style: TextStyle(
                                    fontFamily: '',
                                    color:  Color(Utils.hexStringToHexInt('8D8D8D')),
                                  ),),
                                Container(
                                  width: 14,
                                  height: 14,
                                  color: Color(Utils.hexStringToHexInt('C4C4C4')),
                                ),
                                Text(" Total Orders  ",
                                  style: TextStyle(
                                    fontFamily: '',
                                    color:  Color(Utils.hexStringToHexInt('8D8D8D')),
                                  ),),
                              ],),
                              Container(
                                width: 70,
                                height: 30,
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      //textAlign: TextAlign.center,
                                        autocorrect: true,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.phone,
                                        onEditingComplete: () { print("editing complete"); },
                                        onSubmitted: (String value) { print("submitted\n$value");
                                        if(int.parse(value)<365){
                                          bookingController.getChart(value);
                                          FocusScope.of(context).unfocus();

                                        }else{
                                          CommonDialog.showsnackbar("You can get only one year data");
                                        }

                                        },
                                        maxLines: 1,
                                        decoration:
                                        InputDecoration(
                                          hintText: 'Enter here days',
                                          isCollapsed: false,
                                          isDense: false,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                          hintStyle: TextStyle(
                                              color:
                                              Color(Utils.hexStringToHexInt('A4A4A4')),
                                              fontFamily: 'Poppins Regular',
                                              fontSize: width * 0.03),
                                          border: OutlineInputBorder(),)

                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white70,
                          width: width,
                          height: height * 0.4,
                          child: charts.BarChart(
                            _createSampleData(),
                            animate: true,
                            //domainAxis: new charts.OrdinalAxisSpec(),
                            domainAxis: const charts.OrdinalAxisSpec(
                              renderSpec: charts.SmallTickRendererSpec(
                                  labelRotation: 60),
                            ),
                            animationDuration: Duration(seconds: 2),
                            flipVerticalAxis: false,
                            barGroupingType: charts.BarGroupingType.grouped,
                            // It is important when using both primary and secondary axes to choose
                            // the same number of ticks for both sides to get the gridlines to line
                            // up.
                            primaryMeasureAxis: const charts.NumericAxisSpec(
                                tickProviderSpec:
                                charts.BasicNumericTickProviderSpec(
                                    desiredTickCount: 5)),
                            secondaryMeasureAxis: const charts.NumericAxisSpec(
                                tickProviderSpec:
                                charts.BasicNumericTickProviderSpec(
                                    desiredTickCount: 5)),
                          ),
                        )
                      ],
                    ),
                  ),
                  );
                }
              },
            )));
  }

  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    losAngeles;

    globalSalesData;

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Los Angeles Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: losAngeles,
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId)
      // Set the 'Los Angeles Revenue' series to use the secondary measure axis.
      // All series that have this set will use the secondary measure axis.
      // All other series will use the primary measure axis.
    ];
  }

}


class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}