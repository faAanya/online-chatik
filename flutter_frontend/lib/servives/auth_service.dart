import 'dart:async';

import 'package:flutter_frontend/model/user.dart';

class AuthService {
  static User? user;
  static final StreamController<User?> _eventStreamController =
      StreamController();
  static Stream<User?> get onUserChange => _eventStreamController.stream;
  static Future<void> signIn() async {
    user = User(id: "0", nickname: "Test", phonenumber: "+375291405314");
    _eventStreamController.add(user);
  }

  static Future<void> signOut() async {
    user = null;
    _eventStreamController.add(null);
  }
}
