import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafficdencity/user/user%20home.dart';

import '../login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaints',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MySendComplaints(title: 'complaint'),
    );
  }
}

class MySendComplaints extends StatefulWidget {
  const MySendComplaints({super.key, required this.title});



  final String title;

  @override
  State<MySendComplaints> createState() => _MySendComplaintsState();
}

class _MySendComplaintsState extends State<MySendComplaints> {
  TextEditingController complaintcontroller=new TextEditingController();
  final _formKey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => MyLoginPage(title: ""),));
          },
        ),],
        backgroundColor: Color.fromARGB(255, 18, 82, 98),        foregroundColor: Colors.white,

        title: Text(widget.title),
      ),
      // appBar: AppBar(
      //
      //   backgroundColor: Colors.brown,
      //   foregroundColor: Colors.orange[700],
      //
      //   title: Text(widget.title),
      // ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage('assets/Outdoor_99D_B022_100365510.jpg'), fit: BoxFit.cover),
        // ),
        child: Center(

          child: Form(
            key: _formKey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(

                  padding: EdgeInsets.all(10,),
                  child: TextFormField(
                    maxLines: 8,


                    validator: (value) => Validatecomplaints(value!),

                    controller: complaintcontroller,
                    decoration: InputDecoration(border: OutlineInputBorder(),

                      labelText: 'Write your Complaint here',
                      fillColor: Colors.grey.shade300,

                      filled: true,
                    ),
                  ),
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF184A2C),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        sendata();}}, child: Text('Send'))

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyuserHomePage(title: 'home')));

      },
          backgroundColor:   Color(0xFF184A2C),        child: Icon(Icons.home_filled),
      ),

    );
  }
  void sendata()async{
    String complaint=complaintcontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_complaint_post/');
    try {
      final response = await http.post(urls, body: {
        'complaint':complaint,
        'lid':sh.getString("lid").toString(),

      });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(status);
        if (status=='ok') {


          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyuserHomePage(title: "Home"),));
        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }
  String? Validatecomplaints(String value){
    if(value.isEmpty){
      return 'please enter your complaints';
    }
    return null;
  }
}
