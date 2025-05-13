import 'dart:async';

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
      home: const MyViewDensityPage(title: 'Reply'),
    );
  }
}

class MyViewDensityPage extends StatefulWidget {
  const MyViewDensityPage({super.key, required this.title});

  final String title;

  @override
  State<MyViewDensityPage> createState() => _MyViewDensityPageState();
}

class _MyViewDensityPageState extends State<MyViewDensityPage> {

  _MyViewDensityPageState(){
    Timer.periodic(Duration(seconds: 20), (_) {
      MyIsland();
    });

  }

  List<String> id_ = <String>[];
  List<String> island_= <String>[];
  List<String> dencity_= <String>[];
  List<String> date_= <String>[];

  Future<void> MyIsland() async {
    List<String> id = <String>[];
    List<String> island = <String>[];
    List<String> dencity = <String>[];
    List<String> date = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_island_density/';

      var data = await http.post(Uri.parse(url), body: {'lid':lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        island.add(arr[i]['island']);
        dencity.add(arr[i]['dencity']);
        date.add(arr[i]['date']);
      }

      setState(() {
        id_ = id;
        island_ = island;
        dencity_ = dencity;
        date_ = date;
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
          backgroundColor: Colors.white,
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
                                        Text(" Date",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),),
                                        Text(date_[index],
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
                                        Text("Island",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white

                                            ,
                                          ),),
                                        Text(island_[index],
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
                                        Text("Density",
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white
                                            ,
                                          ),),
                                        Text(dencity_[index],
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