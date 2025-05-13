import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// import 'Signup.dart';
// import 'home.dart';
import '../login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserChangePassword(title: 'changepassword'),
    );
  }
}

class UserChangePassword extends StatefulWidget {
  const UserChangePassword({super.key, required this.title});



  final String title;

  @override
  State<UserChangePassword> createState() => _UserChangePasswordState();
}

class _UserChangePasswordState extends State<UserChangePassword> {
  TextEditingController currentpasscontroller=new TextEditingController();
  TextEditingController newpasscontroller=new TextEditingController();
  TextEditingController confirmpasscontroller=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final _formKey=GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(

        backgroundColor:   Colors.white,
        foregroundColor: Colors.black,


        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img.png'), fit: BoxFit.cover),
        ),

        child: Form(
          key: _formKey,

          child: Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(

                    validator: (value)=>Validatecurrentpswd(value!),
                    controller: currentpasscontroller,
                    decoration: InputDecoration(border: OutlineInputBorder(),
                      labelText: 'Current Password',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value)=>Validatenewpswd(value!),
                    controller: newpasscontroller,
                    decoration: InputDecoration(border: OutlineInputBorder(),
                      labelText:'New Password' ,
                      fillColor: Colors.white,
                      filled: true,
                    ),

                  ),),
                Padding(padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'please confirm your password';
                      }else if (value!=newpasscontroller.text){
                        return 'password do not match';
                      }
                      return null;

                    },
                    controller: confirmpasscontroller,
                    decoration: InputDecoration(border: OutlineInputBorder(),
                      labelText:'Confirm Password',
                      fillColor: Colors.white,
                      filled: true,),
                  ),),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()) {
                    senddata();
                  }

                }, child: Text('change'))

              ],
            ),
          ),
        ),
      ),

    );
  }
  void senddata()async{
    String currentpswd=currentpasscontroller.text;
    String newpswd=newpasscontroller.text;
    String confrmpswd=confirmpasscontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/post_user_Changepassword/');
    try {
      final response = await http.post(urls, body: {
        'currentpassword':currentpswd,
        'newpassword':newpswd,
        'confirmpassword':confrmpswd,
        'lid':sh.getString("lid").toString(),

      });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(status);
        if (status=='ok') {


          Navigator.push(context, MaterialPageRoute(
            builder: (context) =>MyLoginPage (title: "Home"),));
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
  String? Validatecurrentpswd(String value){
    if(value.isEmpty){
      return 'please enter a password';
    }
    return null;
  }
  String? Validatenewpswd(String value){
    if(value.isEmpty){
      return 'please enter a password';
    }
    return null;
  }
  String? Validateconfrmpswd(String value){
    if(value.isEmpty){
      return 'please enter a password';
    }
    return null;
  }
}