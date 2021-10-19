import 'package:classified_app/screens/my_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classified_app/screens/add_list.dart';
import 'package:classified_app/screens/profile.dart';
import 'package:classified_app/screens/create_ad.dart';
import '../services/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  TextEditingController _nameUpdate = TextEditingController();
  TextEditingController _emailUpdate = TextEditingController();
  TextEditingController _mobileUpdate = TextEditingController();
  TextEditingController _imageUpdate = TextEditingController();

  Auth _auth = Get.put(Auth());
  var _user = {};

  getProfile() async {
    try {
      var token = _auth.token.value;
      print(token);

      http.post(Uri.parse("https://adlisting.herokuapp.com/user/profile"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }).then((res) {
        print(res.body);
        var resp = json.decode(res.body);
        setState(() {
          _user = resp["data"];
          _nameUpdate.text = _user['name'];
          _emailUpdate.text = _user['email'];
          _mobileUpdate.text = _user['mobile'];
          _imageUpdate.text = _user['imgURL'];
        });

        print(resp);
        // setState(() {
        //   _user = resp["data"];
        // });
      }).catchError((e) {
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
        title: Text("Settings"),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueGrey.shade200),
          onPressed: () => Get.to(Adds()),
        ),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => Get.to(Profile()),
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                child: ClipOval(
                  child: Image.network(
                    _user['imgURL'],
                  ),
                ),
              ),
              title: Row(
                children: [
                  Text(_user['name']),
                ],
              ),
              subtitle: Text(_user['mobile']),
              trailing: Text(
                "Edit",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(MyAds()),
            child: ListTile(
                leading: Icon(
                  Icons.post_add,
                  size: 27.0,
                ),
                title: Text("My Ads")),
          ),
          ListTile(
              leading: Icon(
                Icons.person,
                size: 27.0,
              ),
              title: Text("About Us")),
          ListTile(
              leading: Icon(
                Icons.contacts,
                size: 27.0,
              ),
              title: Text("Contact Us")),
        ],
      ),
    );
  }
}
