import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth.dart';
import 'package:classified_app/screens/login.dart';
import 'package:classified_app/screens/add_list.dart';
import 'package:classified_app/screens/profile.dart';
import 'package:image_picker/image_picker.dart';

class CreateAd extends StatelessWidget {
  CreateAd({Key? key}) : super(key: key);

  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _descriptionCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _imagesCtrl = TextEditingController();

  Auth _auth = Get.put(Auth());

//   Future<Album> createAlbum(String title) async {
//   final response = await http.post(
//     Uri.parse('https://adlisting.herokuapp.com/ads'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
// }

  // createAd() {
  //   var body = json.encode({
  //     "title": _titleCtrl.text,
  //     "price": _priceCtrl.text,
  //     "description": _descriptionCtrl.text,
  //     "mobile": _mobileCtrl.text,
  //     // "imgURL": _imageUpdate,
  //   });
  //   print(_titleCtrl.text);

  //   var token = _auth.get();

  //   http
  //       .post(Uri.parse("https://adlisting.herokuapp.com/ads"),
  //           headers: {
  //             "Content-Type": "application/json",
  //             "Authorization": "Bearer $token"
  //           },
  //           body: body)
  //       .then((res) {
  //     print(res.body);
  //     print("create");
  //     var resp = json.decode(res.body);
  //     _auth.set(resp["data"]["token"]);

  //     // print(resp["data"]["token"]);
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  uploadMultiple() async {
    var images = await ImagePicker().pickMultiImage();
    var body = json.encode({
      "title": _titleCtrl.text,
      "price": _priceCtrl.text,
      "description": _descriptionCtrl.text,
      "mobile": _mobileCtrl.text,
      "imgURL": images,
    });
    var token = _auth.get();
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://adlisting.herokuapp.com/ads"));
    request.headers['Authorization'] = 'Bearer $token';

    images!.forEach((image) async {
      request.files.add(await http.MultipartFile.fromPath(
        'uploads',
        image.path,
      ));

      request.fields['title'] = _titleCtrl.text;
      request.fields['price'] = _priceCtrl.text;
      request.fields['description'] = _descriptionCtrl.text;
      request.fields['mobile'] = _mobileCtrl.text;
    });

    var res = await request.send();
    print(res);
    var responseData = await res.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    return res.reasonPhrase;
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
                      // uploadMultiple();
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
                              // createAd();
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
