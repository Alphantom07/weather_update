import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(new MaterialApp(
    home:WeatherForecast(),
  ));
}

class weathermodelforecast {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  weathermodelforecast(
      {this.coord,
        this.weather,
        this.base,
        this.main,
        this.visibility,
        this.wind,
        this.clouds,
        this.dt,
        this.sys,
        this.timezone,
        this.id,
        this.name,
        this.cod});

  weathermodelforecast.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    clouds =
    json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    data['base'] = this.base;
    if (this.main != null) {
      data['main'] = this.main.toJson();
    }
    data['visibility'] = this.visibility;
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    if (this.clouds != null) {
      data['clouds'] = this.clouds.toJson();
    }
    data['dt'] = this.dt;
    if (this.sys != null) {
      data['sys'] = this.sys.toJson();
    }
    data['timezone'] = this.timezone;
    data['id'] = this.id;
    data['name'] = this.name;
    data['cod'] = this.cod;
    return data;
  }
}

class Coord {
  double lon;
  double lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  Main(
      {this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    return data;
  }
}

class Wind {
  double speed;
  int deg;

  Wind({this.speed, this.deg});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    return data;
  }
}

class Clouds {
  int all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }
}

class Sys {
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['country'] = this.country;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}

class Util{
  static String appid="64ccf32c6600619f4ad4e49b5bf3786f";
  static String getdate(DateTime dateTime)
  {
    return new DateFormat("EEE, MMM d, y").format(dateTime);
  }

}

class Network{
Future<weathermodelforecast> getWeatherdata({String cityname}) async{
  var finalurl="https://api.openweathermap.org/data/2.5/weather?q="+cityname+"&appid="+Util.appid+"";
  final response= await get(Uri.encodeFull(finalurl));
  print("URL : ${Uri.encodeFull(finalurl)}");

  if(response.statusCode==200)
    { print("Forecast data : ${response.body}");
  return weathermodelforecast.fromJson(jsonDecode(response.body));
    }
  else{
    print("Error getting weather details");
  }
}
}

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  Future<weathermodelforecast>forecastobject;
  String _city = "Delhi";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forecastobject = Network().getWeatherdata(cityname: _city);

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
           Container(
             child: TextField(
               decoration: InputDecoration(
                 prefixIcon: Icon(Icons.search),
                 hintText: "Enter a city name",
                 contentPadding: EdgeInsets.all(8),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                 )

               ),
               onSubmitted:(value) {
                 setState(() {
                   _city = value;
                   forecastobject = new Network().getWeatherdata(cityname: _city);
                 });

               },
             ),
           ),
          Container(
            child: FutureBuilder<weathermodelforecast>(
                future: forecastobject,
                builder:(BuildContext context, AsyncSnapshot<weathermodelforecast> snapshot){


if(snapshot.hasData)
  {
return Column(
  children: <Widget>[
    midview(snapshot),
  ],
);
  }else{
  return Container(
    child: Center(child: CircularProgressIndicator(),)
  );
  }


                }),
          ),

          ],
      ),
    );
  }
}

Widget midview(AsyncSnapshot<weathermodelforecast> snapshot) {
  var name2 = snapshot.data.name;
  var country2 = snapshot.data.sys.country;
  return Container(
    padding: const EdgeInsets.all(14),

      child:Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("${name2},${country2}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 18,
          ),
      ),
          Text("${Util.getdate(new DateTime.fromMillisecondsSinceEpoch(snapshot.data.dt * 1000))}",
          style: TextStyle(
            fontSize: 15,
          ),),

          SizedBox(height: 10,),
          convert_icons(snapshot.data.weather[0].main, Colors.redAccent, 195),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${(snapshot.data.main.temp-273).toStringAsFixed(1)}C ",style: TextStyle(
                  fontSize: 34,
                ),),
                Text("${snapshot.data.weather[0].description}")
              ],
            ),
          ),
          Padding(
         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12,),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12,),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text("${snapshot.data.wind.speed.toStringAsFixed(1)}mi/h"),
                   Icon(FontAwesomeIcons.wind,size: 20,color: Colors.brown,),

                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12,),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text("${snapshot.data.main.humidity.toStringAsFixed(0)}%"),
                   Icon(FontAwesomeIcons.grinBeamSweat,size: 20,color: Colors.brown,),

                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12,),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text("${(snapshot.data.main.tempMax-273).toStringAsFixed(1)}C"),
                   Text("MAX",style: TextStyle(
                     fontSize: 15,
                     fontWeight: FontWeight.bold,
                     color: Colors.brown,
                   )
                     ,)

                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12,),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text("${(snapshot.data.main.tempMin-273).toStringAsFixed(1)}C"),
                   Text("MIN",style: TextStyle(
                     fontSize: 15,
                     fontWeight: FontWeight.bold,
                     color: Colors.brown,
                   )
                     ,)

                 ],
               ),
             ),
           ],
         ),
          ),
        ],
  ),
  );
}

Widget convert_icons(String weatherdescription,Color color, double size){
  switch(weatherdescription){
    case "Clear":
      {return Icon(FontAwesomeIcons.sun,color: color,size: size,);
      break;
      }
    case "Clouds":
      {return Icon(FontAwesomeIcons.cloud,color: color,size: size,);
      break;
      } case "Rain":
    {return Icon(FontAwesomeIcons.cloudRain,color: color,size: size,);
    break;
    } case "Snow":
    {return Icon(FontAwesomeIcons.snowflake,color: color,size: size,);
    break;
    }
    case "Haze":
      {return Icon(FontAwesomeIcons.wind,color: color,size: size,);
      break;
      }
    default:{return Icon(FontAwesomeIcons.solidSun,color: color,size: size,);
    break;}

  }

}

