import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> SignUp(
    String email,
    String password,
    String confirmPassword,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    var url =
        Uri.parse('https://car-mate-t012.onrender.com/api/v1/users/signup/');
    try {
      http.Response response = await http.post(
        url,
        body: jsonEncode({
          "email": email,
          "password": password,
          "ConfirmPassword": confirmPassword,
          "FirstName": firstName,
          "LastName": lastName,
          "PhoneNumber": phoneNumber,
        }),
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['status'] == "fail") {
        throw HttpException(responseData['status']['message']);
      }
      _token = responseData['token'];
      _expiryDate = DateTime.now().add(Duration(days : 90));
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    var url =
        Uri.parse('https://car-mate-t012.onrender.com/api/v1/users/login');
    try {
      http.Response response = await http.post(
        url,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['status'] == "fail") {
        throw HttpException(responseData['status']['message']);
      }
      _token = responseData['token'];
      _expiryDate = DateTime.now().add(Duration(days : 90));
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }
  Future<void> logout() async{
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }
  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
