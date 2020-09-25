import 'package:flutter/material.dart';

import '../login.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color drawerColor = Colors.blueGrey[200];
    return Drawer(
      elevation: 25.0,
      child: Container(
        decoration: BoxDecoration(
          color: drawerColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0),
            CircleAvatar(
              radius: 50.0,
              child: Image.asset("assets/images/inn.jpg"),
            ),
            SizedBox(height: 30.0),
            CircleAvatar(
              backgroundColor: drawerColor,
              radius: 50.0,
              child: Image.asset("assets/images/books.png"),
            ),
            CircleAvatar(
              backgroundColor: drawerColor,
              radius: 50.0,
              child: Image.asset("assets/images/mbag.png"),
            ),
            SizedBox(height: 30.0),
            CircleAvatar(
              backgroundColor: drawerColor,
              child: Image.asset(
                "assets/images/settings.png",
              ),
            ),
            SizedBox(height: 30.0),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 25.0,
                backgroundColor: drawerColor,
                child: Image.asset(
                  "assets/images/back.png",
                ),
              ),
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
