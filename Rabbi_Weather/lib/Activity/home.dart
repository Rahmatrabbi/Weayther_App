import 'dart:math';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Home Set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var cityName = [
      "Dhaka",
      "Tokyo",
      "Khulna",
      "Sylhet",
      "London",
      "Chittagong",
      "Paris",
      "Delhi"
    ];
    final _random = new Random();
    var city = cityName[_random.nextInt(cityName.length)];

    Map? info = ModalRoute.of(context)?.settings.arguments as Map;
    String temperature = info['temperatureValue'];
    String icon = info['iconValue'];
    String currentCity = info['cityValue'];
    String humidity = info['humidityValue'];
    String airSpeed = info['airSpeedValue'];
    String description = info['descriptionValue'];
    String main = info['mainValue'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: NewGradientAppBar(
            gradient: const LinearGradient(
                colors: [Colors.blue, Colors.cyan],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue.shade800, Colors.cyan.shade300])),
            child: Column(
              children: [
                Container(
                  //Search Container
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank Search");
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, '/loading', arguments: {
                                "searchText": searchController.text
                              });
                            }
                          },
                          child: Container(
                            child: Icon(Icons.search, color: Colors.blueAccent),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          )),
                      Expanded(
                        child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search by city name, i.e. $city")),
                      )
                    ],
                  ),
                ), //Search Container

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            //Image.network("http://openweathermap.org/img/wn/$icon@2x.png"),
                            Image.network(
                              'http://openweathermap.org/img/wn/$icon@2x.png',
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Whoops!',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  "$description",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "In $currentCity",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temperature",
                                  style: TextStyle(fontSize: 80),
                                ),
                                Text(
                                  "°C",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(25, 0, 10, 0),
                        padding: EdgeInsets.all(26),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Icon(WeatherIcons.day_windy)],
                            ),
                            SizedBox(height: 30),
                            Text(
                              "$airSpeed",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("Km/hr")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(10, 0, 25, 0),
                        padding: EdgeInsets.all(26),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Icon(WeatherIcons.humidity)],
                            ),
                            SizedBox(height: 30),
                            Text(
                              "$humidity",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("Percent")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text("Made By Rabbi"),
                      Text("Data provided by openweathermap.org")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
