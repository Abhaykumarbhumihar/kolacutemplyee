import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static final String SESSION_ID = "Poppins BlackItalic";

  static hexStringToHexInt(String hex) {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }

  static Widget  applyLeavdd(data,width,height,hint){
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width*0.2-width*0.04,
          height: height*0.1-height*0.02,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              color: Color(Utils.hexStringToHexInt('8D8D8D'))
          ),
          child: Center(
            child: Text(
              data,
              style: TextStyle(color: Colors.white),

            ),
          ),
        ),
        Text(
         "$hint",
          style: TextStyle(
              fontFamily: 'Poppins Regular',
              color: Color(Utils.hexStringToHexInt('8D8D8D')),
              fontSize: width * 0.03),
        ),
      ],
    );
  }

  Widget titleText(text, context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins Regular',
          fontSize: MediaQuery.of(context).size.height * 0.03,
          color: Colors.black),
    );
  }

  Widget titleText1(text, context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins Regular',
          fontSize: MediaQuery.of(context).size.height * 0.02,
          color: Colors.black),
    );
  }

  Widget titleTextsemibold(text, context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins Semibold',
          fontSize: MediaQuery.of(context).size.height * 0.03,
          color: Colors.black),
    );
  }
}

