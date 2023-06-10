
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signup_screen.dart';
import 'market_screen.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';
import 'forget_password_screen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin-screen';
  @override
  _SignInScreen createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
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
  //   Navigator.of(context).pushNamed(HomeScreen.routeName, arguments: [_token]);
  // }

  Future<void> _submitSignIn() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).signIn(
        _authData['email'],
        _authData['password'],
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
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
                      controller: _passwordController,
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
                                fontSize: 20, fontWeight: FontWeight.normal, color: Colors.blue),
                          ),
                          style: Theme.of(context).outlinedButtonTheme.style,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              SignUpScreen.routeName,
                            );
                          },
                        ),
                        OutlinedButton(
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                          autofocus: true,
                          style: Theme.of(context).outlinedButtonTheme.style,
                          onPressed: _submitSignIn,
                        ),


                      ],
                    ),
                    SizedBox(height: 30,),
Row(children: [Container(width: 110,height: 40,child: Text('Remember Me',style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 12,color: Colors.white,),),


),
SizedBox(width: 100,),
Container(width: 120,height: 32,child:TextButton(style:ButtonStyle(),onPressed: (){Navigator.of(context).pushNamed(forget_password_screen.routeName,);},child: Text('Forget Password?',style: TextStyle(decoration: TextDecoration.underline,fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 12,color: Colors.blue),),),)

],)



                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
