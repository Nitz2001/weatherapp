
import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Homepage(),
    );
  }
}


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  var feelslike;

  Future getWeather () async{
    final url=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=4ac7dcfaaa25c3af92f29b6e04ea7f1f');

    http.Response response=await http.get(url);
    var results = jsonDecode(response.body);
    setState(() {
      this.temp=results['main']['temp'];
      this.description=results['weather'][0]['description'];
      this.currently=results['weather'][0]['main'];
      this.humidity=results['main']['humidity'];
      this.windspeed=results['wind']['speed'];
      this.feelslike=results['main']['feels_like'];

    });

  }
  @override

  void initState(){
  super.initState();
  this.getWeather();
}









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,),
      body:Column(
        children: [
          Container(
              height: 150,
              width:2000,
              color: Colors.deepPurple,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(bottom:10),
                    child: Text(
                      'Currently in Bangalore',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),

                  ),
                  SizedBox(height:20),
                  Text(
                    temp != null ?((temp-273).round()).toString()+'\u00B0' : 'loading',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top:10),
                    child: Text(
                      currently != null ? currently.toString() : 'loading',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),

                  ),


                ],
              )

          ),
          Expanded(child:
          Padding(
            padding: EdgeInsets.all(20),
            child:ListView(
              children: [
                ListTile(
                  leading:FaIcon(FontAwesomeIcons.cloud),
                  title: Text('Weather'),
                  trailing: Text(description != null ? description.toString() : 'loading'),

                ),
                ListTile(
                  leading:FaIcon(FontAwesomeIcons.wind),
                  title: Text('Windspeed' ),
                  trailing: Text(windspeed != null ? windspeed.toString() : 'loading'),
                ),
                ListTile(
                  leading:FaIcon(FontAwesomeIcons.sun),
                  title: Text('Humidity' ),
                  trailing: Text(humidity != null ? humidity.toString() : 'loading'),
                ),
                ListTile(
                  leading:FaIcon(FontAwesomeIcons.person),
                  title: Text('Feelslike' ),
                  trailing: Text(feelslike != null ? feelslike.toString() : 'loading'),
                )
              ],
            )
          ))
          
        ],

      )

    );
  }
}