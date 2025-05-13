

import 'dart:io';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';

import 'package:permission_handler/permission_handler.dart';
import 'package:trafficdencity/user/view%20user%20profile.dart';

import '../components/custom_text_field.dart';
import 'POLICE PROFILE.dart';


void main() {
  runApp(const MyEdit());
}

class MyEdit extends StatelessWidget {
  const MyEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyEditPolicePage(title: 'Edit Profile'),
    );
  }
}

class MyEditPolicePage extends StatefulWidget {
  const MyEditPolicePage({super.key, required this.title});

  final String title;

  @override
  State<MyEditPolicePage> createState() => _MyEditPolicePageState();
}

class _MyEditPolicePageState extends State<MyEditPolicePage> {

  _MyEditPolicePageState()
  {
    _get_data();
  }

  // String gender = "Male";
  // String uphoto='';
  TextEditingController nameController= new TextEditingController();
  // TextEditingController dobController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController phoneController= new TextEditingController();
  TextEditingController placeController= new TextEditingController();
  TextEditingController postController= new TextEditingController();
  TextEditingController pinController= new TextEditingController();
  TextEditingController districtController= new TextEditingController();
  // TextEditingController stateController= new TextEditingController();


  void _get_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/view_police_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String name=jsonDecode(response.body)['name'];
          // String dob=jsonDecode(response.body)['dob'];
          // String gender_=jsonDecode(response.body)['gender'];
          String email=jsonDecode(response.body)['email'];
          String phone=jsonDecode(response.body)['phone'];
          String place=jsonDecode(response.body)['place'];
          String post=jsonDecode(response.body)['post'];
          String pin=jsonDecode(response.body)['pin'];
          // String state=jsonDecode(response.body)['state'];

          String district=jsonDecode(response.body)['district'];
          // String photo=sh.getString("img_url").toString()+jsonDecode(response.body)['photo'];


          nameController.text=name;
          // dobController.text=dob;
          emailController.text=email;
          phoneController.text=phone;
          placeController.text=place;
          postController.text=post;
          pinController.text=pin;
          districtController.text=district;
          // stateController.text=state;


          // setState(() {
          //   uphoto=photo;
          //   gender=gender_;
          // });


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
      onWillPop: () async{ return false; },
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          leading: BackButton( onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewProfilePolicePage(title: 'home')),);

          },),

          backgroundColor:Colors.white,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // if (_selectedImage != null) ...{
              //   InkWell(
              //     child: CircleAvatar(
              //       radius: 70.0, // Adjust the radius as needed
              //       backgroundImage: FileImage(_selectedImage!),
              //     ),
              //
              //     onTap: _checkPermissionAndChooseImage,
              //     borderRadius: BorderRadius.all(Radius.circular(50)),
              //   ),
              // } else ...{

                // InkWell(
                //   onTap: _checkPermissionAndChooseImage,
                //   child: Column(
                //
                //     children: [
                //
                //       Padding(
                //         padding: const EdgeInsets.only(bottom: 15),
                //         child: CircleAvatar(
                //           backgroundImage: NetworkImage(
                //               uphoto),
                //           radius: 70,
                //           child: Padding(
                //             padding: const EdgeInsets.only(top: 90),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // )
              // },
              // if (_selectedImage != null) ...{
              //   InkWell(
              //     child:
              //     Image.file(_selectedImage!, height: 400,),
              //     radius: 399,
              //     onTap: _checkPermissionAndChooseImage,
              //     // borderRadius: BorderRadius.all(Radius.circular(200)),
              //   ),
              // } else ...{
              //   // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
              //   InkWell(
              //     onTap: _checkPermissionAndChooseImage,
              //     child:Column(
              //       children: [
              //         Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
              //         Text('Select Image',style: TextStyle(color: Colors.cyan))
              //       ],
              //     ),
              //   ),
              // },

              CustomTextField(
                controller: nameController,
                hintText: 'Full Name',
                icon: Icons.person,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              CustomTextField(
                controller: emailController,
                hintText: 'Email',
                icon: Icons.mail,

                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Fill';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              CustomTextField(

                controller: phoneController,
                hintText: 'Phone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Fill';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              // CustomTextField(
              //   controller: dobController,
              //   hintText: 'Dob',
              //   icon: Icons.date_range,
              //   keyboardType: TextInputType.datetime,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please Fill';
              //     }
              //     return null; // Return null if the input is valid
              //   },
              // ),

              // RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
              // RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
              // RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),
              CustomTextField(

                controller: placeController,
                hintText: 'Place',
                icon: Icons.place,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Fill';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              CustomTextField(

                controller: postController,
                hintText: 'Post',
                icon: Icons.post_add,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Fill';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              CustomTextField(

                controller: pinController,
                hintText: 'Pincode',
                icon: Icons.pin,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Fill';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              CustomTextField(

                controller: districtController,
                hintText: 'District',
                icon: Icons.local_activity,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Fill';
                  }
                  return null; // Return null if the input is valid
                },
              ),

              ElevatedButton(
                onPressed: () {
                  _send_data();
                },
                style:ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),child: Text("Confirm Edit", style: TextStyle(color: Colors.white),
              ),
              )

            ],
          ),
        ),
      ),
    );
  }
  void _send_data() async{



    // String uphoto='';

    // String photo=districtController.text;

    String name=nameController.text;
    // String dob=dobController.text;
    String email=emailController.text;
    String phone=phoneController.text;
    String place=placeController.text;
    String post=postController.text;
    String pin=pinController.text;
    String district=districtController.text;
    // String state=stateController.text;


    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/edit_police_profile/');
    try {

      final response = await http.post(urls, body: {
        // "photo":photo,
        'name':name,
        // 'dob':dob,
        // 'gender':gender,
        'email':email,
        'phone':phone,
        'place':place,
        'post':post,
        'pin':pin,
        // 'state':state,
        'district':district,
        'lid':lid,

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          Fluttertoast.showToast(msg: 'Updated Successfully');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ViewProfilePolicePage(title: "Profile"),));
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

  // File? _selectedImage;
  // String? _encodedImage;
  // Future<void> _chooseAndUploadImage() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedImage != null) {
  //     setState(() {
  //       _selectedImage = File(pickedImage.path);
  //       _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
  //       photo = _encodedImage.toString();
  //
  //     });
  //   }
  // }
  //
  // Future<void> _checkPermissionAndChooseImage() async {
  //   final PermissionStatus status = await Permission.mediaLibrary.request();
  //   if (status.isGranted) {
  //     _chooseAndUploadImage();
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //         title: const Text('Permission Denied'),
  //         content: const Text(
  //           'Please go to app settings and grant permission to choose an image.',
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
  //
  // String photo = '';

}
