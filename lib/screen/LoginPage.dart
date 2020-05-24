import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:keepapp/blocs/LoginBloc.dart';
import 'package:keepapp/utils/AppConstants.dart';
import 'package:keepapp/utils/Device.dart';
import 'package:keepapp/utils/Utils.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

/// LoginPage UI
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {

  /// Switch login/signUp section
  TabController tabController;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginBloc loginBloc;
  Future<String> tokenFuture;
  Device device;

  final List<Tab> tabLabel = <Tab>[
    Tab(
      child: Text(
        'EXISTING',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    Tab(
      child: Text(
        'NEW',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    tokenFuture = null;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      tokenFuture = loginBloc.getToken();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    loginBloc = Provider.of<LoginBloc>(context);
    loginBloc.context = context;

    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// Login Background
                Container(
                  height: device.deviceHeight,
                  width: device.deviceWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        TinyColor(Theme.of(context).primaryColor)
                            .darken(20)
                            .color,
                        TinyColor(Theme.of(context).primaryColor)
                            .darken(15)
                            .color,
                        TinyColor(Theme.of(context).primaryColor)
                            .darken(8)
                            .color,
                        TinyColor(Theme.of(context).primaryColor)
                            .lighten(3)
                            .color,
                        TinyColor(Theme.of(context).primaryColor)
                            .lighten(5)
                            .color,
                      ],
                    ),
                  ),
                  child: Container(
                    /// 2 Images at Corners
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment(-1.1, -1.2),
                          child: Opacity(
                              opacity: 0.5,
                              child: Image.asset(
                                'assets/images/pattern1.png',
                                height: device.isMobile ? 250 : 300,
                                width: device.isMobile ? 250 : 300,
                              )),
                        ),
                        Align(
                          alignment: Alignment(-1.1, -1.2),
                          child: Image.asset('assets/images/pattern1.png',
                              height: device.isMobile ? 200 : 250,
                              width: device.isMobile ? 200 : 250),
                        ),
                        Align(
                            alignment: Alignment(1.1, 1.3),
                            child: Image.asset('assets/images/pattern2.png',
                                height: 300,
                                width: device.isMobile ? 150 : 300))
                      ],
                    ),
                  ),
                ),

                /// Body of Login, After Auth Checked
                Container(
                  height: device.deviceHeight,
                  width: device.deviceWidth * 0.90,
                  child: FutureBuilder(
                      future: tokenFuture,
                      builder: (context, snapshot) {
                        // ignore: missing_return
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.data != null) {
                          return Center(child: Utils.loadingView(80));
                        } else if (snapshot.connectionState ==
                                ConnectionState.done ||
                            snapshot.data == null) {
                          /// Body of Login UI
                          return body();
                        }
                        return Container();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return Container(
      child: Flex(
        direction: device.isMobile ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /// Logo Section UI
          Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: Container(child: logoDesign())),

          /// Login Form UI
          Flexible(
            fit: FlexFit.loose,
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: device.isMobile
                    ? device.deviceWidth * .90
                    : device.deviceWidth * .50,
                child: loginForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Login TAB UI
  Column loginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27.5),
                border: Border.all(color: Colors.white)),
            child: TabBar(
              onTap: (i) {},
              controller: tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(27.5),
                gradient: LinearGradient(
                  begin: Alignment(1.0, 0.0),
                  end: Alignment(-1.0, 0.0),
                  colors: [const Color(0xffff470b), const Color(0xfffca10e)],
                  stops: [0.0, 1.0],
                ),
              ),
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: tabLabel,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Flexible(
          fit: FlexFit.loose,
          flex: 2,
          child: TabBarView(
              controller: tabController,
              children: <Widget>[loginWidget(), signUpWidget()]),
        ),
      ],
    );
  }

  /// Logo Section UI
  Widget logoDesign() {
    double iconSize = device.isMobile ? 100 : 150;

    return Container(
      height: device.deviceHeight,
      width: device.deviceWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: iconSize,
            width: iconSize,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(device.deviceWidth * .12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1.0,
                  spreadRadius: 2.0,
                ),
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: iconSize,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  "assets/images/app_icon.png",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Let's get started now",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: device.isMobile ? 25 : 30,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// Login Form UI
  Widget loginWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor, width: 0.0),
                  ),
                ),
                controller: emailController,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
              child: TextField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: "Password",
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor, width: 0.0),
                  ),
                ),
                controller: passwordController,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: GestureDetector(
              onTap: () => loginBloc.isLoading
                  ? null
                  : loginBloc.signIn(
                      emailController.text, passwordController.text),
              child: Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27.5),
                    gradient: LinearGradient(
                      begin: Alignment(1.0, 0.0),
                      end: Alignment(-1.0, 0.0),
                      colors: [
                        const Color(0xffff470b),
                        const Color(0xfffca10e)
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),

                  padding: EdgeInsets.all(12),
                  // color: Theme.of(context).primaryColor,
                  child: loginBloc.isLoading
                      ? Utils.loadingView(40)
                      : Text('LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: GestureDetector(
              onTap: () => resetPassword(),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Forget Password",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// SignUp Form UI
  Widget signUpWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 0.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 0.0),
                ),
              ),
              controller: emailController,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 0.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 0.0),
                ),
              ),
              controller: passwordController,
            ),
          ),
          GestureDetector(
            onTap: () => loginBloc.isLoading
                ? null
                : loginBloc.register(
                    emailController.text, passwordController.text),
            child: Container(
              width: 200,
              height: 50,
              margin: EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27.5),
                  gradient: LinearGradient(
                    begin: Alignment(1.0, 0.0),
                    end: Alignment(-1.0, 0.0),
                    colors: [
                      AppConstants.orangeColor,
                      AppConstants.yellowColor
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
                padding: EdgeInsets.all(12),
                child: loginBloc.isLoading
                    ? Utils.loadingView(40)
                    : Text('SIGNUP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(15.0),
            ),
          )
        ],
      ),
    );
  }

  /// Forgot Password Dialog
  void resetPassword() {
    TextEditingController emailController = TextEditingController();
    showDialog(
        context: context,
        child: AlertDialog(
          actions: [
            GestureDetector(
              onTap: () {
                if (emailController.text != null &&
                    emailController.text.isNotEmpty) {
                  loginBloc.resetPassword(emailController.text);
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
          title: Text(
            "Forgot Password?",
            style: TextStyle(fontSize: 16),
          ),
          content: Container(
            height: 70,
            child: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                labelText: "Email",
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(),
                ),
              ),
              controller: emailController,
            ),
          ),
        ));
  }
}
