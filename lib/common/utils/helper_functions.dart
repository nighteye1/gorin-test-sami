import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelperFunctions {
  static Future<void> showLoadingDialog(
      BuildContext context, Color backgroundColor) async {
    return showDialog<void>(
      context: context,
      barrierColor: backgroundColor,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  static void showSnackBar(String title, BuildContext context,
      [int seconds = 4]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF010101),
        duration: Duration(seconds: seconds),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: Platform.isIOS
              ? MediaQuery.of(context).viewInsets.bottom
              : MediaQuery.of(context).viewInsets.bottom + 20,
          right: 20.w,
          left: 20.w,
        ),
        content: Text(
          title,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
