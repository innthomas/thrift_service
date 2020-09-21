import 'package:flutter/material.dart';
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
          centerTitle: true,
          backgroundColor: Colors.blueGrey[500],
          title: Text(
            "thrift service",
            style: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.white70,
              fontFamily: "Pacifico",
              fontSize: 30.0,
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
            TodoScreen(),
            SundryScreen(),
          ],
        ),
      ),
    );
  }
}
