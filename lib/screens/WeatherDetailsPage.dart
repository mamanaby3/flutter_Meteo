import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_examen/models//Donnees_Meteo.dart';
import 'package:lottie/lottie.dart';

class WeatherDetailsPage extends StatelessWidget {
  final WeatherData weatherData;

  WeatherDetailsPage({required this.weatherData});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:Colors.indigo[50],
      appBar: AppBar(
        title: Text('Détails de la météo'),
        backgroundColor:Colors.deepPurple[50],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              weatherData.animationPath,
              height: 200,
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color:Colors.indigo[300],
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ' ${weatherData.cityName}',
                        style: TextStyle(fontSize: 45,color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '  ${weatherData.temperature.toStringAsFixed(0)}° ',
                        style: TextStyle(fontSize: 35,color: Colors.white,),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'Couverture nuageuse: ${weatherData.cloudiness}',
                        style: TextStyle(fontSize: 18),
                      ),
                      // Ajoutez d'autres détails météo si nécessaire
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
