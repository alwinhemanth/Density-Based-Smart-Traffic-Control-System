import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafficdencity/user/send%20complaint.dart';
import 'package:trafficdencity/user/user%20view%20island.dart';
import 'package:trafficdencity/user/user%20view%20notification.dart';
import 'package:trafficdencity/user/user%20view%20traffic%20dencity.dart';
import 'package:trafficdencity/user/view%20reply.dart';
import 'package:trafficdencity/user/view%20user%20profile.dart';

import '../login.dart';
import '../main.dart';
import '../nearest_siganl.dart';
import '../traffic police change password.dart';
import 'edit profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RTO',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const  MyuserHomePage(title: 'Traffic '),
    );
  }
}

class MyuserHomePage extends StatefulWidget {
  const  MyuserHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyuserHomePage> createState() => _MyuserHomePageState();
}

class _MyuserHomePageState extends State<MyuserHomePage> {
  _MyuserHomePageState()
  {
    _send_data();
  }

  String name_="";
  String gender_="";
  String dob_="";
  String email_="";
  String phone_="";
  String pin_="";
  String place_="";
  String city_="";
  String state_="";
  String district_="";
  String semester_="";
  String photo_="";
  String post_="";

  void _send_data() async{





    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/view_profile/');
    try {
      final response = await http.post(urls, body: {

        'lid':lid,



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          String name = jsonDecode(response.body)['name'];
          String gender = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'];
          String district= jsonDecode(response.body)['district'];
          String place = jsonDecode(response.body)['place'];
          String state = jsonDecode(response.body)['state'];
          String photo = sh.getString("img_url").toString()+
              jsonDecode(response.body)['photo'];
          String dob=jsonDecode(response.body)['dob'];
          String pin=jsonDecode(response.body)['pin'];
          String post=jsonDecode(response.body)['post'];

          setState(() {
            name_=name;
            gender_=gender;
            email_=email;
            phone_=phone;
            district_=district;
            place_=place;
            state_=state;
            photo_=photo;
            dob_=dob;
            pin_=pin;
            post_=post;






          });

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






  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // actions: [IconButton(
          //   icon: const Icon(Icons.logout),
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(
          //       builder: (context) => MyLoginPage(title: ""),));
          //   },
          // ),],
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,


          title: Text(widget.title),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF184A2C),
                ),
                child:
                Column(children: [

                  Text(
                    'Traffic Density',
                    style: TextStyle(fontSize: 20,color: Colors.white),

                  ),
                  // CircleAvatar(  radius: 50,backgroundImage: AssetImage('assets/img.png')
                  // ),
                  // radius: 29,backgroundImage: NetworkImage('')


                ])


                ,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('User Home Page'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNew(),));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.person),
              //   title: const Text(' Profile'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(title: 'Profile',),));
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.place),
                title: const Text('  Islands'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewIslandPage(title: 'Islands',),));
                },
              ),
              ListTile(
                leading: Icon(Icons.density_large),
                title: const Text('  Density'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewDensityPage(title: 'Density',),));
                },
              ),

              ListTile(
                leading: Icon(Icons.signal_cellular_0_bar),
                title: const Text('  Signal'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LocationFetchScreen(),));
                },
              ),

              ListTile(
                leading: Icon(Icons.notifications),
                title: const Text('  Notifications'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewUserNotification(title: 'Notification',),));
                },
              ),

              ListTile(
                leading: Icon(Icons.password),
                title: const Text(' Change Password '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserChangePassword(title: "Change Password"),));
                },
              ),
              ListTile(
                leading: Icon(Icons.reply),
                title: const Text(' Reply'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewReplyPage(title: 'Reply',),));
                },
              ),

              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MyLoginPage(title: 'MyLoginPage',),));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MyIpPage(title: 'Home',)),(route) => false);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(
                  photo_,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 240.0, 16.0, 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                              color: Color(0xFF184A2C),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 110.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [

                                          Text("  "+name_,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),),
                                          // Text(
                                          //   '$email',
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .bodyText1,
                                          // ),
                                          SizedBox(
                                            height: 40,
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      // CircleAvatar(
                                      //   backgroundColor: Colors.blueAccent,
                                      //   child: IconButton(
                                      //       onPressed: () {
                                      //         // Navigator.push(context, MaterialPageRoute(builder: (context) => (title: "Edit Profile",),));
                                      //       },
                                      //       icon: Icon(
                                      //         Icons.edit_outlined,
                                      //         color: Colors.white,
                                      //         size: 18,
                                      //       )),
                                      // )
                                    ],
                                  )),
                              SizedBox(height: 10.0),
                              Row(
                                children: [

                                  // Expanded(
                                  //   child: Column(
                                  //     children: const [Text("1.68"), Text("Meter")],
                                  //   ),
                                  // ),
                                  // Expanded(
                                  //   child: Column(
                                  //     children: const [Text("49"), Text("Weight")],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image:  DecorationImage(
                                  image: NetworkImage(
                                      photo_),
                                  fit: BoxFit.cover)),
                          margin: EdgeInsets.only(left: 20.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children:  [
                          ListTile(
                            title: Text("Profile Information",textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black,),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('Gender:',
                              textAlign: TextAlign.start,

                              style: TextStyle(
                                fontWeight: FontWeight.bold,

                                fontSize: 20.0,
                                color: Colors.black,
                              ),),

                            subtitle: Text("  "+gender_,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),),
                          ),            Divider(),
                          ListTile(

                            title: Text('Phone:',
                              textAlign: TextAlign.start,

                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                                ,

                              ),),
                            subtitle: Text("  "+phone_,
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black
                                ,
                              ),),
                          ),            Divider(),
                          SizedBox(
                            height: 10,
                          ),


                          ListTile(
                            title: Text('Email:',
                              textAlign: TextAlign.start,

                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black
                                ,
                                fontWeight: FontWeight.bold,

                              ),),
                            subtitle: Text("  "+email_,
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black
                                ,


                              ),),

                          ),            Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text('Address:',
                              textAlign: TextAlign.start,

                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black
                                ,
                              ),),
                            subtitle: Text("  "+district_+","+place_
                                +","+city_+","+state_+","+pin_+","+post_,
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black
                                ,
                              ),),
                          ),            Divider(),

                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text('Dob:',
                              textAlign: TextAlign.start,

                              style: TextStyle(
                                fontWeight: FontWeight.bold,

                                fontSize: 20.0,
                                color: Colors.black
                                ,
                              ),),
                            subtitle: Text("  "+dob_,
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black
                                ,
                              ),),
                          ),            Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyEditPage(title: " Logout",),));
                          } ,
                            style:ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF184A2C) ,
                            ), child: Text('Edit Profile', style: TextStyle(color: Colors.white)

                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),


      ),
    );
  }
}