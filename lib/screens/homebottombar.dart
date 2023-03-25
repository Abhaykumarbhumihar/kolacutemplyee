import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../utils/Utils.dart';
import 'homepage.dart';
import 'profile.dart';
import 'yourbooking.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({Key key}) : super(key: key);

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  var index = 0;
  var image="";
   SharedPreferences sharedPreferences;

  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomePage(),

      TableBasicsExample(),

     // LoginPage(),

      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          index == 0 ? Icons.home : Icons.home_outlined,
          size: 30,
        ),
        activeColorPrimary: Color(Utils.hexStringToHexInt('4285F4')),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon:  Icon(
      index == 0 ? Icons.calendar_today_outlined : Icons.calendar_today_outlined,
      size: 30,
      ),
        activeColorPrimary: Color(Utils.hexStringToHexInt('4285F4')),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    //   PersistentBottomNavBarItem(
    // icon: Icon(
    // index == 0 ? Icons.home : Icons.home_outlined,
    // size: 30,
    // ),
    //     activeColorPrimary: Color(Utils.hexStringToHexInt('77ACA2')),
    //     inactiveColorPrimary: CupertinoColors.systemGrey,
    //   ),
      PersistentBottomNavBarItem(
        icon: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage:NetworkImage(image),
          radius: 30.0,
        ),
        activeColorPrimary: Color(Utils.hexStringToHexInt('4285F4')),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
  getImage()async{
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
     // var _testValue = sharedPreferences.getString("name");
     // var emailValue = sharedPreferences.getString("email");
      var _imageValue = sharedPreferences.getString("image");
    //  var _phoneValue = sharedPreferences.getString("phoneno");
     // var _sessss = sharedPreferences.getString("session");
      setState(() {
        if (_imageValue != null) {
          image = _imageValue;
        } else {
          image="";
        }

        //  print(name+" "+email+" "+phone+" "+_imageValue);
      });
      // will be null if never previously saved
      // print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notification();
  }


  notification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification.android;
      print(  message.data["we"]);
      print("54566565565656565556 ----UNONPE UNONPE ");
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title + "789",
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.transparent,
                playSound: true,
                icon: "mipmap/ic_launcher",
              ),
            ));
/*TODO-- pass rote here*/
        // _homepage = TwilioPhoneNumberInput();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification.android;
      print(  message.data["we"]);
      print(
          "UNONPE  UNONPE  UNONPE  UNONPE UNONPE UNONPE UNONPE ----UNONPE UNONPE ");
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title + "onMessageOpenedApp",
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.transparent,
                playSound: true,
                icon: "mipmap/ic_launcher",
              ),
            ));
/*TODO-- pass rote here*/
        // _homepage = TwilioPhoneNumberInput();
      } /*TODO-- pass rote here*/
      //  _homepage = TwilioPhoneNumberInput();
    });
  }

  @override
  Widget build(BuildContext context) {
    getImage();
    return PersistentTabView(
      context,
      controller: _controller,


      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,

      // Choose the nav bar style with this property.
      onItemSelected: (value) {
        setState(() {
          index = value;
        });

        debugPrint(value.toString() + "SDF SDF SDF SDF SDF $value");
      },
    );
  }
}
