import 'package:flutter/material.dart';
import 'package:store/Screens/authentication/login.dart';
import 'package:store/Screens/user/main_screen.dart';
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

  Map<String, String>? userDetails;

  Future<void> fetchUserDetails(String userid, BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      if (userid != null) {
        final details = await _authservice.fetchUserDetails(userid);
        userDetails = {
          'username': details['username'] ?? '',
          'name': details['name'] ?? '',
          'email': details['email'] ?? '',
          'phone': details['phone']?.toString() ?? '',
          'role': details['role']?.toString() ?? '',
        };
        print(userDetails);
        notifyListeners();
      } else {
        throw Exception('User ID is not available.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to fetch user details: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
