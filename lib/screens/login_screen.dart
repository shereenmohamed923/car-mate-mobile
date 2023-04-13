import 'dart:convert';

import 'package:flutter/material.dart';
//import 'InputDeco_design.dart';
import 'package:http/http.dart' as http;

class loginScreen extends StatefulWidget {
  @override
  _loginScreen createState() => _loginScreen();
}

class _loginScreen extends State<loginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  child: Image.network(
                      "https://protocoderspoint.com/wp-content/uploads/2020/10/PROTO-CODERS-POINT-LOGO-water-mark-.png"),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email), labelText: "Email"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter  email";
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                    onSaved: (String email) {
                      _email.text = email;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: _password,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock), labelText: "Password"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter password";
                      }

                      return null;
                    },
                    onSaved: (String password) {
                      _password.text = password;
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    //color: Colors.redAccent,
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        RegistrationUser();
                        print("Successful");
                      } else {
                        print("Unsuccessfull");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Colors.blue, width: 2)),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent,
                    ),

                    child: Text("Submit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future RegistrationUser() async {
    var url =
        Uri.parse('https://car-mate-t012.onrender.com/api/v1/users/login');
    http.Response response = await http.post(url,
        body: jsonEncode({
          "email": _email.text,
          "password": _password.text,
        }),
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
        });
    print(jsonDecode(response.body));
  }
}
