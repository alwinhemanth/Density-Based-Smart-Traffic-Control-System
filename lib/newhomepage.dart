import 'package:google_fonts/google_fonts.dart';


import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';

import 'package:permission_handler/permission_handler.dart';
import 'package:trafficdencity/main.dart';
import 'package:trafficdencity/police%20view%20island.dart';
import 'package:trafficdencity/police%20view%20traffic%20dencity.dart';
import 'package:trafficdencity/traffic%20police%20change%20password.dart';
import 'package:trafficdencity/view%20notification.dart';

import 'POLICE PROFILE.dart';
import 'chat.dart';
import 'components/curve.dart';
import 'edit profile.dart';
import 'login.dart';


void main() {
  runApp(const NewHome());
}

class NewHome extends StatelessWidget {
  const NewHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NewHomePolicePage(title: 'Home'),
    );
  }
}

class NewHomePolicePage extends StatefulWidget {
  const NewHomePolicePage({super.key, required this.title});

  final String title;

  @override
  State<NewHomePolicePage> createState() => _NewHomePolicePageState();
}

class _NewHomePolicePageState extends State<NewHomePolicePage> {

  _NewHomePolicePageState()
  {
    _send_data();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0.0,
            leadingWidth: 0.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'HOME',
                  style: GoogleFonts.poppins(
                    color: kDarkGreenColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              ],
            ),
          ),

          body: Container(color: Colors.white54,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // CircleAvatar(
                    //   maxRadius: 65,
                    //   backgroundImage: NetworkImage(photo_),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: IconButton(
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyEditPolicePage(
                                        title: 'Edit'),
                              ));
                        },
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 18,
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name_,
                      style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(email_)],
                ),
                const SizedBox(
                  height: 15,
                ),
               const SizedBox(
                  height: 15,
                ),
                Container(
                  child: Expanded(
                      child: ListView(
                        children: [
                          Card(
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            color: Colors.white70,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child:  ListTile(
                              onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePolicePage(title: "Profile")));
                              },
                              leading: Icon(
                                Icons.privacy_tip_sharp,
                                color: Colors.black54,
                              ),
                              title: Text(
                                'View Profile',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyChatPage(title: 'Chat',)));
                              },
                              leading: Icon(
                                Icons.chat,
                                color: Colors.black54,
                              ),
                              title: Text(
                                'Chat',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child:  ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewNotification(title: "Notification")));
                              },
                              leading:
                              Icon(Icons.help_outline, color: Colors.black54),
                              title: Text(
                                'Notification',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UserChangePassword(title: "Password")));

                              },
                              leading: Icon(
                                Icons.password,
                                color: Colors.black54,
                              ),
                              title: Text(
                                'Change Password',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewIslandPolicePage(title: "Islands")));
                              },
                              leading: Icon(
                                Icons.place,
                                color: Colors.black54,
                              ),
                              title: Text(
                                'Island',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewDensityPolicePage(title: "Density")));
                              },
                              leading: Icon(
                                Icons.density_large,
                                color: Colors.black54,
                              ),
                              title: Text(
                                'Density',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyLoginPage(title: "Login")));
                              },
                              leading: Icon(
                                Icons.logout,
                                color: Colors.black54,
                              ),
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
      ),
    );
  }

  String name_ = "";
  String email_ = "";
  String phone_ = "";
  String place_ = "";
  String pin_ = "";
  String district_ = "";

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/view_police_profile/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {

          String name = jsonDecode(response.body)['name'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'];
          String place = jsonDecode(response.body)['place'];
          String pin = jsonDecode(response.body)['pin'];
          String district = jsonDecode(response.body)['district'];

          setState(() {
            name_ = name;
            email_ = email;
            phone_ = phone;
            place_ = place;
            pin_ = pin;
            district_ = district;
          });

        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}
