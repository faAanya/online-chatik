import 'dart:async';

class AuthService {
  static bool loggedIn = false;
  static final StreamController<bool?> _eventStreamController =
      StreamController();
  static Stream<bool?> get onUserChange =>
      _eventStreamController.stream;
  static Future<void> signIn() async {
    loggedIn = true;
    _eventStreamController.add(true);
  }

  static Future<void> signOut() async {
    loggedIn = false;
    _eventStreamController.add(null);
  }
}
