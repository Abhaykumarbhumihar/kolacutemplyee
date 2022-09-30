import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/profile_controller.dart';
import '../utils/Utils.dart';
import 'sidenavigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _HomePageState();
}

class _HomePageState extends State<ProfilePage> {
  ProfileController profileController = Get.put(ProfileController());
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  var name = "";
  var email="";
  var phone="";
  var iamge="";
  late SharedPreferences sharedPreferences;
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
        email=emailValue!;
        phone=_phoneValue!;
        iamge=_imageValue!;
      });
      // will be null if never previously saved
     // print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        width: width,
        height: height,

        child: Scaffold(
            resizeToAvoidBottomInset: true,
            key: scaffolKey,
            drawer:    SideNavigatinPage("${name}", "${iamge}", "${email}", "${phone}"),
            appBar: AppBar(
              centerTitle: false,
              elevation: 0.0,
              backgroundColor: Color(Utils.hexStringToHexInt('4285F4')),
              leading: InkWell(
                onTap: (){
                  scaffolKey.currentState!.openDrawer();

                },
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              titleSpacing: 0,
              title: Text(
                'Profile',
                style: TextStyle(
                    fontFamily: 'Poppins Regular',
                    color: Colors.white,
                    fontSize: width * 0.04),
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: width * 0.01),
                  child: SvgPicture.asset(
                    "images/svgicons/dissabledisco.svg",
                  ),
                )
              ],
            ),
            backgroundColor: Colors.white,
            body: GetBuilder<ProfileController>(builder: (profileController) {
              if (profileController.lodaer) {
                return Container();
              } else {
                return SizedBox(
                  width: width,
                  height: height,
                  child:
                ListView(
                  children: <Widget>[
                    Stack(
                     //clipBehavior: Clip.antiAlias,
                      children: <Widget>[
                        Container(
                          width: width,
                          height: height * 0.5,
                          decoration:  BoxDecoration(
                              //color: Color(Utils.hexStringToHexInt('4285F4')),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'images/svgicons/fullbackpn.png'),
                                  fit: BoxFit.fill)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.07,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: width * 0.2 - width * 0.06,
                                  backgroundImage: NetworkImage(
                                    profileController.profilePojo.value.data!.image
                                        .toString() +
                                        "" !=
                                        ""
                                        ? profileController
                                        .profilePojo.value.data!.image
                                        .toString() +
                                        ""
                                        : "",
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: width * 0.06),
                                  child: Text(
                                    'Personal Details',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.03,
                                        fontFamily: 'Poppins Medium'),
                                  ),
                                ),

                              ],
                            ),
                            Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(left: width * 0.06),
                              child: SizedBox(
                                width: width * 0.09,
                                child: Divider(
                                  thickness: 3,
                                  color: Color(Utils.hexStringToHexInt('4285F4')),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(left: width * 0.06),
                              width: width,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Name',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt('A3A2A2')),
                                            fontFamily: 'Poppins Regular',
                                            fontSize: width * 0.03),
                                      ),
                                      SizedBox(
                                        width: width * 0.06,
                                      ),
                                      Text(
                                        profileController.profilePojo.value.data!.name
                                            .toString() +
                                            "" !=
                                            ""
                                            ? profileController
                                            .profilePojo.value.data!.name
                                            .toString() +
                                            ""
                                            : "N/A",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt('A3A2A2')),
                                            fontFamily: 'Poppins Regular',
                                            fontSize: width * 0.04),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Email',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt('A3A2A2')),
                                            fontFamily: 'Poppins Regular',
                                            fontSize: width * 0.03),
                                      ),
                                      SizedBox(
                                        width: width * 0.06,
                                      ),
                                      Text(
                                        profileController
                                            .profilePojo.value.data!.email
                                            .toString() +
                                            "" !=
                                            ""
                                            ? profileController
                                            .profilePojo.value.data!.email
                                            .toString() +
                                            ""
                                            : "N/A",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt('A3A2A2')),
                                            fontFamily: 'Poppins Regular',
                                            fontSize: width * 0.04),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Contact',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt('A3A2A2')),
                                            fontFamily: 'Poppins Regular',
                                            fontSize: width * 0.03),
                                      ),
                                      SizedBox(
                                        width: width * 0.04,
                                      ),
                                      Text(
                                        profileController
                                            .profilePojo.value.data!.phone
                                            .toString() +
                                            "" !=
                                            ""
                                            ? profileController
                                            .profilePojo.value.data!.phone
                                            .toString() +
                                            ""
                                            : "N/A",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt('A3A2A2')),
                                            fontFamily: 'Poppins Regular',
                                            fontSize: width * 0.04),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Skills',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(
                                                Utils.hexStringToHexInt('A3A2A2')),
                                            fontFamily: 'Poppins Regular',
                                            fontSize: width * 0.03),
                                      ),
                                      SizedBox(
                                        width: width * 0.06,
                                      ),
                                      SizedBox(
                                        width: width * 0.6,
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: profileController.profilePojo
                                                .value.data!.skills!.length,
                                            itemBuilder: (context, position) {
                                              return Text(
                                                "  . " +
                                                    profileController
                                                        .profilePojo
                                                        .value
                                                        .data!
                                                        .skills![position],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color(
                                                        Utils.hexStringToHexInt(
                                                            'A3A2A2')),
                                                    fontFamily: 'Poppins Regular',
                                                    fontSize: width * 0.04),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Divider(
                              thickness: 1,
                            ),

                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: width * 0.06),
                                  child: Text(
                                    'Customer Feedbacks',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.03,
                                        fontFamily: 'Poppins Medium'),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width * 0.06),
                              child: SizedBox(
                                width: width * 0.09,
                                child: Divider(
                                  thickness: 3,
                                  color: Color(Utils.hexStringToHexInt('4285F4')),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            ConstrainedBox(constraints: BoxConstraints(
                              minHeight: 0.2,
                              maxHeight: height * 0.5,
                            ),
                            child: ListView.builder(
                              itemCount: profileController.feedbackPojo.value.ratingDetail!.length,

                              itemBuilder: (context,position){
                              return Container(
                                margin: EdgeInsets.only(
                                    left: width * 0.06, right: width * 0.03),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${profileController.feedbackPojo.value.ratingDetail![position].user_name}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: width * 0.03,
                                          fontFamily: 'Poppins Medium'),
                                    ),

                                    Row(
                                      children: <Widget>[
                                        RatingBarIndicator(
                                          rating: double.parse( "${profileController.feedbackPojo.value.ratingDetail![position].rating}",
                                          ),
                                          itemBuilder: (context, index) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: width * 0.05,
                                          direction: Axis.horizontal,
                                        ),
                                        Text(
                                          ' ${profileController.feedbackPojo.value.ratingDetail![position].date}',
                                          style: TextStyle(
                                              fontFamily: 'Poppins Regular',
                                              fontSize: width * 0.02,
                                              color: Color(
                                                  Utils.hexStringToHexInt('C4C4C4'))),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    AutoSizeText(
                                      "${profileController.feedbackPojo.value.ratingDetail![position].comment}",
                                      style: TextStyle(
                                          fontSize: width * 0.02,
                                          color:
                                          Color(Utils.hexStringToHexInt('#8D8D8D')),
                                          fontFamily: 'Poppins Light'),
                                      maxLines: 5,
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Divider(
                                      color: Color(Utils.hexStringToHexInt('C4C4C4')),
                                      thickness: 1,
                                    )
                                  ],
                                ),
                              );
                            },
                            ),

                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),

                          ],
                        ),
                        Container(width: width,
                        height: 10,
                       color: Color(Utils.hexStringToHexInt('4285F4')),
                        )
                      ],
                    )
                  ],
                )
                );
              }
            })),
      ),
    );
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
              Text(' Crossing Republick, Ghaziabad',
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
