import 'package:classified_app/screens/add_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactDetail extends StatelessWidget {
  String imgURL = "";
  String title = "";
  String description = "";
  String price = "";
  String authorName = "";

  // String user = "";

  ContactDetail(
      {required this.imgURL,
      required this.title,
      required this.description,
      required this.price,
      required this.authorName

      // required this.user
      });

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
            child: Container(
          margin: EdgeInsets.only(right: 10, left: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "$title",
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  "$price",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Center(
                // margin: EdgeInsets.only(left: 20, right: 20),

                child: Image.network('$imgURL',
                    height: 300.0, fit: BoxFit.fitWidth),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  (Icon(Icons.person, size: 14)),
                  Text(
                    '$authorName',
                  ),
                  SizedBox(width: 15),
                  (Icon(Icons.timer, size: 14)),
                  Text(
                    "14 days ago",
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                child: Text('$description'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    minimumSize: Size(double.infinity, 50)),
                onPressed: () {
                  // createAd();
                },
                child: Text(
                  'Contact Seller',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        )));
  }
}
