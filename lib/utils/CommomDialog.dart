import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/applyleave.dart';
import 'Utils.dart';


class CommonDialog {
  static showErrorDialog(
      {String title = "Oops Error",
      String description = "Something went wrong "}) {
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline6,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static showBottomSheet() {
    Get.bottomSheet(ApplyLeave());
  }

  static showErrorDialog1(
  width,context,
      {String title = "Oops Error",
        String description = "Something went wrong "}) {
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     GestureDetector(
              //       onTap: () {
              //         if (Get.isDialogOpen!) Get.back();
              //
              //       },
              //       child: Container(
              //         margin: EdgeInsets.all(width * 0.06),
              //         child: IconButton(
              //           iconSize: 34,
              //           icon: Icon(
              //             Icons.close,
              //             color: Color(Utils.hexStringToHexInt('4285F4')),
              //           ),
              //           // the method which is called
              //           // when button is pressed
              //           onPressed: () {
              //             Navigator.pop(context);
              //
              //           },
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              Text(
                title,
                style:TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins Medium',
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              const SizedBox(
                height: 15,
              ),
              Flexible(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins Medium',
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }


  static showsnackbar(message) {
    Get.snackbar(
      "Kolacut Staff",
      message,
      icon: const Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static hideLoading() {

    Get.back();
  }

  static showLoading({String title = "Loading..."}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 40,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
