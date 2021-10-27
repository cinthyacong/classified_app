import 'package:classified_app/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth.dart';
import 'package:classified_app/screens/login.dart';
import 'package:classified_app/screens/settings.dart';
import 'package:classified_app/screens/edit_ad.dart';

class MyAds extends StatefulWidget {
  const MyAds({Key? key}) : super(key: key);

  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  @override
  void initState() {
    getMyAdds();
    super.initState();
  }

  Auth _auth = Get.put(Auth());
  List _ads = [];

  getMyAdds() async {
    try {
      var token = _auth.token.value;
      print(token);

      http.post(Uri.parse("https://adlisting.herokuapp.com/ads/user"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }).then((res) {
        print(res.body);
        var resp = json.decode(res.body);
        setState(() {
          _ads = resp["data"];
        });
        print(resp);
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
        title: Text("My Ads"),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueGrey.shade200),
          onPressed: () => Get.to(Settings()),
        ),
      ),
      body: Container(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _ads.length,
          itemBuilder: (bc, index) {
            return GestureDetector(
                onTap: () => Get.to(EditAd(
                    imgURL: _ads[index]['images'],
                    user: _ads[index]['_id'],
                    title: _ads[index]['title'],
                    description: _ads[index]['description'],
                    price: _ads[index]['price'].toString(),
                    mobile: _ads[index]['mobile'])),
                child: Card(
                    child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 70,
                      width: 70,
                      child: Image.network(_ads[index]['images'][0],
                          fit: BoxFit.cover),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _ads[index]['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Row(
                            children: [
                              Icon(Icons.timer_outlined),
                              Text(
                                "8 days ago",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(_ads[index]['price'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.orange)),
                      ],
                    ),
                  ],
                )));
          },
        ),
      ),
    );
  }
}
