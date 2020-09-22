import 'package:flutter/material.dart';

import '../login.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 25.0,
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0),
            CircleAvatar(
              radius: 50.0,
              child: Image.asset("assets/images/inn.jpg"),
            ),
            SizedBox(height: 30.0),
            CircleAvatar(
              radius: 50.0,
              child: Image.asset("assets/images/tee.png"),
            ),
            SizedBox(height: 30.0),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 30.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Image.asset("assets/images/power.png"),
            ),
          ],
        ),
      ),
    );
  }
}
