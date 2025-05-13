import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafficdencity/login.dart';
import 'package:trafficdencity/user/send%20complaint.dart';
import 'package:trafficdencity/user/user%20home.dart';


void main() {
  runApp(const MyIsland());
}

class MyIsland extends StatelessWidget {
  const MyIsland({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reply',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF184A2C)),
        useMaterial3: true,
      ),
      home: const MyViewIslandPage(title: 'Reply'),
    );
  }
}

class MyViewIslandPage extends StatefulWidget {
  const MyViewIslandPage({super.key, required this.title});

  final String title;

  @override
  State<MyViewIslandPage> createState() => _MyViewIslandPageState();
}

class _MyViewIslandPageState extends State<MyViewIslandPage> {

  _MyViewIslandPageState(){
    MyIsland();
  }

  List<String> id_ = <String>[];
  List<String> place_= <String>[];
  List<String> latitude_= <String>[];
  List<String> longitude_= <String>[];
  List<String> description_= <String>[];

  Future<void> MyIsland() async {
    List<String> id = <String>[];
    List<String> place = <String>[];
    List<String> latitude = <String>[];
    List<String> longitude = <String>[];
    List<String> description = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_island/';

      var data = await http.post(Uri.parse(url), body: {'lid':lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        place.add(arr[i]['place']);
        latitude.add(arr[i]['latitude']);
        longitude.add(arr[i]['longitude']);
        description.add(arr[i]['description']);
      }

      setState(() {
        id_ = id;
        place_ = place;
        latitude_ = latitude;
        longitude_ = longitude;
        description_ = description;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyuserHomePage(title: 'home')),);

          },),

          // actions: [IconButton(
          //   icon: const Icon(Icons.logout),
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(
          //       builder: (context) => MyLoginPage(title: ""),));
          //   },
          // ),],
          backgroundColor:  Colors.white,
          foregroundColor: Colors.black,

          title: Text(widget.title),
        ),

        body: Container(decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage('assets/'), fit: BoxFit.cover),
        ),
          child: ListView.builder(

            physics: BouncingScrollPhysics(),
            // padding: EdgeInsets.all(5.0),
            // shrinkWrap: true,
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onLongPress: () {
                  print("long press" + index.toString());
                },
                title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          elevation: 500,
                          shadowColor: Colors.black,
                          color:   Color(0xFF184A2C),
                          child:
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(" Island",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),),
                                        Text(place_[index],
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Lattitude",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white

                                            ,
                                          ),),
                                        Text(latitude_[index],
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white

                                            ,
                                          ),)
                                      ],
                                    ),
                                  ),    Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Longitude",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),),
                                        Text(longitude_[index],
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Description",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),),
                                        Text(description_[index],
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),)
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.all(5),
                                  //   child: Text("Status:  "+status_[index]),
                                  // ),
                                ],
                              ),
                            ),
                          ),

                          margin: EdgeInsets.all(10),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MySendComplaints(title: 'home')));

        },
          child: Icon(Icons.comment),
          backgroundColor: Color(0xFF184A2C),
        ),


      ),
    );
  }
}