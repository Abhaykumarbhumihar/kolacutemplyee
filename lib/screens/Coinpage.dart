import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kolacut_employee/controller/BookingController.dart';
import 'package:kolacut_employee/screens/homepage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';
import 'package:swipebuttonflutter/swipebuttonflutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../utils/CommomDialog.dart';
import '../utils/Utils.dart';
import '../utils/appconstant.dart';
import 'login.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({Key key}) : super(key: key);

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  var inBedTime;
  var outBedTime;
   SharedPreferences sharedPreferences;
  var session;

  void _updateLabels(int init, int end, int c) {
    setState(() {
      inBedTime = init;
      outBedTime = end;
      debugPrint(inBedTime);
    });
  }

  Widget controlIndicator() {
    return SleekCircularSlider(
        min: 0,
        max: 100,
        initialValue: 4,
        innerWidget: (value) {
          return Container();
        },
        appearance: CircularSliderAppearance(
            spinnerMode: false,
            animationEnabled: true,
            size: 250,
            customColors: CustomSliderColors(
                shadowColor: Colors.white,
                shadowMaxOpacity: 0.2,
                shadowStep: 5,
                progressBarColor: Colors.cyan,
                trackColor: Colors.grey),
            customWidths: CustomSliderWidths(
                trackWidth: 7, progressBarWidth: 12, handlerSize: 8)),
        onChange: (value) {
          // slider_value = value.round();
          print(value);
        });
  }

  var isLoading=true;
  Future<void> start() async {
   // foo();
  }

  void foo() {
    Future.delayed(Duration(seconds: 3), () async {
      // do something here
      isLoading=false;
      // do stuff
    });
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // SharedPreferences.getInstance().then((SharedPreferences sp) {
    //   sharedPreferences = sp;
    //
    //   var _session = sharedPreferences.getString('session');
    //   setState(() {
    //
    //     session=_session!;
    //   });
    //   // will be null if never previously saved
    //    print("SDFKLDFKDKLFKDLFKLDFKL  " + "${session}");
    // });

    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(Utils.hexStringToHexInt('#fcfcfc')),
            appBar: AppBar(
              backgroundColor: Color(Utils.hexStringToHexInt('#fcfcfc')),
              elevation: 0.0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              centerTitle: false,
              leading: GestureDetector(
                onTap: () {
                  Navigator.maybePop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Your Balance',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins Medium',
                    fontSize: width * 0.04),
              ),
            ),
            body:  GetBuilder<BookingController>(builder: (homecontroller) {
              if (homecontroller.lodaer) {
                return Container();
              } else {
                return Container(
                  width: width,
                  color: Color(Utils.hexStringToHexInt('#fcfcfc')),
                  height: height,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: width * 0.03, right: width * 0.03),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            'Available Balance',
                            style: TextStyle(
                                fontFamily: 'Poppins Regular',
                                fontSize: width * 0.03,
                                color: Color(
                                    Utils.hexStringToHexInt('C4C4C4'))),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'images/svgicons/coin.png',
                                width: width * 0.05,
                                height: height * 0.04,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                ' ${homecontroller.coinPojo.value.coin}',

                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins Medium',
                                    fontSize: width * 0.05),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              CommonDialog.showErrorDialog1(
                                width, context, title: "Coins Detail",
                                  description:
                                  "You have earn coin with app refer, you can use only 100 coin at a time.");
                            },
                            child: Text(
                              ' View Details',
                              style: TextStyle(
                                  fontFamily: 'Poppins Medium',
                                  fontSize: width * 0.03,
                                  color: Color(
                                      Utils.hexStringToHexInt('4285F4'))),
                            ),
                          ),

                          Center(
                            child: SizedBox(
                                width: width*0.7,
                                child: Center(child: _getRadialGauge(homecontroller.coinPojo.value.coin))),
                          ),


                          SizedBox(
                            height: height * 0.03,
                          ),

                          Center(
                            child: SwipingButton(
                              height: height * 0.06,
                              iconColor: Color(
                                  Utils.hexStringToHexInt('4285F4')),
                              swipeButtonColor: Colors.white,
                              backgroundColor: Color(
                                  Utils.hexStringToHexInt('4285F4')),
                              buttonTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins Medium',
                                  fontSize: width * 0.03),
                              text: "Want to earn more coins?",
                              onSwipeCallback: () async {
                                print("Called back");
                                Map map = {
                                  "session_id": homecontroller.sessionId.value,
                                };
                                print(map);
                                var apiUrl = Uri.parse(
                                    AppConstant.BASE_URL +
                                        "public/api/employee-refer");
                                print(apiUrl);
                                print(map);
                                final response = await http.post(
                                  apiUrl,
                                  body: map,
                                );
                                print(response.body);
                                var data = response.body;
                                final body = json.decode(response.body);
                                if (body['message'] != "") {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CoinPage()),
                                  );
                                  showLoaderDialog(
                                      context, body['referel_code']);
                                }
                              },
                            ),
                          ),

                          SizedBox(
                            height: height * 0.02,
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }
            })));
  }


  Widget _getRadialGauge(value) {
    return SfRadialGauge(
        title: GaugeTitle(
            text: '',
            textStyle:
            const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 1000, ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 1000,
                color: Color(Utils.hexStringToHexInt('77ACA2')),
                startWidth: 10,
                endWidth: 10),
            // GaugeRange(
            //     startValue: 50,
            //     endValue: 100,
            //     color: Colors.orange,
            //     startWidth: 10,
            //     endWidth: 10),
            // GaugeRange(
            //     startValue: 100,
            //     endValue: 150,
            //     color: Colors.red,
            //     startWidth: 10,
            //     endWidth: 10)
          ], pointers: <GaugePointer>[
            NeedlePointer(
                value: double.parse(value.toString()),
                needleLength: 0.65,
                enableAnimation: true,
                animationType: AnimationType.slowMiddle,
                needleStartWidth: 1.5,
                needleEndWidth: 8,
                needleColor: Colors.red.shade300,
                knobStyle: KnobStyle(knobRadius: 0.09,borderColor: Colors.red))
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    child:  Text('${value}',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
                angle: 90,
                positionFactor: 0.5)
          ])
        ]);
  }

  showLoaderDialog1(BuildContext context, code) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5 - height * 0.05,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.04)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomePage()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(width * 0.06),
                        child: SvgPicture.asset(
                            'images/svgicons/eva_close-circle-fill.svg'),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: width * 0.03),
                  child: Center(
                    child: Text(
                      'Refer and Earn.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins Medium',
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: width * 0.01),
                  child: Text(
                    'Invite your friends using your referral\ncode givn below and earn more\ncoins',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins Regular',
                        fontSize: MediaQuery.of(context).size.width * 0.03),
                  ),
                ),
                Center(
                  child: Container(
                    width: width,
                    height: height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: width - width * 0.5,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12.0),
                            ),
                            border: Border.all(
                              color: Color(Utils.hexStringToHexInt('4285F4')),

                              //                   <--- border color
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "$code",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins Medium'),
                            ),
                          ),
                        ),
                        Container(
                          width: 78,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Color(Utils.hexStringToHexInt('4285F4')),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12.0),
                            ),
                            border: Border.all(
                              color: Color(Utils.hexStringToHexInt('4285F4')),

                              //                   <--- border color
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: "$code"));
                              },
                              child: Text(
                                "COPY",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins Medium'),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('OR'),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                    iconSize: 34,
                    icon: Icon(
                      Icons.share,
                      color: Color(Utils.hexStringToHexInt('4285F4')),
                    ),
                    // the method which is called
                    // when button is pressed
                    onPressed: () {
                      // Navigator.pop(context);
                      Share.share('Intall this app and get benifits $code',
                          subject: 'Kolacut!');
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLoaderDialog(BuildContext context, code) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width,
              height: height*0.6,

              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.04)),
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);

                                },
                                child: Container(
                                  margin: EdgeInsets.all(width * 0.06),
                                  child: IconButton(
                                    iconSize: 34,
                                    icon: Icon(
                                      Icons.close,
                                      color: Color(Utils.hexStringToHexInt('4285F4')),
                                    ),
                                    // the method which is called
                                    // when button is pressed
                                    onPressed: () {
                                      Navigator.pop(context);

                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: width * 0.03),
                            child: Center(
                              child: Text(
                                'Refer and Earn.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins Medium',
                                    fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: width * 0.01),
                            child: Text(
                              'Invite your friends using your referral\ncode givn below and earn more\ncoins',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins Regular',
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.03),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: width,
                              height: height * 0.1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: width - width * 0.5,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12.0),
                                      ),
                                      border: Border.all(
                                        color: Color(
                                            Utils.hexStringToHexInt('4285F4')),

                                        //                   <--- border color
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "$code",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins Medium'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 78,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color:
                                      Color(Utils.hexStringToHexInt('4285F4')),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12.0),
                                      ),
                                      border: Border.all(
                                        color: Color(
                                            Utils.hexStringToHexInt('4285F4')),

                                        //                   <--- border color
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          Clipboard.setData(
                                              ClipboardData(text: "$code"));
                                        },
                                        child: Text(
                                          "COPY",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins Medium'),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12, right: 12),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('OR'),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: IconButton(
                              iconSize: 34,
                              icon: Icon(
                                Icons.share,
                                color: Color(Utils.hexStringToHexInt('4285F4')),
                              ),
                              // the method which is called
                              // when button is pressed
                              onPressed: () {
                                // Navigator.pop(context);
                                Share.share(
                                    'Intall this app and get benifits $code',
                                    subject: 'Kolacut!');
                              },
                            ),
                          ),

                          Text(
                            'How it work?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins Medium',
                                fontSize: MediaQuery.of(context).size.width * 0.04),
                          ),
                          Row(
                            children: <Widget>[

                              Center(
                                child: IconButton(
                                  iconSize: 34,
                                  icon: Icon(
                                    Icons.share,
                                    color: Color(Utils.hexStringToHexInt('4285F4')),
                                  ),
                                  // the method which is called
                                  // when button is pressed
                                  onPressed: () {
                                    // Navigator.pop(context);

                                  },
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  'Share the referral link with your friends and family.',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins Medium',
                                      fontSize: MediaQuery.of(context).size.width * 0.04),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[

                              Center(
                                child: IconButton(
                                  iconSize: 34,
                                  icon: Icon(
                                    Icons.account_circle_rounded,
                                    color: Color(Utils.hexStringToHexInt('4285F4')),
                                  ),
                                  // the method which is called
                                  // when button is pressed
                                  onPressed: () {
                                    // Navigator.pop(context);

                                  },
                                ),
                              ),

                              Flexible(
                                child: Text(
                                  'Your friend sign up with the same link',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins Medium',
                                      fontSize: MediaQuery.of(context).size.width * 0.04),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Center(
                                child: IconButton(
                                  iconSize: 34,
                                  icon: Icon(
                                    Icons.card_giftcard_outlined,
                                    color: Color(Utils.hexStringToHexInt('4285F4')),
                                  ),
                                  // the method which is called
                                  // when button is pressed
                                  onPressed: () {
                                    // Navigator.pop(context);
                                  },
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  'Your friend gets 500 coins on sign up. you get 500 coins after completion of service within 30 days.'
                                      'You can earn upto 500 coins which will be converted into rupees',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins Medium',
                                      fontSize: MediaQuery.of(context).size.width * 0.04),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
