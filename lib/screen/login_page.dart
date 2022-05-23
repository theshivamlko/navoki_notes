import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:navokinotes/blocs/login_bloc.dart';
import 'package:navokinotes/utils/app_constants.dart';
import 'package:navokinotes/utils/device.dart';
import 'package:navokinotes/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor2/tinycolor2.dart';

/// LoginPage UI
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  /// Switch login/signUp section
  late TabController tabController;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late LoginBloc loginBloc;
  late Future<String?>? tokenFuture;
  late Device device;

  final List<Tab> tabLabel = <Tab>[
    const Tab(
      child: Text(
        'EXISTING',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    const Tab(
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
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      /* animationController!.addListener(() {
        if (animationController!.isCompleted) {
        }
      });*/
      loginBloc.isAnimating = true;
      //  animationController!.forward();
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
                  child: Stack(
                    children: [
                      Align(
                        alignment: const Alignment(-1.1, -1.2),
                        child: Opacity(
                            opacity: 0.5,
                            child: Image.asset(
                              'assets/images/pattern1.png',
                              height: device.isMobile ? 250 : 300,
                              width: device.isMobile ? 250 : 300,
                            )),
                      ),
                      Align(
                        alignment: const Alignment(-1.1, -1.2),
                        child: Image.asset('assets/images/pattern1.png',
                            height: device.isMobile ? 200 : 250,
                            width: device.isMobile ? 200 : 250),
                      ),
                      Align(
                          alignment: const Alignment(1.1, 1.3),
                          child: Image.asset('assets/images/pattern2.png',
                              height: 300, width: device.isMobile ? 150 : 300))
                    ],
                  ),
                ),

                /// Body of Login, After Auth Checked
                SizedBox(
                  height: device.deviceHeight,
                  width: device.deviceWidth * 0.90,
                  child: FutureBuilder(
                      future: tokenFuture,
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        // ignore: missing_return
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: logoDesign());
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
    return Flex(
      direction: device.isMobile ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        /// Logo Section UI
        Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Container(child: logoDesign(showText: true))),

        /// Login Form UI
        loginBloc.isAnimating
            ? Container()
            : Flexible(
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
                gradient: const LinearGradient(
                  begin: Alignment(1.0, 0.0),
                  end: Alignment(-1.0, 0.0),
                  colors: [Color(0xffff470b), Color(0xfffca10e)],
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
        const Padding(padding: EdgeInsets.only(top: 20)),
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
  Widget logoDesign({bool? showText}) {
    double iconSize = device.isMobile ? 100 : 150;

    return SizedBox(
      height: device.deviceHeight,
      width: device.deviceWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: iconSize,
            width: iconSize,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(device.deviceWidth * .12),
              boxShadow: const [
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
                  'assets/images/app_icon.png',
                ),
              ),
            ),
          ),
          showText == null
              ? Container()
              : Padding(
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
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 0.0),
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
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white),
                  labelText: 'Password',
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 0.0),
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
                margin: const EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27.5),
                    gradient: const LinearGradient(
                      begin: Alignment(1.0, 0.0),
                      end: Alignment(-1.0, 0.0),
                      colors: [Color(0xffff470b), Color(0xfffca10e)],
                      stops: [0.0, 1.0],
                    ),
                  ),

                  padding: const EdgeInsets.all(12),
                  // color: Theme.of(context).primaryColor,
                  child: loginBloc.isLoading
                      ? Utils.loadingView(40)
                      : const Text('LOGIN',
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
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Forget Password',
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
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 0.0),
                ),
              ),
              controller: emailController,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
            child: TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 0.0),
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
              margin: const EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27.5),
                  gradient: LinearGradient(
                    begin: const Alignment(1.0, 0.0),
                    end: const Alignment(-1.0, 0.0),
                    colors: [
                      AppConstants.orangeColor,
                      AppConstants.yellowColor
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: loginBloc.isLoading
                    ? Utils.loadingView(40)
                    : const Text('SIGNUP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const Flexible(
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
      builder: (context) => AlertDialog(
        actions: [
          GestureDetector(
            onTap: () {
              if (emailController.text.isNotEmpty) {
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
        title: const Text(
          'Forgot Password?',
          style: TextStyle(fontSize: 16),
        ),
        content: SizedBox(
          height: 70,
          child: TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(),
              ),
            ),
            controller: emailController,
          ),
        ),
      ),
    );
  }
}
