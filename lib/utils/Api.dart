import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keepapp/model/NoteModel.dart';
import 'package:keepapp/utils/AppConstants.dart';
import 'package:keepapp/utils/Exceptions.dart';
import 'package:keepapp/utils/Utils.dart';

String parent =
    "projects/navokitest/databases/(default)/documents/notes/${Utils.userId}/data/";

/// To work on Notes List
String NOTE_API =
    "https://firestore.googleapis.com/v1/projects/navokitest/databases/(default)/documents/notes/${Utils.userId}/data/";

/// Register User
const registerUserApi =
    "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${AppConstants.API_KEY}";

/// Login Existing User with Email and Password
const signInApi =
    "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${AppConstants.API_KEY}";

/// Login Existing User with Token
const loginWithApiToken =
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo?key=${AppConstants.API_KEY}";

/// Send reset password email to user
const passwordResetApi =
    "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=${AppConstants.API_KEY}";

/// return List of notes of user
Future<List<NoteModel>> getNotes() async {
  try {
    var response = await http.get("${NOTE_API}",
        headers: {"Authorization": "Bearer ${Utils.loginToken}"});
    if (response.statusCode == 200) {
      List<NoteModel> notesList = List();
      Map map = json.decode(response.body);
      List list = map['documents'];
      if (list != null && !list.isEmpty) {
        for (int i = 0; i < list.length; i++) {
          NoteModel noteModel = NoteModel.store(
              map['documents'][i]['name'].toString().replaceAll(parent, ""),
              ((map['documents'][i]['fields'] ?? Map())['title'] ??
                  Map())['stringValue'],
              ((map['documents'][i]['fields'] ?? Map())['description'] ??
                  Map())['stringValue'],
              int.parse(
                  ((map['documents'][i]['fields'] ?? Map())['colorValue'] ??
                          Map())['stringValue'] ??
                      Colors.red.value.toString()));
          noteModel.createTime = map['documents'][i]['createTime'];
          notesList.add(noteModel);
        }
      }
      return notesList;
    } else {
      Map map = json.decode(response.body);
      throw (UserMessageException(map['error']['status']));
    }
  } catch (err) {
    throw err;
  }
}

/// return add new note [noteModel]
Future<bool> addNote(NoteModel noteModel) async {
  try {
    var response = await http.post("${NOTE_API}",
        headers: {"Authorization": "Bearer ${Utils.loginToken}"},
        body: json.encode({
          "fields": {
            "title": {"stringValue": noteModel.title},
            "description": {"stringValue": noteModel.description},
            "colorValue": {"stringValue": noteModel.colorValue.toString()},
            //  "createdTime": {"stringValue":Utils.getServerTimeFormat(DateTime.now())}
          }
        }));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (err) {
    throw err;
  }
}

/// update existing note [noteModel]
Future<bool> updateData(NoteModel noteModel) async {
  String updateApi = "$NOTE_API" + noteModel.itemId;

  try {
    var response = await http.patch(updateApi,
        headers: {"Authorization": "Bearer ${Utils.loginToken}"},
        body: json.encode({
          "fields": {
            "title": {"stringValue": noteModel.title},
            "description": {"stringValue": noteModel.description},
            "colorValue": {"stringValue": noteModel.colorValue.toString()}
          }
        }));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (err) {
    throw err;
  }
}

/// delete existing note [noteModel]
Future<bool> deleteNote(NoteModel noteModel) async {
  try {
    var response = await http.delete(
      "${NOTE_API}${noteModel.itemId}",
      headers: {"Authorization": "Bearer ${Utils.loginToken}"},
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (err) {
    throw err;
  }
}

/// Sign-in existing user with  [email] and [password]
Future<String> signInUser(String email, String password) async {
  try {
    var response = await http.post(signInApi,
        body: json.encode({
          AppConstants.EMAIL: email,
          AppConstants.PASSWORD: password,
          "returnSecureToken": true
        }));
    if (response.statusCode == 200) {
      Map map = json.decode(response.body);
      Utils.loginToken = map['idToken'];
      Utils.userId = map['localId'];
      return Utils.loginToken;
    } else {
      Map map = json.decode(response.body);
      throw (UserMessageException(map['error']['message']));
    }
  } catch (err) {
    throw err;
  }
}

/// Sign-up new user with [email] and [password]
Future<String> registerUser(String email, String password) async {
  try {
    var response = await http.post(registerUserApi,
        body: json.encode(
            {AppConstants.EMAIL: email, AppConstants.PASSWORD: password}));

    if (response.statusCode == 200) {
      Map map = json.decode(response.body);
      Utils.loginToken = map['idToken'];
      Utils.userId = map['localId'];
      return Utils.loginToken;
    } else {
      Map map = json.decode(response.body);
      throw (UserMessageException(map['error']['message']));
    }
  } catch (err) {
    throw err;
  }
}

/// Sign-in existing user with  [token]
Future<bool> signInWithToken(String token) async {
  try {
    var response = await http.post(loginWithApiToken,
        body: json.encode({"idToken": token}));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (err) {
    throw err;
  }
}

/// Reset password with [email]
Future<bool> resetPassword(String email) async {
  try {
    var response = await http.post(passwordResetApi,
        body: json.encode({
          AppConstants.EMAIL: email,
          AppConstants.REQUEST_TYPE: "PASSWORD_RESET"
        }));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (err) {
    throw err;
  }
}

/// send Email verification [email]
Future<bool> sendVerifyEmail(String email) async {
  try {
    var response = await http.post(passwordResetApi,
        body: json.encode({
          AppConstants.EMAIL: email,
          AppConstants.REQUEST_TYPE: "VERIFY_EMAIL"
        }));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (err) {
    throw err;
  }
}
