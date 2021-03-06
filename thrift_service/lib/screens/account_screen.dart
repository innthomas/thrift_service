import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:thrift_service/account_model/account_model.dart';
import 'package:thrift_service/screens/add_account.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key key}) : super(key: key);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController _controller = TextEditingController();
  Box box = Hive.box<Account>(accountBoxName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: AccountSearch());
                })
          ],
          leading: IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAccount()),
                );
              }),
          toolbarHeight: 70.0,
          centerTitle: true,
          title: Text(
            "transactions",
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontFamily: "Pacifico"),
          ),
        ),
        body: ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            Account a = box.getAt(index);
            return InkWell(
              onDoubleTap: () {
                showDialog(
                  context: context,
                  child: Scaffold(
                      appBar: AppBar(
                        toolbarHeight: 100.0,
                        centerTitle: true,
                        title: Column(
                          children: [
                            Text(
                              "${a.accountName}  : ${a.accountNumber}",
                              style: TextStyle(fontSize: 30.0),
                            ),
                            Text("Statement of Account")
                          ],
                        ),
                      ),
                      body: ListView.builder(
                        itemCount: accountBoxName[index].length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                  "deposit : ₦${a.deposit} date : ${a.time.minute}mins ${a.time.hour}hrs ${a.time.day}/${a.time.month}  ${a.time.year}:  Balance == ₦${a.accountBalance}"),
                              Text(
                                  "withdrawal: ₦${a.withrawal} date: ${a.time.minute} mins ${a.time.hour} hrs ${a.time.day}/${a.time.month}  ${a.time.year}:  Balance == ₦${a.accountBalance}"),
                            ],
                          );
                        },
                      )),
                );
              },
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  child: Container(
                    color: Colors.yellow[100],
                    height: 100,
                    width: 200,
                    child: AlertDialog(
                      actionsOverflowButtonSpacing: 10.0,
                      actionsPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      title: Text("transaction window"),
                      content: Column(
                        children: <Widget>[
                          Text("${a.accountName} ${a.accountNumber}"),
                          TextField(
                            autofocus: true,
                            decoration: InputDecoration(hintText: "amount"),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: _controller,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        RaisedButton(
                          color: Colors.red,
                          child: Text("withdraw"),
                          onPressed: () {
                            setState(() {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red[200],
                                  content: Text(
                                    "₦${_controller.text} for ${a.accountName} withrawn",
                                    style: TextStyle(color: Colors.black87),
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              a.accountBalance -=
                                  double.parse(_controller.text);
                              a.time = DateTime.now();

                              Box<Account> accountBox =
                                  Hive.box<Account>(accountBoxName);
                              accountBox.putAt(index, a);

                              _controller.clear();
                              Navigator.pop(context);
                            });
                          },
                        ),
                        SizedBox(width: 60.0),
                        RaisedButton(
                          color: Colors.green,
                          child: Text("deposit"),
                          onPressed: () {
                            setState(() {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green[200],
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    "deposit of ₦ ${_controller.text} for ${a.accountName} recieved",
                                    style: TextStyle(color: Colors.black87),
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              a.accountBalance +=
                                  double.parse(_controller.text);
                              a.time = DateTime.now();
                              a.deposit = double.parse(_controller.text);
                              Box<Account> accountBox =
                                  Hive.box<Account>(accountBoxName);
                              accountBox.putAt(index, a);

                              _controller.clear();
                              Navigator.pop(context);
                            });
                          },
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                margin: EdgeInsets.all(10.0),
                shadowColor: Colors.black,
                elevation: 15.0,
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    key: widget.key,
                    leading: Icon(
                      Icons.person,
                      color: Colors.brown[700],
                    ),
                    title: Text(" ${a.accountName}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      a.accountNumber.toString(),
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      a.accountBalance.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: a.accountBalance < 0.0
                              ? Colors.red[800]
                              : Colors.green[800]
                          //_color(a.accountBalance),
                          ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class AccountSearch extends SearchDelegate<Account> {
  TextEditingController _controller = TextEditingController();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, null);
        });
  }

  String selectedResult;
  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  List<Account> accountList = List();

  Box box = Hive.box<Account>(accountBoxName);

  List<Account> suggestionList = [];
  @override
  Widget buildSuggestions(BuildContext context) {
    query.isEmpty
        ? suggestionList = accountList
        : suggestionList.addAll(box.values.where(
            (element) => element.accountName.startsWith(query),
          ));

    return suggestionList.isEmpty
        ? Center(child: Text("    no data found\n \nenter names to search"))
        : ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              var a = suggestionList[index];
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    child: Container(
                      color: Colors.yellow[100],
                      height: 100,
                      width: 200,
                      child: AlertDialog(
                        actionsOverflowButtonSpacing: 10.0,
                        actionsPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        title: Text("transaction window"),
                        content: Column(
                          children: <Widget>[
                            Text("${a.accountName} ${a.accountNumber}"),
                            TextField(
                              autofocus: true,
                              decoration: InputDecoration(hintText: "amount"),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              controller: _controller,
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          RaisedButton(
                            color: Colors.red,
                            child: Text("withdraw"),
                            onPressed: () {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                      "₦${_controller.text} for ${a.accountName} withrawn"),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              a.accountBalance -=
                                  double.parse(_controller.text);
                              Box<Account> accountBox =
                                  Hive.box<Account>(accountBoxName);
                              accountBox.putAt(index, a);

                              _controller.clear();
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 60.0),
                          RaisedButton(
                            color: Colors.green,
                            child: Text("deposit"),
                            onPressed: () {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                      "deposit of ₦ ${_controller.text} for ${a.accountName} recieved"),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              a.accountBalance +=
                                  double.parse(_controller.text);
                              Box<Account> accountBox =
                                  Hive.box<Account>(accountBoxName);
                              accountBox.putAt(index, a);

                              _controller.clear();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  margin: EdgeInsets.all(10.0),
                  shadowColor: Colors.black,
                  elevation: 15.0,
                  color: Colors.blueGrey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.brown[700],
                      ),
                      title: Text(" ${a.accountName}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        a.accountNumber.toString(),
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        a.accountBalance.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: a.accountBalance < 0.0
                              ? Colors.red[800]
                              : Colors.green[800],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class MyValueNotifier {}
