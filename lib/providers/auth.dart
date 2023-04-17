import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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
      // final prefs = await SharedPreferences.getInstance();
      // final userData = json.encode(
      //   {
      //     'token': _token,
      //   },
      // );
      // prefs.setString('userData', userData);
      notifyListeners();
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
      // final prefs = await SharedPreferences.getInstance();
      //  final userData = json.encode(
      //   {
      //     'token': _token,
      //   },
      // );
      // prefs.setString('userData', userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  void logout(){
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }
}
