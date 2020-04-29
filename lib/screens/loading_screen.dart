 import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '22e21a7ab6b0906bc6ca9e022e3ebf29';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    longitude = location.longitude;
    latitude = location.latitude;

    getData();
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    if (response.statusCode == 200) {
      String data  = response.body;
      
      var longitude = jsonDecode(data)['coord']['lon'];
      var latitude = jsonDecode(data)['coord']['lat'];
      var temp = jsonDecode(data)['main']['temp'];
      var conditionID = jsonDecode(data)['weather'][0]['id'];
      var cityName = jsonDecode(data)['name'];
      print('long: $longitude lat: $latitude');
      print(temp);
      print(conditionID);
      print(cityName);
    } else {
      print('error: ' + response.statusCode.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold();
  }
}
