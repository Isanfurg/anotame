import 'package:flutter/material.dart';
import 'package:anotame/services/weather_api_client.dart';
import 'package:anotame/models/weather_model.dart';
import 'package:geolocator/geolocator.dart';

class WeatherTool extends StatelessWidget {
  WeatherTool({Key? key}) : super(key: key);

  String latitude = '';
  String longitude = '';
  String temp = 'Cargando...';
  String city = 'Cargando...';
  String description = "Cargando...";
  String url_icon_weather = 'http://openweathermap.org/img/wn/10d@2x.png';
  WeatherApiClient weatherApiClient = WeatherApiClient();

  Future<void> getWeather() async {
    Weather? weather =
        await weatherApiClient.getCurrentWeather(latitude, longitude);

    temp = (weather?.temp!.truncate()).toString() + "°";

    city = (weather?.cityName!).toString();
    description = (weather?.description!).toString();
    String? aux = weather?.icon;
    url_icon_weather =
        "http://openweathermap.org/img/wn/" + aux!.toString() + "@2x.png";
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var lat = position.latitude;
    var long = position.longitude;

    latitude = "$lat";
    longitude = "$long";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: getWeather(),
              builder: (context, snapshot) {
                return weatherWidget(url_icon_weather, temp, city, description);
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(),
              ],
            ));
          }
          return Text("No connection");
        });
  }
}

Widget weatherWidget(
    String img_url, String temp, String city, String description) {
  return Container(
    width: 380,
    child: Card(
      elevation: 3,
      child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                img_url,
                width: 100,
              ),
              Text(
                temp,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                city + ", " + description,
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              SizedBox(height: 20),
            ]),
      ),
    ),
  );
}
