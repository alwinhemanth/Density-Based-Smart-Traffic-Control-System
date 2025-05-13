import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'map.dart';
class LocationFetchScreen extends StatefulWidget {
  @override
  _LocationFetchScreenState createState() => _LocationFetchScreenState();
}

class _LocationFetchScreenState extends State<LocationFetchScreen> {
  List<Map<String, dynamic>> ambulanceData = [];
  String _currentLocation = '';

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();


      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      String lat = position.latitude.toString();
      String lon = position.longitude.toString();
      // String url = sh.getString("url").toString();
      sh.setString("lati",lat).toString();
      sh.setString("longi",lon).toString();


      // SharedPreferences sh=await SharedPreferences.getInstance();
      // String url=sh.getString('url').toString();
      //
      // // final urls=Uri.parse('$url/user_login_post/');
      // // try {
      //   final response = await http.post(urls, body: {
      //     'username': username,
      //     'password': password,
      //   });


      var data = await http.post(
        Uri.parse('$url/calculate_distance/'),
        body: {
          'latitude': lat,
          'longitude': lon,
        },
      );
      var jsonData = json.decode(data.body);
      dynamic status = jsonData['status'];

      if (status is int) {
        status = status.toString(); // Convert to a string if it's an integer
      } else if (status is! String) {
        // Handle other data types or error cases
        print("Error: Invalid status type");
        return;
      }

      if (status == "ok") {
        List<dynamic> data = jsonData['data'];
        print(data);
        ambulanceData = data.cast<Map<String, dynamic>>();
        setState(() {}); // Update the UI with the fetched data
      } else {
        print("Error: Unable to fetch  data");
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Signal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentLocation,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: ambulanceData.length,
                itemBuilder: (context, index) {
                  final data = ambulanceData[index];


                  print(data);
                  print("=====================");
                  return Card(
                    child: ListTile(
                      title: Text(ambulanceData[index]['signalname']),

                  // subtitle: Text(ambulanceData[index]['phone'].toString()),
                      trailing: Icon(Icons.location_on),
                      onTap: () async{


                        openMaps();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
