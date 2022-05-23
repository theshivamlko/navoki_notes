import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:navokinotes/utils/exceptions.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static double? deviceHeight;
  static double? deviceWidth;
  static String? loginToken;
  static String? userId;

  /// showToast at top of screen [msg]
  static void showToast(String msg) {
    showSimpleNotification(
        Align(
            alignment: Alignment.bottomCenter,
            child: Text(msg,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center)),
        background: Colors.grey[800]);
  }

  /// return a progress indicator with size [size]
  static material.Widget loadingView(double size) {
    return material.Theme(
      data: material.ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
      child: Center(
        child: SizedBox(
            width: size,
            height: size,
            child: const material.CircularProgressIndicator()),
      ),
    );
  }

  /// launch URL in browser [url]
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// parse Exceptions to message [e]
  static String getErrorMessage(Object e) {
    if (e.toString().isEmpty) return 'Unable To Connect';

    if (e is SocketException || e is TimeoutException) {
      return 'No Internet connectivity. Please try again!';
    } else if (e is HandshakeException) {
      return 'Unable To Connect';
    } else if (e is NoDataFound || e is IOException) {
      return 'No data found!';
    } else if (e.runtimeType.toString() == 'UserMessageException') {
      UserMessageException exception = e as UserMessageException;
      return exception.message;
    }

    return 'Something has gone wrong';
  }
}
