import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/BookingController.dart';
import '../model/AllBookingPojoo.dart';
import '../utils/Utils.dart';
import '../utils/appconstant.dart';
import 'allbooking.dart';
import 'sidenavigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BookingController bookingController = Get.put(BookingController());
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  var name = "";
  var email="";
  var phone="";
  var iamge="";
  late SharedPreferences sharedPreferences;
  var session="";


  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var _testValue = sharedPreferences.getString("name");
      var emailValue = sharedPreferences.getString("email");
      var _imageValue = sharedPreferences.getString("image");
      var _phoneValue = sharedPreferences.getString("phoneno");
      var _session = sharedPreferences.getString('session');
      setState(() {
        name = _testValue!;
        email=emailValue!;
        phone=_phoneValue!;
        iamge=_imageValue!;
        session=_session!;
      });
      // will be null if never previously saved
    //  print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
    List<SlotDetail> _element = [];
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        width: width,
        height: height,
        child: Scaffold(
          key: scaffolKey,
          drawer:
              SideNavigatinPage("${name}", "${iamge}", "${email}", "${phone}"),
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () {
                scaffolKey.currentState!.openDrawer();
              },
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                  Text("",
                      style: TextStyle(
                          fontSize: width * 0.03,
                          fontFamily: 'Poppins Regular',
                          color: Colors.black),
                      textAlign: TextAlign.center),

                ],
              ),


              PopupMenuButton(
                  child: Container(
                    margin: EdgeInsets.only(right: width * 0.01),
                    child: SvgPicture.asset(
                      "images/svgicons/filtersv.svg",
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
                              style: TextStyle(color: Colors.red),
                            )),
                        value: 'All'),
                    PopupMenuItem<String>(
                        child: Container(
                            width: 100,
                            // height: 30,
                            child: const Text(
                              "Accepted",
                              style: TextStyle(color: Colors.red),
                            )),
                        value: 'Accepted'),
                    PopupMenuItem<String>(
                        child: Container(
                            width: 100,
                            // height: 30,
                            child: const Text(
                              "Pending",
                              style: TextStyle(color: Colors.red),
                            )),
                        value: 'Pending')
                  ],
                  onSelected: (index) async {
                    print(index);
                    bookingController.filterStatus(index);
                  }),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: GetBuilder<BookingController>(builder: (bookingController) {
            if (bookingController.lodaer) {
              return Container();
            } else {
              for (var i = 0;
                  i < bookingController.element.length;
                  i++) {
                _element
                    .add(bookingController.element[i]);
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.03, top: height * 0.03),
                      child: Text(
                        'Hello ${name}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.04,
                            fontFamily: 'Poppins Regular'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.03),
                      child: Text(
                        'Today’s Update',
                        style: TextStyle(
                            color: Color(Utils.hexStringToHexInt('C4C4C4')),
                            fontSize: width * 0.02,
                            fontFamily: 'Poppins Regular'),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                          top: height * 0.03,
                          bottom: width * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            elevation: 12,
                            child: Container(
                              width: width * 0.4,
                              height: height * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.04),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(
                                            Utils.hexStringToHexInt('#76cbfb')),
                                        Color(
                                            Utils.hexStringToHexInt('#3ac1ca')),
                                        Color(
                                            Utils.hexStringToHexInt('#47c3d4')),
                                      ])),
                              child: Container(
                                margin: EdgeInsets.only(left: width * 0.03),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: height * 0.01,
                                      child: Text(
                                        '${bookingController.element.length}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins Semibold',
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Positioned(
                                      top: height * 0.06,
                                      child: Text(
                                        'Total Orders ',
                                        style: TextStyle(
                                            fontFamily: 'Poppins Semibold',
                                            fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02 -
                                                height * 0.003,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            elevation: 12,
                            child: Container(
                              width: width * 0.4,
                              height: height * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.04),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(
                                            Utils.hexStringToHexInt('#0c5eed')),
                                        Color(
                                            Utils.hexStringToHexInt('#306ed9')),
                                        Color(
                                            Utils.hexStringToHexInt('#3f6dbd')),
                                      ])),
                              child: Container(
                                margin: EdgeInsets.only(left: width * 0.03),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: height * 0.01,
                                      child: Text(
                                        '0',
                                        style: TextStyle(
                                            fontFamily: 'Poppins Semibold',
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Positioned(
                                      top: height * 0.06,
                                      child: Text(
                                        'Total Revenue ',
                                        style: TextStyle(
                                            fontFamily: 'Poppins Semibold',
                                            fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02 -
                                                height * 0.003,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: width * 0.03),
                      child: Text(
                        'Bookings',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.03,
                            fontFamily: 'Poppins Regular'),
                      ),
                    ),

                    SizedBox(
                      width: width,
                      height: height * 0.7,
                      child: StickyGroupedListView<SlotDetail, DateTime>(
                        elements: _element,
                        order: StickyGroupedListOrder.ASC,
                        groupBy: (SlotDetail element) => DateTime(
                          element.date!.year,
                          element.date!.month,
                          element.date!.day,
                        ),
                        groupComparator: (DateTime value1, DateTime value2) =>
                            value2.compareTo(value1),
                        itemComparator:
                            (SlotDetail element1, SlotDetail element2) =>
                                element1.date!.compareTo(element2.date!),
                        floatingHeader: false,
                        groupSeparatorBuilder: _getGroupSeparator,
                        itemBuilder: _getItem,
                      ),
                    ),

                    //  recentleavelist(width,height,context),

                    SizedBox(
                      height: height * 0.04,
                    )
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  Widget recentleavelist(width, height, contet) {
    return SizedBox(
      width: width,
      height: height * 0.5,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, position) {
            return Container(
              margin: EdgeInsets.only(
                  left: width * 0.04,
                  right: width * 0.04,
                  top: height * 0.03,
                  bottom: height * 0.03),
              child: Material(
                borderRadius: BorderRadius.circular(width * 0.04),
                elevation: 6,
                child: Container(
                  width: width,
                  height: height * 0.2 - height * 0.03,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.04),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color: Color(Utils.hexStringToHexInt(
                                            '#ecfafb'))),
                                    child: Center(
                                      child: Text(
                                        'Full day off',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt(
                                                    '4285F4')),
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
                                ' May 01, 2021',
                                style: TextStyle(
                                    fontSize: width * 0.02,
                                    color: Color(
                                        Utils.hexStringToHexInt('8D8D8D')),
                                    fontFamily: 'Poppins Regular'),
                              ),
                              SizedBox(
                                height: height * 0.003,
                              ),
                              Text(
                                ' Emergency at the house',
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
                                    width: width * 0.2 - width * 0.09,
                                    height: height * 0.02,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.04),
                                        color: Color(
                                            Utils.hexStringToHexInt('4285F4'))),
                                  )
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
          }),
    );
  }

  Widget _getItem(context, SlotDetail element) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    List<String> serviceName = [];
    element.service!.forEach((element) {
      serviceName.add(element.name.toString());
    });

    var finalgroupChatIdList = serviceName.join(",");

    return InkWell(
      onTap: () {
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            List<Service> tempArray = [];

            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Order detail of ${element.bookingId}",
                    style: TextStyle(
                        fontFamily: 'Poppins Regular',
                        color: Colors.black,
                        fontSize: width * 0.03),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                      ))
                ],
              ),
              content: StatefulBuilder(
                // You need this, notice the parameters below:
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                      width: width,
                      height: height * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                "${element.userName}",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "BookingID",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                "${element.bookingId}",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Booking Date",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                  "${element.date!.day}-${element.date!.month}-${element.date!.year}",
                                  style: TextStyle(
                                      fontFamily: 'Poppins Regular',
                                      color: Color(
                                          Utils.hexStringToHexInt('C4C4C4')),
                                      fontSize: width * 0.03)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Payment Mode",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                  "${element.payment_type == null ? "" : element.payment_type}",
                                  style: TextStyle(
                                      fontFamily: 'Poppins Regular',
                                      color: Color(
                                          Utils.hexStringToHexInt('C4C4C4')),
                                      fontSize: width * 0.03)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Transaction id",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text("${element.transaction_id}",
                                  style: TextStyle(
                                      fontFamily: 'Poppins Regular',
                                      color: Color(
                                          Utils.hexStringToHexInt('C4C4C4')),
                                      fontSize: width * 0.03)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Coupon Code",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                  "${element.coupon_code == null ? "N/A" : element.coupon_code}",
                                  style: TextStyle(
                                      fontFamily: 'Poppins Regular',
                                      color: Color(
                                          Utils.hexStringToHexInt('C4C4C4')),
                                      fontSize: width * 0.03)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Coin ",
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                  "${element.coin == null ? "N/A" : element.coin} (100 coins = ₹ 1)",
                                  style: TextStyle(
                                      fontFamily: 'Poppins Regular',
                                      color: Color(
                                          Utils.hexStringToHexInt('C4C4C4')),
                                      fontSize: width * 0.03)),
                            ],
                          ),
                          LimitedBox(
                            maxHeight: height * 0.3,
                            child: ListView.builder(
                                itemCount: element.service!.length,
                                itemBuilder: (context, position) {
                                  return Container(
                                    height: height * 0.03,
                                    margin: EdgeInsets.only(left: 4, right: 4),
                                    child: Container(
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${element.service![position].name}",
                                                style: TextStyle(fontSize: 8.0),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${element.service![position].price}",
                                            style: TextStyle(fontSize: 8.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ));
                },
              ),
            );
          },
        );
      },
      child: Container(
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: width * 0.03),
                  child: CircleAvatar(
                    radius: width * 0.07,
                    backgroundImage: NetworkImage("${element.userImage}"),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '${element.bookingId}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins Semibold',
                                    fontSize: width * 0.04),
                              ),
                              Container(
                                  width: 64,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'images/svgicons/tagbackpn.png',
                                          ),
                                          fit: BoxFit.fitHeight)),
                                  child: Container(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      '${element.status == "Accepted" ? "Accepted" : "In Progress"}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: width * 0.02,
                                          color: Colors.white,
                                          fontFamily: 'Poppins Regular'),
                                    ),
                                  ))
                            ],
                          ),
                          // Visibility(
                          //     visible:
                          //         element.status == "Accepted" ? false : true,
                          //     child: Container(
                          //       width: width * 0.2,
                          //       height: 28,
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(6.0),
                          //           color: Colors.cyan),
                          //       child: Center(
                          //         child: Text(
                          //           "Confirm",
                          //           style: TextStyle(
                          //               color: Colors.white, fontSize: 12),
                          //         ),
                          //       ),
                          //     ))

                          element.status == "Accepted"
                              ? InkWell(
                            onTap: () async {
                              // bookingController.acceptBooking(element.id);
                              Map map = {
                                "session_id":session,
                                "booking_id": element.id.toString()
                              };
                              print(map);
                              var apiUrl = Uri.parse(
                                  AppConstant.BASE_URL +
                                      AppConstant.COMPLETE_BOOKIND);
                              print(apiUrl);
                              print(map);
                              final response = await http.post(
                                apiUrl,
                                body: map,
                              );
                              print(response.body);
                              var data = response.body;
                              final body = json.decode(response.body);
                              if (body['message'] ==
                                  "Booking has been completed successfully.") {
                                setState(() {
                                  bookingController.element.clear();
                                  bookingController
                                      .bookingPojo.value.slotDetail!
                                      .clear();
                                  bookingController.getData();
                                });
                              }
                            },
                            child: Container(
                              width: width * 0.2,
                              height: 28,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(6.0),
                                  color: Colors.cyan),
                              child: const Center(
                                child: Text(
                                  "Complete",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          )
                              : element.status == "Pending"
                              ? InkWell(
                            onTap: () async {
                              //  bookingController.acceptBooking(element.id);
                              Map map = {
                                "session_id": session,
                                "booking_id": element.id.toString()
                              };
                              print(map);
                              var apiUrl = Uri.parse(
                                  AppConstant.BASE_URL +
                                      AppConstant.ACCEPT_BOOKING);
                              print(apiUrl);
                              print(map);
                              final response = await http.post(
                                apiUrl,
                                body: map,
                              );
                              print(response.body);
                              var data = response.body;
                              final body = json.decode(response.body);
                              if (body['message'] ==
                                  "Booking has been accepted successfully.") {
                                setState(() {
                                  bookingController.element!
                                      .clear();
                                  bookingController
                                      .bookingPojo.value.slotDetail!
                                      .clear();

                                  bookingController.getData();
                                });
                              }
                            },
                            child: Container(
                              width: width * 0.2,
                              height: 28,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(6.0),
                                  color: Colors.cyan),
                              child: Center(
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          )
                              : InkWell(
                            onTap: () async {
                              //  bookingController.acceptBooking(element.id);
                              // Map map = {
                              //   "session_id": box.read('session'),
                              //   "booking_id": element.id.toString()
                              // };
                              // print(map);
                              // var apiUrl = Uri.parse(AppConstant.BASE_URL +
                              //     AppConstant.ACCEPT_BOOKING);
                              // print(apiUrl);
                              // print(map);
                              // final response = await http.post(
                              //   apiUrl,
                              //   body: map,
                              // );
                              // print(response.body);
                              // var data = response.body;
                              // final body = json.decode(response.body);
                              // if (body['message'] ==
                              //     "Booking has been accepted successfully.") {
                              //   setState(() {
                              //     bookingController.slotDetail!.clear();
                              //     bookingController
                              //         .bookingPojo.value.slotDetail!
                              //         .clear();
                              //
                              //     bookingController.getBookingList();
                              //   });
                              // }
                            },
                            child: Container(
                              width: width * 0.2,
                              height: 28,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(6.0),
                                  color: Colors.cyan),
                              child: Center(
                                child: Text(
                                  "Rejected",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'Visit on 24 Jun, 10:00 AM',
                      style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          color: Color(Utils.hexStringToHexInt('C4C4C4')),
                          fontSize: width * 0.03),
                    ),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           'Services: ${finalgroupChatIdList}',
                    //           style: TextStyle(
                    //               fontFamily: 'Poppins Regular',
                    //               color: Color(Utils.hexStringToHexInt('C4C4C4')),
                    //               fontSize: width * 0.03),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //     child: Row(
                    //   children: <Widget>[
                    //     new AutoSizeText(
                    //       'Services: ${finalgroupChatIdList}',
                    //       style: TextStyle(
                    //           fontFamily: 'Poppins Regular',
                    //           color: Color(Utils.hexStringToHexInt('C4C4C4')),
                    //           fontSize: width * 0.03),
                    //     )
                    //   ],
                    // )),
                    // SizedBox(
                    //   width: width,
                    //   height: height*0.03,
                    //   child:  Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: <Widget>[
                    //         Container(
                    //           width: width * 0.7,
                    //           child: Expanded(
                    //             child:
                    //             Text(
                    //               'Services: ${finalgroupChatIdList}',
                    //               style: TextStyle(
                    //                   fontFamily: 'Poppins Regular',
                    //                   color: Color(
                    //                       Utils.hexStringToHexInt('C4C4C4')),
                    //                   fontSize: width * 0.03),
                    //             ),
                    //           ),
                    //         )
                    //       ]),
                    // )
                  ],
                )
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Widget _getGroupSeparator(SlotDetail element) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    DateFormat.yMMMMd('en_US').format(DateTime.parse("${element.date}"));
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: width * 0.06, top: 6, bottom: 6),
          //Tuesday, 23 Jun 2021(3)
          child: Text(
            element.bookingDay.toString() +
                " " +
                DateFormat.yMMMd('en_US')
                    .format(DateTime.parse("${element.date}")),
            style: TextStyle(
                color: Color(Utils.hexStringToHexInt('8D8D8D')),
                fontSize: width * 0.03,
                fontFamily: 'Poppins Regular'),
          ),
        )
      ],
    );
  }

  Widget bookinglist(width, height, context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: 3,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AllBooking()),
              );
            },
            child: Container(
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: width * 0.03),
                            child: CircleAvatar(
                              radius: width * 0.07,
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1597466765990-64ad1c35dafc"),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    '839176',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins Semibold',
                                        fontSize: width * 0.04),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                'images/svgicons/tagbackpn.png',
                                              ),
                                              fit: BoxFit.fitHeight)),
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.all(2.0),
                                          child: Text(
                                            'In Progress',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: width * 0.02,
                                                color: Colors.white,
                                                fontFamily: 'Poppins Regular'),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                              Text(
                                'Visit on 24 Jun, 10:00 AM',
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                'Visit on 24 Jun, 10:00 AM',
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '250',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.02,
                                fontFamily: 'Poppins Regular'),
                          ),
                          Text(
                            'View All',
                            style: TextStyle(
                                color: Color(Utils.hexStringToHexInt('4285F4')),
                                fontSize: width * 0.02,
                                fontFamily: 'Poppins Regular'),
                          ),
                          Container(
                            padding: EdgeInsets.all(width * 0.003),
                            alignment: Alignment.center,
                            width: width * 0.1 + width * 0.09,
                            height: height * 0.05,
                            margin: EdgeInsets.only(right: width * 0.01),
                            decoration: BoxDecoration(
                                color: Color(Utils.hexStringToHexInt('4285F4')),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              '8:00',
                              style: TextStyle(
                                  fontSize: width * 0.02,
                                  color: Colors.white,
                                  fontFamily: 'Poppins Regular'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          );
        });
  }

  AppBar appBarr(BuildContext context, width, height) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color(Utils.hexStringToHexInt('46D0D9')),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: height * 0.05),
            child: Text(' Crossing Republick, Ghaziabad',
                style: TextStyle(
                    fontSize: width * 0.03,
                    fontFamily: 'Poppins Regular',
                    color: Colors.black),
                textAlign: TextAlign.center),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width * 0.03,
                height: height * 0.03,
                child: SvgPicture.asset(
                  "images/svgicons/mappin.svg",
                ),
              ),
              Text(' Crossing ssRepublick, Ghaziabad',
                  style: TextStyle(
                      fontSize: width * 0.02,
                      fontFamily: 'Poppins Regular',
                      color: Colors.black),
                  textAlign: TextAlign.center),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: width * 0.05,
                  color: Colors.black,
                ),
                tooltip: 'Comment Icon',
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
      actions: <Widget>[
        //IconButton
        IconButton(
          iconSize: width * 0.07,
          icon: const Icon(
            CupertinoIcons.bell,
            color: Colors.blue,
          ),
          tooltip: 'Setting Icon',
          onPressed: () {},
        ), //IconButton
      ],
      //<Widget>[]

      elevation: 0.0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          tooltip: 'Menu Icon',
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      brightness: Brightness.dark,
    );
  }
}
