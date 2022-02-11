import 'package:flutter/material.dart' as material;

class AppConstants {
  static const String AppName = "NavokiNotes";

  // TODO: Replace your key here
  static const String API_KEY = "";

  static material.Color orangeColor = const material.Color(0xffff470b);
  static material.Color yellowColor = const material.Color(0xfffca10e);

  static List socialLinks = [
    {
      'name': 'youtube',
      "link":
          'https://www.youtube.com/channel/UCP2-MYtIbBnlEcfTvJKo5Og?sub_confirmation=1',
      'icon': 'assets/images/youtube.png'
    },
    {
      'name': 'github',
      "link": 'https://www.github.com/theshivamlko',
      'icon': 'assets/images/github.png'
    },
    {
      'name': 'linkedin',
      "link": 'https://www.linkedin.com/in/theshivamlko',
      'icon': 'assets/images/linkedin.png'
    },
    {
      'name': 'twitter',
      "link": 'https://twitter.com/theshivamlko',
      'icon': 'assets/images/twitter.png'
    },
    {
      'name': 'website',
      "link": 'https://navoki.com',
      'icon': 'assets/images/website.png'
    },
  ];

// Keys Constants
  static const EMAIL = "email";
  static const PASSWORD = "password";
  static const API_TOKEN = "token";
  static const LOCAL_ID = "localId";
  static const REQUEST_TYPE = "requestType";
}
