import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth.dart';
import 'package:classified_app/screens/login.dart';
import 'package:classified_app/screens/add_list.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();

  Auth _auth = Get.put(Auth());

  register() {
    var body = json.encode({
      "name": _nameCtrl.text,
      "email": _emailCtrl.text,
      "password": _passwordCtrl.text,
      "mobile": _mobileCtrl.text
    });
    print(_emailCtrl.text);

    http
        .post(Uri.parse("https://adlisting.herokuapp.com/auth/register"),
            headers: {
              "Content-Type": "application/json",
            },
            body: body)
        .then((res) {
      print(res.body);
      var resp = json.decode(res.body);
      print(resp["data"]["token"]);
      _auth.token.value = resp["data"]["token"];
      Get.offAll(Adds());
      // _auth.token = resp["data"]["token"];
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            child: Center(
                child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          height: 300,
                          width: double.infinity,
                          child: Image.network(
                              "https://i.postimg.cc/yJrkHqD9/background.png",
                              fit: BoxFit.cover)),
                      Container(
                        child: Image.network(
                            "https://i.postimg.cc/ZBB0YfNQ/logo.png"),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _nameCtrl,
                            style: TextStyle(color: Colors.black),
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black26)),
                              labelText: 'Full Name',
                              labelStyle: TextStyle(color: Colors.black26),
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              height: 30,
                            ),
                          ),
                          TextField(
                            controller: _emailCtrl,
                            style: TextStyle(color: Colors.black),
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black26)),
                              labelText: 'Email Address',
                              labelStyle: TextStyle(color: Colors.black26),
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              height: 30,
                            ),
                          ),
                          TextField(
                            controller: _mobileCtrl,
                            style: TextStyle(color: Colors.black),
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black26)),
                              labelText: 'Mobile Number',
                              labelStyle: TextStyle(color: Colors.black26),
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              height: 30,
                            ),
                          ),
                          TextField(
                            controller: _passwordCtrl,
                            style: TextStyle(color: Colors.black),
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black26)),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black26),
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              height: 30,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepOrange,
                                minimumSize: Size(double.infinity, 50)),
                            onPressed: () {
                              register();
                            },
                            child: Text(
                              'Register Now',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                minimumSize: Size(double.infinity, 50)),
                            onPressed: () => Get.to(Login()),
                            child: Text(
                              "Already have an account?",
                              style: TextStyle(
                                  color: Colors.deepOrange, fontSize: 15),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ))),
      ),
    );
  }
}
