import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:thrift_service/account_model/account_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../account_model/account_model.dart';

class AddAccount extends StatefulWidget {
  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  @override
  Widget build(BuildContext context) {
    Widget _buildDivider() => const SizedBox(height: 5);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "add new account",
          style: TextStyle(fontFamily: "Pacifico", fontSize: 30.0),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Account>(accountBoxName).listenable(),
        builder: (context, Box<Account> box, _) {
          if (box.values.isEmpty)
            return Center(
              child: Text("No contacts"),
            );
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Account a = box.getAt(index);
                String salesCategory = salesCategories[a.salesCategory];
                return InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      child: AlertDialog(
                        content: Text(
                          "Do you want to delete ${a.accountName}?",
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("No"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          FlatButton(
                            child: Text("Yes"),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await box.deleteAt(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    shadowColor: Colors.tealAccent,
                    elevation: 15.0,
                    color: Colors.teal[100],
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _buildDivider(),
                          Text(" ${a.accountName.toUpperCase()}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          _buildDivider(),
                          Text("Account Number: ${a.accountNumber}"),
                          _buildDivider(),
                          Text("Phone Number: ${a.phoneNumber}"),
                          _buildDivider(),
                          Text("sales Category: $salesCategory"),
                          _buildDivider(),
                          Text("account Balance: ${a.accountBalance}"),
                          _buildDivider(),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddContact()),
              );
            },
          );
        },
      ),
    );
  }
}

class AddContact extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String accountName;
  num accountNumber;
  String phoneNumber;
  SalesCategory salesCategory;
  double accountBalance;

  void onFormSubmit() {
    if (widget.formKey.currentState.validate()) {
      Box<Account> accountBox = Hive.box<Account>(accountBoxName);
      accountBox.add(Account(accountName, accountNumber, phoneNumber,
          salesCategory, accountBalance));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: widget.formKey,
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              TextFormField(
                autofocus: true,
                initialValue: "",
                decoration: const InputDecoration(
                  labelText: "AccountName",
                ),
                onChanged: (value) {
                  setState(() {
                    accountName = value;
                  });
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: "",
                decoration: const InputDecoration(
                  labelText: "accountNumber",
                ),
                onChanged: (value) {
                  setState(() {
                    accountNumber = int.parse(value);
                  });
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: "",
                decoration: const InputDecoration(
                  labelText: "initial Deposit",
                ),
                onChanged: (value) {
                  setState(() {
                    accountBalance = double.parse(value);
                  });
                },
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                initialValue: "",
                decoration: const InputDecoration(
                  labelText: "Phone",
                ),
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
              ),
              DropdownButtonFormField(
                items: salesCategories.keys.map((SalesCategory value) {
                  return DropdownMenuItem<SalesCategory>(
                    value: value,
                    child: Text(salesCategories[value]),
                  );
                }).toList(),
                value: salesCategory,
                hint: Text("salesCategory"),
                onChanged: (value) {
                  setState(() {
                    salesCategory = value;
                  });
                },
              ),
              RaisedButton(
                splashColor: Colors.greenAccent,
                color: Colors.blueGrey[100],
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: onFormSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
