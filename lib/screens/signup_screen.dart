import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'market_screen.dart';
import 'signin_screen.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'confirm password': '',
    'first name': '',
    'last name': '',
    'phone number': '',
  };

  var _isLoading = false;
  TextEditingController _passwordController = TextEditingController();

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

  // void navigation(BuildContext context) {
  //   Navigator.of(context).pushNamed(HomeScreen.routeName);
  // }

  Future<void> _submitSignUp() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).SignUp(
        _authData['email'],
        _authData['password'],
        _authData['confirm password'],
        _authData['first name'],
        _authData['last name'],
        _authData['phone number'],
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
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
                          onSaved: (value) {
                            _authData['first name'] = value;
                          },
                        ),
                      ),
                      Container(
                        width: deviceSize.width * 0.35,
                        padding: EdgeInsets.symmetric(
                          vertical: deviceSize.height * 0.025,
                        ),
                        child: TextFormField(
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
                          onSaved: (value) {
                            _authData['last name'] = value;
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
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.025,
                    ),
                    child: TextFormField(
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
                      onSaved: (value) {
                        _authData['phone number'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.025,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
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
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.025,
                    ),
                    child: TextFormField(
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
                        if (value != _passwordController.text) {
                          return 'Passwords do not match!';
                        }
                      },
                      onSaved: (value) {
                        _authData['confirm password'] = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.050,
                  ),
                  if (_isLoading)
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    )
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
                          onPressed: _submitSignUp,
                        ),
                        OutlinedButton(
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal, color: Colors.blue),
                          ),
                          autofocus: true,
                          style: Theme.of(context).outlinedButtonTheme.style,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              SignInScreen.routeName,
                            );
                          },
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
}
