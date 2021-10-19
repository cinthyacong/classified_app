// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  var URL = "https://reqres.in/api/users?page=2";
  List _users = [];

  getContactFormNetwork() async {
    try {
      http.get(Uri.parse(URL)).then((res) {
        print("Success");
        print(res.body);
        var resp = json.decode(res.body);
        setState(() {
          _users = resp["data"];
        });
        print(_users);
      }).catchError((e) {
        print("Error");
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Network Request"),
          actions: [
            IconButton(
                onPressed: () {
                  getContactFormNetwork();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: Container(
            child: _users.length == 0
                ? Text("please a request")
                : ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (bc, index) {
                      return ListTile(
                        title: Text("${_users[index]['first_name']}"),
                      );
                    },
                  )));
  }
}
