![Image](misc/banner.png)

# NavokiNotes

Navoki Notes, a note app app, will sync data to cloud and on all devices. We have application for **Android, iOS, Web App, PWA, Windows, macOS, Linux** , so you can access data anywhere on any device. Its FREE to use.
The is a **single code-base cross-platform app made on Flutter Framework with Firebase**.

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/Apache-2.0)  [![navoki-notes](https://snapcraft.io//navoki-notes/badge.svg)](https://snapcraft.io/navoki-notes)

[![Image](misc/googleplay.png)](https://play.google.com/store/apps/details?id=com.navoki.keepapp)  [![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/navoki-notes)

![Image](misc/youtube.png) [Youtube](https://www.youtube.com/channel/UCP2-MYtIbBnlEcfTvJKo5Og?sub_confirmation=1)

![Image](misc/logo_25.png) [Navoki.com](https://navoki.com/blog/)


## Screenshots

  <img src="https://i.imgur.com/PSNQnmR.jpg" height="300px"  /> <img src="https://i.imgur.com/1pRlTex.jpg" height="300px"  /> <img src="https://i.imgur.com/EHFHrOV.jpg" height="300px"  /> <img src="https://i.imgur.com/lOJUfc6.jpg" height="300px"  /> <img src="https://i.imgur.com/QwN21XA.jpg" height="300px"  /> <img src="https://i.imgur.com/xUVmaNa.jpg" height="300px"  />

## Video
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/g-hPh6FPfgo/0.jpg)](https://www.youtube.com/watch?v=g-hPh6FPfgo)

## Downloads
Ready to use app [Android App](https://play.google.com/store/apps/details?id=com.navoki.keepapp)

[Web App](https://navoki.com/samples/navoki-notes/#/)

[iOS, Windows, MacOS,Linux](https://github.com/theshivamlko/navoki_notes/releases)

## Getting Started

This project is made with [Flutter Framework](https://www.flutter.dev), [Firebase Authentication](https://firebase.google.com/docs/auth/), [Cloud Firestore](https://firebase.google.com/docs/firestore) and [Adobe XD Flutter plugin](https://xd.adobelanding.com/xd-to-flutter/).

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Installation and Config
- Install [Flutter SDK](https://flutter.dev/docs/get-started/install) from official site.
- Setup Environment for [Android](https://flutter.dev/docs/get-started/flutter-for/android-devs) and [iOS](https://flutter.dev/docs/get-started/flutter-for/ios-devs)
- Setup Environment for [Web](https://www.youtube.com/watch?v=N8YYVV1aZc8)
- Setup Environment for [Desktop](https://www.youtube.com/watch?v=ixj0MMusDM8)
- Create a [Firebase Project](https://firebase.google.com/) 
- Enable [Firebase Security rules](https://firebase.google.com/docs/firestore/security/get-started) on Firebase Console. [Read more](https://medium.com/@khreniak/cloud-firestore-security-rules-basics-fac6b6bea18e).
- Check if platform is shows for project by running ```flutter devices```
- Replace `API_KEY` value with your project key, `<Project>` _**-> Project Settings -> General ->**_ `Web API key
` 
## Build Project
- To run and build project run command `flutter build <device-name>`
- To get devices list, run `flutter devices`

### NOTE:
- Also, install build tools for each platforms  to run on that platform. Follow links above.
- **Flutter Desktop is not stable yet** so you might face some issue, till now I have faced few app crashes on desktop but feature is implemented and app is running.
For Linux app you need to build project and run using ```flutter run -d linux```

## Learning
Few things I have used that you can work to understand flutter development.
- Simple app state management
- Using RestAPI
- Firebase Auth and Cloud Firestore using Rest API
- Staggered View
- Local Storage

You can build your own project on this just by changing dart code in `lib` folder.


### My Flutter and Tools version:
```flutter doctor -v```
```
[✓] Flutter (Channel master, 1.19.0-2.0.pre.140, on Mac OS X 10.15.5 19F83c,
    locale en-IN)
    • Flutter version 1.19.0-2.0.pre.140 at /Users/shivam/Documents/flutter
    • Framework revision 852a30b003 (41 minutes ago), 2020-05-22 03:27:03 +0530
    • Engine revision 9ce1e5c5c7
    • Dart version 2.9.0 (build 2.9.0-10.0.dev 7706afbcf5)

[!] Android toolchain - develop for Android devices (Android SDK version 29.0.3)
    • Android SDK at /Users/shivam/Library/Android/sdk
    • Platform android-29, build-tools 29.0.3
    • Java binary at: /Applications/Android
      Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build
      1.8.0_212-release-1586-b4-5784211)

[✓] Xcode - develop for iOS and macOS (Xcode 11.3.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Xcode 11.3.1, Build version 11C505
    • CocoaPods version 1.9.1

[√] Visual Studio - develop for Windows (Visual Studio Community 2019 16.5.1)
    • Visual Studio at C:\Program Files (x86)\Microsoft Visual Studio\2019\Community
    • Visual Studio Community 2019 version 16.5.29920.165

[✓] Linux toolchain - develop for Linux desktop
    • clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    • cmake version 3.10.2
    • ninja version 1.8.2

[✓] Android Studio (version 3.6)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin version 45.1.1
    • Dart plugin version 192.8052
    • Java version OpenJDK Runtime Environment (build
      1.8.0_212-release-1586-b4-5784211)

[✓] VS Code (version 1.44.2)
    • Flutter extension version 3.9.1

```

## Contribution
This project is open to all kinds of contribution in all of its categories.You can add more features and bug fixes in this code.
**DO NOT** send PR for rename of file and variables, formatting code or other low-quality changes. **Focus on making this BIGGER!**

## Support
If you found this project helpful then show some support by :star: the repo and subscribe to my YoutubeChannel and Newsletter for latest updates in dev world. It will **encourage** me to make more videos and tutorials.
Comment on youtube channel for more tutorials
 
## Project Created & Maintained By
#### SHIVAM SRIVASTAVA
Mobile Solution Architect, #Android and #Flutter Developer, #Dart, Maybe #Go, #Founder of Navoki.com, #Google Scholar #Udacity Android #Nanodegree, 
 Entrepreneur
 
 [![Image](misc/youtube2.png)](https://www.youtube.com/channel/UCP2-MYtIbBnlEcfTvJKo5Og?sub_confirmation=1)  &nbsp; [![Image](misc/twitter.png)](https://twitter.com/theshivamlko) &nbsp; [![Image](misc/linkedin.png)](https://www.linkedin.com/in/theshivamlko/) &nbsp; [![Image](misc/navoki.png)](https://navoki.com/) &nbsp; [![Image](misc/facebook.png)](https://www.facebook.com/shivamlove11) &nbsp; [![Image](misc/instagram.png)](http://instagram.com/theshivamlko)  
 

## License and Trademarks
```
Copyright 2020 Shivam Srivastava

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

### Navoki and Navoki logo are registered trademark of [navoki.com](https://navoki.com/). You are free to use the source code above.

