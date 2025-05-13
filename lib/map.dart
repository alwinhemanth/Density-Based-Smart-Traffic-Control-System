import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void openMaps() async {


  SharedPreferences sh = await SharedPreferences.getInstance();
  String lati = sh.getString('slati').toString();
  String longi = sh.getString('slongi').toString();

  // The coordinates for the location (latitude and longitude)
  final String latitude =lati;
  final String longitude = longi;
  final String label = 'San Francisco, CA';

  // Construct the URL
  final String url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  // Check if the platform supports launching URLs
  if (await canLaunch(url)) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
