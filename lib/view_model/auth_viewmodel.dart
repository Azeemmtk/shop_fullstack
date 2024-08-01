import 'package:flutter/material.dart';
import 'package:store/Screens/authentication/login.dart';
import 'package:store/Screens/main_screen.dart';
import 'package:store/services/auth_service.dart';

import '../model/auth_model.dart';

class AuthViewmodel extends ChangeNotifier {
  bool loading = false;
  final _authservice = Authservice();

  Future<void> reg(
      {required AuthenticationModel user,
      required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();
      await _authservice.register(user: user);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Signin(),
          ));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> login(
      {required String username,
      required String password,
      required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();
      await _authservice.login(username: username, password: password);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Mainscreen(), // Navigate to the home screen after successful login
          ));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      // Handle login error
    }
  }
}
