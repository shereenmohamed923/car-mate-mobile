import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';

class authorizationScreen extends StatefulWidget {
  @override
  _authorizationScreen createState() => _authorizationScreen();
}

class _authorizationScreen extends State<authorizationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      RegistrationUser();
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Image.network(
              'https://sportishka.com/uploads/posts/2021-12/1639095719_1-sportishka-com-p-dom-mashina-dengi-sport-krasivo-foto-1.jpg',
              colorBlendMode: BlendMode.modulate,
              fit: BoxFit.cover,
            ),
            height: deviceSize.height,
            width: deviceSize.width,
          ),
          Container(
            color: Color.fromARGB(200, 0, 0, 0),
            height: deviceSize.height,
            width: deviceSize.width,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Color.fromARGB(1, 0, 0, 0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: deviceSize.width * 0.35,
                        padding: EdgeInsets.symmetric(
                          vertical: deviceSize.height * 0.025,
                        ),
                        child: TextFormField(
                          controller: _firstname,
                          cursorColor: Color.fromARGB(220, 220, 220, 220),
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                              color: Color.fromARGB(220, 220, 220, 220),
                              fontSize: 18),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(220, 220, 220, 220))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(220, 220, 220, 220))),
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(220, 220, 220, 220),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          onSaved: (String firstname) {
                            _firstname.text = firstname;
                          },
                        ),
                      ),
                      Container(
                        width: deviceSize.width * 0.35,
                        padding: EdgeInsets.symmetric(
                          vertical: deviceSize.height * 0.025,
                        ),
                        child: TextFormField(
                          controller: _lastname,
                          cursorColor: Color.fromARGB(220, 220, 220, 220),
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                              color: Color.fromARGB(220, 220, 220, 220),
                              fontSize: 18),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(220, 220, 220, 220))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(220, 220, 220, 220))),
                            labelText: 'Last Name',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(220, 220, 220, 220),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          onSaved: (String lastname) {
                            _lastname.text = lastname;
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.025,
                    ),
                    child: TextFormField(
                      controller: _email,
                      cursorColor: Color.fromARGB(220, 220, 220, 220),
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color: Color.fromARGB(220, 220, 220, 220),
                          fontSize: 18),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(220, 220, 220, 220))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(220, 220, 220, 220))),
                          labelText: 'E-Mail',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(220, 220, 220, 220),
                          ),
                          suffixIcon: Icon(Icons.email_outlined),
                          suffixIconColor: Colors.white,
                          suffixIconConstraints:
                              BoxConstraints(maxHeight: 16.55, maxWidth: 25)),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                      onSaved: (String email) {
                        _email.text = email;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.025,
                    ),
                    child: TextFormField(
                      controller: _phone,
                      cursorColor: Color.fromARGB(220, 220, 220, 220),
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color: Color.fromARGB(220, 220, 220, 220),
                          fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(220, 220, 220, 220))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(220, 220, 220, 220))),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(220, 220, 220, 220),
                        ),
                        suffixIcon: Icon(Icons.phone_enabled_rounded),
                        suffixIconColor: Colors.white,
                        suffixIconConstraints:
                            BoxConstraints(maxHeight: 16.55, maxWidth: 25),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (String phonenumber) {
                        _phone.text = phonenumber;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.025,
                    ),
                    child: TextFormField(
                      controller: _password,
                      cursorColor: Color.fromARGB(220, 220, 220, 220),
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color: Color.fromARGB(220, 220, 220, 220),
                          fontSize: 18),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(220, 220, 220, 220))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(220, 220, 220, 220))),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(220, 220, 220, 220),
                          ),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          suffixIconColor: Colors.white,
                          suffixIconConstraints:
                              BoxConstraints(maxHeight: 16.55, maxWidth: 25)),
                      obscureText: true,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty || value.length < 8) {
                          return 'Password should be at least 8 characters!';
                        }
                      },
                      onSaved: (String password) {
                        _password.text = password;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.025,
                    ),
                    child: TextFormField(
                      controller: _confirmpassword,
                      cursorColor: Color.fromARGB(220, 220, 220, 220),
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          color: Color.fromARGB(220, 220, 220, 220),
                          fontSize: 18),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(220, 220, 220, 220))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(220, 220, 220, 220))),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(220, 220, 220, 220),
                          ),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          suffixIconColor: Colors.white,
                          suffixIconConstraints:
                              BoxConstraints(maxHeight: 16.55, maxWidth: 25)),
                      obscureText: true,
                      validator:
                          // ignore: missing_return
                          (value) {
                        if (value != _password.text) {
                          return 'Passwords do not match!';
                        }
                      },
                      onSaved: (String confirmPassword) {
                        _confirmpassword.text = confirmPassword;
                      },
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.050,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                          style: Theme.of(context).outlinedButtonTheme.style,
                          onPressed: _submit,
                        ),
                        OutlinedButton(
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                          autofocus: true,
                          style: Theme.of(context).outlinedButtonTheme.style,
                          onPressed: () {},
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _token;
  String _userId;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    return _token;
  }

  Future RegistrationUser() async {
    var url =
        Uri.parse('https://car-mate-t012.onrender.com/api/v1/users/signup/');
    try {
      http.Response response = await http.post(url,
          body: jsonEncode({
            "email": _email.text,
            "password": _password.text,
            "ConfirmPassword": _confirmpassword.text,
            "FirstName": _firstname.text,
            "LastName": _lastname.text,
            "PhoneNumber": _phone.text,
          }),
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
          });
      print(jsonDecode(response.body));
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['status'] == "fail") {
        throw HttpException(responseData['status']['message']);
      }
      _token = responseData['token'];
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }
}
