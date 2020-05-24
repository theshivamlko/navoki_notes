import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepapp/model/NoteModel.dart';
import 'package:keepapp/screen/HomePage.dart';
import 'package:keepapp/utils/Api.dart' as Api;
import 'package:keepapp/utils/LocalDataStorage.dart';
import 'package:keepapp/utils/Utils.dart';

class LoginBloc extends ChangeNotifier {
  List<NoteModel> notesList = List();
  BuildContext context;
  String token;
  LocalDataStorage localDataStorage = LocalDataStorage();
  bool isLoading = false;

  void resetPassword(String email) {
    Api.resetPassword(email).then((value) {
      Utils.showToast("An email link is sent to your email");
    }).catchError((onError) {});
  }

  Future<String> getToken() async {
    //  print( 'getToken1111');
    //  await localDataStorage.clear();
    Utils.loginToken = await localDataStorage.getToken();
    //  print( Utils.loginToken);
    Utils.userId = await localDataStorage.getUserId();
    //  print(  Utils.userId);
    if (Utils.loginToken != null) {
      bool isValid = await Api.signInWithToken(Utils.loginToken);
      if (isValid ?? false)
        openHomePage(token);
      else
        return null;
    }

    return Utils.loginToken;
    // return null;
  }

  signIn(String email, String password) {
    // checking if email and password are valid
    if (email == null || email.length < 3 || !email.contains("@")) {
      Utils.showToast("Invalid email");
      return;
    }
    if (password == null || password.length < 5) {
      Utils.showToast("Invalid password");
      return;
    }

    // hiding keyboard if email and password are valid
    FocusScope.of(context).requestFocus(FocusNode());

    isLoading = true;
    notifyListeners();

    Api.signInUser(email, password).then((token) {
      if (token != null) {
        isLoading = false;
        localDataStorage.saveToken(token);
        localDataStorage.saveUserId(Utils.userId);
        notifyListeners();
        /*  Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage(token)));*/

        openHomePage(token);
      }
    }).catchError((onError) {
      isLoading = false;
      Utils.showToast(Utils.getErrorMessage(onError));
      notifyListeners();
    });
  }

  void openHomePage(String token) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(token: token)),
    );
  }

  void register(String email, String password) {
    // checking if email and password are valid
    if (email == null || email.length < 3 || !email.contains("@")) {
      Utils.showToast("Invalid email");
      return;
    }
    if (password == null || password.length < 5) {
      Utils.showToast("Invalid password");
      return;
    }

    // hiding keyboard if email and password are valid
    FocusScope.of(context).requestFocus(FocusNode());

    isLoading = true;
    notifyListeners();
    Api.registerUser(email, password).then((token) {
      if (token != null) {
        isLoading = false;
        localDataStorage.saveToken(token);
        localDataStorage.saveUserId(Utils.userId);
        notifyListeners();

        openHomePage(token);
      }
    }).catchError((onError) {
      isLoading = false;
      Utils.showToast(Utils.getErrorMessage(onError));
      notifyListeners();
    });
  }
}
