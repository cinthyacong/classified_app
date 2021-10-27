import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth.dart';
import 'package:classified_app/screens/login.dart';
import 'package:classified_app/screens/add_list.dart';
import 'package:classified_app/screens/profile.dart';
import 'package:image_picker/image_picker.dart';

class CreateAd extends StatefulWidget {
  // CreateAd({Key? key}) : super(key: key);

  CreateAdState createState() => CreateAdState();
}

class CreateAdState extends State<CreateAd> {
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _descriptionCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  // TextEditingController _imagesCtrl = TextEditingController();

  var imagesUpload = [];

  Auth _auth = Get.put(Auth());
  uploadMultiple() async {
    try {
      var images = await ImagePicker().pickMultiImage();
      var request = http.MultipartRequest(
          'POST', Uri.parse("https://adlisting.herokuapp.com/upload/photos"));
      images!.forEach((image) async {
        request.files.add(
          await http.MultipartFile.fromPath(
            'photos',
            image.path,
          ),
        );
      });
      var response = await http.Response.fromStream(await request.send());
      var data = json.decode(response.body);
      setState(() {
        imagesUpload = data['data']['path'];
      });
    } catch (e) {}
  }

  createAd() async {
    var body = json.encode({
      "title": _titleCtrl.text,
      "description": _descriptionCtrl.text,
      "price": _priceCtrl.text,
      "mobile": _mobileCtrl.text,
      "images": imagesUpload,
    });

    try {
      var token = _auth.token.value;
      await http
          .post(
        Uri.parse(
          "https://adlisting.herokuapp.com/ads",
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      )
          .then((res) {
        var data = json.decode(res.body);
        print(data["status"]);
      }).catchError((e) {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueGrey.shade200),
          onPressed: () => Get.to(Adds()),
        ),
        title: Text("Create Ad"),
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
                  IconButton(
                    icon: const Icon(Icons.add_a_photo_outlined),
                    iconSize: 50,

                    // tooltip: 'Increase volume by 10',
                    onPressed: () {
                      uploadMultiple();
                    },
                  ),
                  Text('Tap to Upload'),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Container(
                              height: 30,
                            ),
                          ),
                          TextField(
                            controller: _titleCtrl,
                            style: TextStyle(color: Colors.black),
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black26)),
                              labelText: 'Title',
                              labelStyle: TextStyle(color: Colors.black26),
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              height: 30,
                            ),
                          ),
                          TextField(
                            controller: _priceCtrl,
                            style: TextStyle(color: Colors.black),
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black26)),
                              labelText: 'Price',
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
                              labelText: 'Contact Number',
                              labelStyle: TextStyle(color: Colors.black26),
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              height: 30,
                            ),
                          ),
                          TextField(
                            controller: _descriptionCtrl,
                            style: TextStyle(color: Colors.black),
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black26)),
                              labelText: 'Description',
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
                              createAd();
                              Get.to(Adds());
                            },
                            child: Text(
                              'Submit Ad ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
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
