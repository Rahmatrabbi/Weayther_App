import 'package:http/http.dart';
import 'dart:convert';

class worker{
  late String location;

  //Constructor
  worker({required this.location})
  {
    location = location;
  }

  late String temperature;
  late String humidity;
  late String airSpeed;
  late String description;
  late String main;
  late String icon;

  Future<void> getData() async{
    try{
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=8dd28623dfed44efb60f6253c2ccd581"));
      Map data = jsonDecode(response.body);

      //Getting Temperature, Humidity
      Map mainData = data['main'];
      double getTemperature = mainData['temp']-273.15;//Kelvin to degree
      // celsius
      int getHumidity = mainData['humidity'];

      //Getting Air Speed
      Map windData = data['wind'];
      double getAirSpeed = windData['speed']/.27777777777778; // m/s to km./h

      //Getting Weather Description and Icon
      List weatherData = data['weather'];
      Map weatherMainData = weatherData[0];
      String getDescription = weatherMainData['description'];
      String getMain = weatherMainData['main'];
      String getIcon = weatherMainData['icon'].toString();

      //Assigning Values
      temperature = getTemperature.toStringAsFixed(1);
      humidity = getHumidity.toString();
      airSpeed = getAirSpeed.toStringAsFixed(1);
      description = getDescription;
      main = getMain;
      icon = getIcon;
    }catch(e) {
      temperature = "NA";
      humidity = "NA";
      airSpeed ="NA";
      description = "Can not Find Data";
      main = "NA";
      icon = "09d";
    }

  }
}

