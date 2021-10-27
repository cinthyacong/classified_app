import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth.dart';
import 'package:classified_app/screens/create_ad.dart';
import 'package:classified_app/screens/settings.dart';
import 'package:classified_app/screens/contact_seller.dart';

class Adds extends StatefulWidget {
  Adds({Key? key}) : super(key: key);

  _AddsState createState() => _AddsState();
}

class _AddsState extends State<Adds> {
  @override
  void initState() {
    getAdds();
    super.initState();
  }

  Auth _auth = Get.put(Auth());
  List _adds = [];

  getAdds() async {
    try {
      var token = _auth.token.value;
      print(token);

      http.get(Uri.parse("https://adlisting.herokuapp.com/ads"), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      }).then((res) {
        print(res.body);
        var resp = json.decode(res.body);
        setState(() {
          _adds = resp["data"];
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
          titleSpacing: 0.0,
          backgroundColor: Colors.black,
          elevation: 0,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Text(
                      "Ads Listing",
                      style: TextStyle(fontSize: 18),
                    )),
                GestureDetector(
                  onTap: () => Get.to(Settings()),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 8, 10, 8),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage("https://picsum.photos/200"),
                    ),
                    decoration: new BoxDecoration(
                      border: new Border.all(),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(50.0)),
                    ),
                  ),
                ),
              ],
            ),
          )),
      body: GridView.builder(
        itemCount: _adds.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () => Get.to(ContactDetail(
              imgURL: _adds[index]['images'],
              // id: _adds[index]['_id'],
              title: _adds[index]['title'],
              description: _adds[index]['description'],
              price: _adds[index]['price'].toString(),
              authorName: _adds[index]['authorName'],
            )),
            child: Stack(
              children: [
                Align(
                  // alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: double.infinity,
                    width: double.infinity,
                    child: Image.network(
                      _adds[index]['images'][0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    color: Colors.black.withOpacity(0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    _adds[index]['title'],
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: Container(
                                  margin: EdgeInsets.only(top: 2, left: 5),
                                  child: Text(
                                    _adds[index]['price'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add_a_photo_outlined),
        onPressed: () => Get.to(CreateAd()),
      ),
    );
  }
}



// child: Image.network(
//                 _adds[index]['images'][0],
//                 fit: BoxFit.fill,
//               ),


// return GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//         ),
//         itemCount: _ads.length,
//         itemBuilder: (BuildContext context, index) {
//           return AdCardWidget(
//               title: _ads[index]['title'],
//               price: _ads[index]['price'],
//               image: _ads[index]['images'][0]);
//         });