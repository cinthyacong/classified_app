import 'package:classified_app/screens/add_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditAd extends StatefulWidget {
  List imgURL = [];
  String title = "";
  String description = "";
  String price = "";
  String mobile = "";
  // int id;

  EditAd({
    required this.imgURL,
    required this.title,
    required this.description,
    required this.price,
    required this.mobile,
    // required this.id,

    // required this.user
  });

  _EditAdState createState() => _EditAdState();
}

class _EditAdState extends State<EditAd> {
  @override
  void initState() {
    setState(() {
      _titleUpdate.text = widget.title;
      _descriptionUpdate.text = widget.description;
      _priceUpdate.text = widget.price;
      _mobileUpdate.text = widget.mobile;
    });
    super.initState();
  }

  TextEditingController _titleUpdate = TextEditingController();
  TextEditingController _descriptionUpdate = TextEditingController();
  TextEditingController _priceUpdate = TextEditingController();
  TextEditingController _mobileUpdate = TextEditingController();

  Auth _auth = Get.put(Auth());
  // var _user = {};

  // // String user = "";

  updateProfile() {
    var body = json.encode({
      "title": _titleUpdate.text,
      "price": _priceUpdate.text,
      "mobile": _mobileUpdate.text,
      "description": _descriptionUpdate.text,
      // "imgURL": _imageUpdate,
    });
    print(_titleUpdate.text);

    var token = _auth.get();

    http
        .patch(Uri.parse("https://adlisting.herokuapp.com/ads/:"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
            body: body)
        .then((res) {
      print(res.body);
      print("update");
      var resp = json.decode(res.body);
      _auth.set(resp["data"]["token"]);

      // print(resp["data"]["token"]);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blueGrey.shade200),
            onPressed: () => Get.to(Adds()),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.add_a_photo_outlined),
              iconSize: 50,

              // tooltip: 'Increase volume by 10',
              onPressed: () {
                // uploadMultiple();
              },
            ),
            Text('Tap to Upload'),
            SizedBox(height: 20),
            GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: widget.imgURL.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 70,
                      width: 70,
                      child: Image.network(widget.imgURL[index],
                          fit: BoxFit.cover),
                    )
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(right: 10, left: 10),
              child: Column(
                children: [
                  TextField(
                    controller: _titleUpdate,
                    style: TextStyle(color: Colors.black),
                    decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2.0),
                      ),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black26)),
                      // labelText: '$title',
                      labelStyle: TextStyle(color: Colors.black54),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _priceUpdate,
                    style: TextStyle(color: Colors.black),
                    decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2.0),
                      ),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black26)),
                      // labelText: '$title',
                      labelStyle: TextStyle(color: Colors.black54),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _mobileUpdate,
                    style: TextStyle(color: Colors.black),
                    decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2.0),
                      ),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black26)),
                      // labelText: '$title',
                      labelStyle: TextStyle(color: Colors.black54),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _descriptionUpdate,
                    style: TextStyle(color: Colors.black),
                    decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 2.0),
                      ),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black26)),
                      // labelText: '$title',
                      labelStyle: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
