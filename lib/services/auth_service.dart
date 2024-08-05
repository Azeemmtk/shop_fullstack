import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth_model.dart';
import '../utils/contants.dart';

class Authservice {
  String? userId;

  Authservice() {
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

  Future<void> _saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', id);
    userId = id;
  }

  Future<void> register({required AuthenticationModel user}) async {
    final Uri url = Uri.parse('$baseurl/api/auth/register');
    try {
      final response = await http.post(url, body: user.toJson());

      if (response.statusCode == 200) {
        print('Registration successful');
      } else {
        throw Exception(
            'Failed to register. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
      throw Exception('An error occurred during registration');
    }
  }

  Future<void> login(
      {required String username, required String password}) async {
    final Uri url = Uri.parse('$baseurl/api/auth/login');
    try {
      final Map<String, dynamic> body = {
        'username': username,
        'password': password,
      };
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        userId = responseData['loginid'];
        await _saveUserId(userId!);
        print('Login successful');
        print('User ID: $userId');
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
      throw Exception('An error occurred during login');
    }
  }

  Future<Map<String, dynamic>> fetchUserDetails(String id) async {
    final Uri url = Uri.parse('$baseurl/api/auth/userdetails/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to fetch user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during fetching user details: $e');
      throw Exception('An error occurred during fetching user details');
    }
  }
}
