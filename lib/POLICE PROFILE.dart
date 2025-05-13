import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:trafficdencity/user/user%20home.dart';

import 'edit profile.dart';
import 'newhomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewProfilePolicePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewProfilePolicePage extends StatefulWidget {
  const ViewProfilePolicePage({super.key, required this.title});


  final String title;

  @override
  State<ViewProfilePolicePage> createState() => _ViewProfilePolicePageState();
}

class _ViewProfilePolicePageState extends State<ViewProfilePolicePage> {

  _ViewProfilePolicePageState()
  {
    _send_data();
  }



  String name_="";
  String email_="";
  String phone_="";
  String pin_="";
  String place_="";
  String city_="";
  String district_="";
  String semester_="";
  // String photo_="";
  String post_="";

  void _send_data() async{





    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/view_police_profile/');
    try {
      final response = await http.post(urls, body: {

        'lid':lid,



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          String name = jsonDecode(response.body)['name'];
          // String gender = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'];
          String district= jsonDecode(response.body)['district'];
          String place = jsonDecode(response.body)['place'];
          // String state = jsonDecode(response.body)['state'];
          // String photo = sh.getString("img_url").toString()+
          //     jsonDecode(response.body)['photo'];
          // String dob=jsonDecode(response.body)['dob'];
          String pin=jsonDecode(response.body)['pin'];
          String post=jsonDecode(response.body)['post'];

          setState(() {
            name_=name;
            // gender_=gender;
            email_=email;
            phone_=phone;
            district_=district;
            place_=place;
            // state_=state;
            // photo_=photo;
            // dob_=dob;
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
          backgroundColor: Color.fromARGB(255, 18, 82, 98),
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewHomePolicePage(title: 'Home')),);

          },),

          backgroundColor:Colors.white,
          title: Text(widget.title),
        ),

        body: SingleChildScrollView(
          child: Stack(
            children: [
              // SizedBox(
              //   height: 280,
              //   width: double.infinity,
              //   // child: Image.network(
              //   //   photo_,
              //   //   fit: BoxFit.cover,
              //   // ),
              // ),
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
                        // Container(
                        //   height: 90,
                        //   width: 90,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20.0),
                        //       image:  DecorationImage(
                        //           image: NetworkImage(
                        //               photo_),
                        //           fit: BoxFit.cover)),
                        //   margin: EdgeInsets.only(left: 20.0),
                        // ),
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
                          // ListTile(
                          //   title: Text('Gender:',
                          //     textAlign: TextAlign.start,
                          //
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //
                          //       fontSize: 20.0,
                          //       color: Colors.black,
                          //     ),),
                          //
                          //   subtitle: Text("  "+gender_,
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //       fontSize: 20.0,
                          //       color: Colors.black,
                          //     ),),
                          // ),            Divider(),
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
                                +","+city_+","+pin_+","+post_,
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
                          // ListTile(
                          //   title: Text('Dob:',
                          //     textAlign: TextAlign.start,
                          //
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //
                          //       fontSize: 20.0,
                          //       color: Colors.black
                          //       ,
                          //     ),),
                          //   subtitle: Text("  "+dob_,
                          //     textAlign: TextAlign.center,
                          //
                          //     style: TextStyle(
                          //       fontSize: 20.0,
                          //       color: Colors.black
                          //       ,
                          //     ),),
                          // ),            Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyEditPolicePage(title: "Edit Profile",),));
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
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => MyHomePage(title: 'home')));
        //
        // },
        //   child: Icon(Icons.home),
        //   backgroundColor: Color.fromARGB(255, 18, 82, 98),
        // ),

      ),
    );
  }



}