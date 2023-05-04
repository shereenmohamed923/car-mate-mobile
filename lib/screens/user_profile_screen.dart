import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile-screen';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(child: Text('user profile page'), alignment: Alignment.center,),
            ListTile(
          title: Text('LogOut'),
          leading: Icon(Icons.logout),
          onTap: () {
            Provider.of<Auth>(context, listen: false).logout();
          }
        ),
          ],
        ),
      ),
    );
  }
}
