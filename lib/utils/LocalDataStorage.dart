import 'package:cross_local_storage/cross_local_storage.dart';
import 'package:keepapp/utils/AppConstants.dart' ;

/// Store Local data for app usage
class LocalDataStorage {
  LocalStorageInterface prefs;

  /// saveToken [token]
  void saveToken(String token) async {
    prefs = await LocalStorage.getInstance();
    prefs.setString(AppConstants.API_TOKEN, token);
  }

  /// saveUserId [userId]
  void saveUserId(String userId) async {
    prefs = await LocalStorage.getInstance();
    prefs.setString(AppConstants.LOCAL_ID, userId);
  }

  /// getToken
  Future<String> getToken() async {
    prefs = await LocalStorage.getInstance();
    return prefs.getString(AppConstants.API_TOKEN) ;
  }

  /// getUserId
  Future<String> getUserId() async {
    prefs = await LocalStorage.getInstance();
    return prefs.getString(AppConstants.LOCAL_ID) ;
  }

  /// clear local app data
  Future<String>  clear() async {
    prefs = await LocalStorage.getInstance();
    await prefs.setString(AppConstants.API_TOKEN, null);
    await prefs.setString(AppConstants.LOCAL_ID, null);
    await prefs.clear();

  }
}
