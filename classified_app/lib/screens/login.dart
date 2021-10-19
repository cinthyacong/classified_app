import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth.dart';
import 'package:classified_app/screens/add_list.dart';
import 'package:classified_app/screens/register.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  Auth _auth = Get.put(Auth());

  login() {
    var body = json.encode({
      "email": _emailCtrl.text,
      "password": _passwordCtrl.text,
    });
    print(_emailCtrl.text);

    http
        .post(Uri.parse("https://adlisting.herokuapp.com/auth/login"),
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
                              login();
                            },
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                minimumSize: Size(double.infinity, 50)),
                            onPressed: () => Get.to(Register()),
                            child: Text(
                              "Don't have any account",
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
