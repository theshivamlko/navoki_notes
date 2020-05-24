
/// Handle Exception when no data found
class NoDataFound implements Exception {
  NoDataFound();
}

/// Handle Un expected Exception
class GoneWrongException implements Exception {
  GoneWrongException();
}

/// Handle Exception with custom message
class UserMessageException implements Exception {
  String message;

  UserMessageException(this.message);
}
