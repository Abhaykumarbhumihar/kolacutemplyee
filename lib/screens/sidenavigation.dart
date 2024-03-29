import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kolacut_employee/screens/profile.dart';


import 'package:shared_preferences/shared_preferences.dart';

import '../utils/Utils.dart';
import 'Coinpage.dart';
import 'TermconditiionPage.dart';
import 'applyleave.dart';
import 'graph.dart';
import 'login.dart';
import 'yourbooking.dart';

class SideNavigatinPage extends StatefulWidget {
  var s = "", s1 = "", s2 = "", s3 = "";

  SideNavigatinPage(String s, String s1, String s2, String s3, {Key key}) {
    this.s = s;
    this.s1 = s1;
    this.s2 = s2;
    this.s3 = s3;
  }

  @override
  State<SideNavigatinPage> createState() =>
      _SideNavigatinPageState(s, s1, s2, s3);
}

class _SideNavigatinPageState extends State<SideNavigatinPage> {
   SharedPreferences sharedPreferences;
  TextEditingController _textFieldControllerupdateAmenities =
  TextEditingController();
  _SideNavigatinPageState(String s, String s1, String s2, String s3);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(width * 0.06),
                  bottomRight: Radius.circular(width * 0.06),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                        width: width,
                        height: height * 0.3-height*0.09,
                        decoration: BoxDecoration(
                            color: Color(Utils.hexStringToHexInt('4285F4')),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(width * 0.06),
                              bottomRight: Radius.circular(width * 0.06),
                            )),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          print("SDFDSFDSDSF");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ProfilePage()),
                                          );
                                        },
                                        child: Container(
                                          margin:
                                          EdgeInsets.only(left: 6.0, right: 6.0),
                                          height: height * 0.1,
                                          child: Center(
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Center(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(10.0),
                                                      child: SizedBox.fromSize(
                                                        size: Size.fromRadius(35),
                                                        child: Image.network(
                                                          "${widget.s1}",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: 4.0,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "${widget.s}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: width * 0.04,
                                                        fontFamily: 'Poppins Regular',
                                                      ),
                                                    ),
                                                    Text(
                                                      "${widget.s2}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: width * 0.02,
                                                        fontFamily: 'Poppins Regular',
                                                      ),
                                                    ),
                                                    Text(
                                                      "${widget.s3}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: width * 0.02,
                                                        fontFamily: 'Poppins Regular',
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 8.0, left: 4.0),
                                                  child: Image.asset(
                                                    'images/svgicons/edit.png',
                                                    width: 12,
                                                    height: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    iconSize: 30,
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ListTile(
                          leading:  Icon(Icons.home,color:  Color(Utils.hexStringToHexInt('4285F4')),),
                          title: const Text(' Home '),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        ),
                        const Divider(
                          height: 1.0,
                          color: Colors.grey,
                        ),
                        ListTile(
                          leading:  Icon(Icons.calendar_today_outlined,color:  Color(Utils.hexStringToHexInt('4285F4')),),
                          title: const Text(' Leave '),
                          onTap: () async{
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TableBasicsExample()),
                            );
                          },
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        ),
                        const Divider(
                          height: 1.0,
                          color: Colors.grey,
                        ),
                        // ListTile(
                        //   leading:  Icon(CupertinoIcons.infinite,color: Color(Utils.hexStringToHexInt('4285F4')),),
                        //   title: const Text(' About '),
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(builder: (context) => MyCartList()),
                        //     // );
                        //   },
                        //   trailing: const Icon(Icons.keyboard_arrow_right),
                        // ),//flutter build apk --release --no-sound-null-safety
                        // const Divider(
                        //   height: 1.0,
                        //   color: Colors.grey,
                        // ),
                        ListTile(
                          leading: Icon(Icons.bar_chart_outlined, color: Color(Utils
                              .hexStringToHexInt('4285F4')),),
                          title: const Text(' Revenue '),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const Graph()),
                            );
                          },
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        ),
                        const Divider(
                          height: 1.0,
                          color: Colors.grey,
                        ),

                        ListTile(
                          leading: Icon(
                            Icons.share,
                            color:  Color(Utils.hexStringToHexInt('4285F4')),
                          ),
                          title: const Text(' Refer To Earm '),
                          // subtitle: const Text(
                          //     ' You will get 50 coin on first order of your firend '),
                          onTap: () async {
                            Navigator.pop(context);
                            // CommonDialog.showLoading(title: "Please wait");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CoinPage()),
                            );
                            // Map map = {
                            //   "session_id": box.read('session'),
                            // };
                            // print(map);
                            // var apiUrl = Uri.parse(
                            //     AppConstant.BASE_URL + AppConstant.REFER_TO_FRIEND);
                            // print(apiUrl);
                            // print(map);
                            // final response = await http.post(
                            //   apiUrl,
                            //   body: map,
                            // );
                            // print(response.body);
                            // var data = response.body;
                            // final body = json.decode(response.body);
                            // setState(() {
                            //   if (body['message'] != "") {
                            //     CommonDialog.showsnackbar(body['message'] +
                            //         "your code is \n" +
                            //         body['referel_code']);
                            //     showLoaderDialog(context, body['referel_code']);
                            //   }
                            // });

                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     var valueName = "";
                            //     var valuePrice = "";
                            //     return AlertDialog(
                            //       title: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: <Widget>[
                            //           const Text(
                            //             'Refer to your friend',
                            //             style: TextStyle(fontSize: 12.0),
                            //           ),
                            //           IconButton(
                            //             onPressed: () => Navigator.pop(context),
                            //             icon: Icon(Icons.cancel_outlined),
                            //           ),
                            //         ],
                            //       ),
                            //       content: Container(
                            //         width: 200,
                            //         child: SingleChildScrollView(
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.start,
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.center,
                            //             children: <Widget>[
                            //               SizedBox(
                            //                 height: height * 0.03,
                            //               ),
                            //               SizedBox(
                            //                 height: 10,
                            //               ),
                            //               FlatButton(
                            //                 color: Color(
                            //                     Utils.hexStringToHexInt('77ACA2')),
                            //                 textColor: Colors.white,
                            //                 child: Text('OK'),
                            //                 onPressed: () async {
                            //                   showLoaderDialog(context);
                            //                   // Map map = {
                            //                   //   "session_id": box.read('session'),
                            //                   // };
                            //                   // print(map);
                            //                   // var apiUrl = Uri.parse(
                            //                   //     AppConstant.BASE_URL +
                            //                   //         AppConstant.REFER_TO_FRIEND);
                            //                   // print(apiUrl);
                            //                   // print(map);
                            //                   // final response = await http.post(
                            //                   //   apiUrl,
                            //                   //   body: map,
                            //                   // );
                            //                   // print(response.body);
                            //                   // var data = response.body;
                            //                   // final body =
                            //                   //     json.decode(response.body);
                            //                   // CommonDialog.showsnackbar(
                            //                   //     body['message'] +
                            //                   //         "your code is \n" +
                            //                   //         body['referel_code']);
                            //                   // Navigator.pop(context);
                            //                   //
                            //                   // showLoaderDialog(context);
                            //                   // Share.share(
                            //                   //     'Intall this app and get benifits ${body['referel_code']}',
                            //                   //     subject: 'Kolacut!');
                            //                 },
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //       actions: <Widget>[],
                            //     );
                            //   },
                            // );
                            // Navigator.pop(context);
                          },
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        ),
                        const Divider(
                          height: 1.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 4.0),
                              width: width - width * 0.2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'V 1.2.3',
                                    style: TextStyle(
                                        fontFamily: 'Poppins Regular',
                                        fontSize: width * 0.04,
                                        color: Color(
                                            Utils.hexStringToHexInt('8D8D8D'))),
                                  ),
                                  InkWell(
                                    onTap: ()async{
                                      Navigator.pop(context);
                                      SharedPreferences prefrences = await SharedPreferences.getInstance();
                                      await prefrences.remove("session");
                                      Get.off(LoginPage());
                                    },
                                    child: SvgPicture.asset(
                                      "images/svgicons/logoutt.svg",
                                      width: width * 0.04,
                                      height: height * 0.04,
                                      fit: BoxFit.contain,
                                      color: Color(Utils.hexStringToHexInt('A3A2A2')),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Center(
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TermConditionPage()),
                                  );
                                },
                                child: Text(
                                  'Terms & Conditions',
                                  style: TextStyle(
                                      color: Color(Utils.hexStringToHexInt('4285F4')),
                                      fontFamily: 'Poppins Semibold',
                                      fontSize: width * 0.03),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.05)
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

