import 'package:flutter/material.dart';
import '../login.dart';
import './account_screen.dart';
import './todo_screen.dart';
import './sundry_screen.dart';
import './drawer_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: DrawerScreen(),
        appBar: AppBar(
          elevation: 10.0,
          shadowColor: Colors.red[200],
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "logOut",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.blueGrey[500],
          title: Text(
            "thrift ",
            style: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.white70,
              fontFamily: "Pacifico",
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.redAccent,
            ),
            tabs: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Colors.redAccent, width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "accounts",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Colors.redAccent, width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "sundry",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Colors.redAccent, width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "todos",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AccountScreen(),
            SundryScreen(),
            TodoScreen(),
          ],
        ),
      ),
    );
  }
}
