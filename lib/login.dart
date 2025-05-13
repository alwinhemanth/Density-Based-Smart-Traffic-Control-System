

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:trafficdencity/main.dart';
import 'package:trafficdencity/user/signup.dart';
import 'package:trafficdencity/user/user%20home.dart';

import 'newhomepage.dart';
// import 'home.dart';
// import 'location.dart';
// import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLoginPage(title: 'Login'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {


  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey=GlobalKey<FormState>();

    return WillPopScope(
      onWillPop: ()async {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MyuserHomePage(title: ""),));
        return false;
      },
      child: Scaffold(
        // backgroundColor:  Color(0xFFBB4623),

        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage('assets/img.png'), fit: BoxFit.cover),
          // ),


          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Icon Logo

                      // const CircleAvatar(
                      //   backgroundImage: AssetImage('assets/2422197.jpg'),
                      //   radius: 60.0,
                      // ),

                      const SizedBox(height: 5.0,),





                      const Text('Welcome back',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),

                      const SizedBox(height: 40.0,),

                      //email text field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),

                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:  Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              validator: (value) => Validateusername(value!),
                              controller: nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20.0,),

                      //password text field
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              obscureText: true,
                              validator: (value) => Validatepassword(value!),
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                              ),
                            ),
                          ),
                        ),
                      ),



                      //login button
                      const SizedBox(height: 20.0,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(234, 100, 68, 28),
                            // color:  Color.fromARGB(234, 100, 68, 28),

                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if(_formKey.currentState!.validate()) {
                              _send_data();
                            }
                          },
                          child:
                          Text('Login')


                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MyMySignupPage(title: "Signup",),));
                      }, child: Text('Signup', style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ))
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
  void _send_data() async{

    String username=nameController.text;
    String password=passwordController.text;

    SharedPreferences sh=await SharedPreferences.getInstance();
    String url=sh.getString('url').toString();

    final urls=Uri.parse('$url/user_login_post/');
    try {
      final response = await http.post(urls, body: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];

        if (status == 'ok') {
          String type = jsonDecode(response.body)['type'];
          String lid = jsonDecode(response.body)['lid'];
          sh.setString('lid', lid);
          if(type=='user') {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  MyuserHomePage(title: 'Home Page ',)
              ,));
          }else if(type=='police'){
            // String typee = jsonDecode(response.body)['type'];
            // String lidd = jsonDecode(response.body)['lid'];
            // String bid = jsonDecode(response.body)['bid'];
            // SharedPreferences sh = await SharedPreferences.getInstance();
            // sh.setString("bid",bid);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => sapp()));
            Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  NewHomePolicePage(title: 'Traffic Police',)
              ,));


          }
        }
        else {
          Fluttertoast.showToast(msg: 'not found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Invalid');
      }
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString());


    }

  }
  String? Validateusername(String value){
    if(value.isEmpty){
      return 'please enter a username';
    }
    return null;
  }
  String? Validatepassword(String value){
    if(value.isEmpty){
      return 'please enter a password';
    }
    return null;
  }

}