import 'dart:async';
import 'dart:convert';
import 'package:projet_examen/screens/WeatherDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_examen/models//Donnees_Meteo.dart';
import 'package:lottie/lottie.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  double progressValue = 0.0;
  StreamController<String> messageController = StreamController<String>();
  List<WeatherData> weatherDataList = [];
  bool isProgressComplete = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Écran de progression'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      //if(!isProgressComplete)
            StreamBuilder(
              stream: messageController.stream,
              initialData: 'Nous téléchargeons les données...',
              builder: (context, snapshot) {
                return Text(
                  snapshot.data.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple[100]),
                  textAlign: TextAlign.center,
                );
              },
            ),
            SizedBox(height: 30),
             ClipRRect(
          borderRadius: BorderRadius.circular(40), // Bordure circulaire
          child: Stack(
              children: [
                if (!isProgressComplete)
                  Container(
                    height: 40,
                    width: double.infinity,
                    color: Colors.grey[300],

                  ),
                AnimatedContainer(
                  height: 40,
                  width: MediaQuery.of(context).size.width * progressValue,
                  color: Colors.deepPurple[200],
                  duration: Duration(milliseconds: 200),
                ),
                if (isProgressComplete)
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            progressValue = 0.0;
                            weatherDataList.clear();
                            isProgressComplete = false;
                          });
                          simulateProgress();
                          rotateMessages();
                        },
                        child: Center(
                          child: Text(
                            'Recommencer',
                            style: TextStyle(color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold),

                             // setState()
                          ),
                        // ),
                      ),
                    ),
                  ),
                  ),
                if (!isProgressComplete)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        '${(progressValue * 100).toStringAsFixed(1)}%',
                        style: TextStyle(fontSize: 16, color: Colors.purple),
                      ),
                    ),

                  ),

              ],
            ),
        ),
            SizedBox(height: 20),

            //J'affice la liste des 5 villes ainsi que leur temperature et une icone
            Expanded(
              child: ListView.builder(
                itemCount: weatherDataList.length,
                itemBuilder: (context, index) {
                  var weatherData = weatherDataList[index];
                  IconData cloudIcon;
                 // String animationPath = '';



                  // Choix de l'image et de l'icône en fonction de la couverture nuageuse
                  if (weatherData.cloudiness == 'clear sky') {
                  //  cloudImage = Image.asset(' ');
                    cloudIcon = Icons.wb_sunny;
                    weatherData.animationPath = 'assets/images/soleil.json';
                  } else if (weatherData.cloudiness == 'few clouds') {
                 //   weatherData.animation = 'assets/images/animation0.json' ;
                    cloudIcon = Icons.cloud_queue;
                    weatherData.animationPath = 'assets/images/nuae1.json';
                  } else if (weatherData.cloudiness == 'scattered clouds') {
                //    cloudImage = Image.asset(' ');
                    cloudIcon = Icons.cloud_circle;
                    weatherData.animationPath = 'assets/images/nuae1.json';
                  } else if (weatherData.cloudiness == 'broken clouds') {
                    cloudIcon = Icons.cloud;
                    weatherData.animationPath = 'assets/images/nuae2.json';
                  } else if (weatherData.cloudiness == 'shower rain' ||
                      weatherData.cloudiness == 'rain' ||
                      weatherData.cloudiness == 'light rain') {
                    weatherData.animationPath = 'assets/images/pluie.json';
                    cloudIcon = Icons.grain;
                  } else if (weatherData.cloudiness == 'thunderstorm') {

                    cloudIcon = Icons.flash_on;
                    weatherData.animationPath = 'assets/images/flas.json';
                  } else if (weatherData.cloudiness == 'snow') {

                    cloudIcon = Icons.ac_unit;
                    weatherData.animationPath = 'assets/images/precipitation.json';
                  } else if (weatherData.cloudiness == 'mist' ||
                      weatherData.cloudiness == 'smoke' ||
                      weatherData.cloudiness == 'haze' ||
                      weatherData.cloudiness == 'dust' ||
                      weatherData.cloudiness == 'fog' ||
                      weatherData.cloudiness == 'sand' ||
                      weatherData.cloudiness == 'ash') {

                    cloudIcon = Icons.blur_on;
                    weatherData.animationPath = 'assets/images/brouillard.json';
                  } else {

                    cloudIcon = Icons.cloud_off;
                    weatherData.animationPath = 'assets/images/last.json';
                  }
                  return GestureDetector(
                    onTap: () {
                      // Naviguer vers une nouvelle page ici avec les détails de la météo
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherDetailsPage(weatherData: weatherData),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      color: Colors.indigo[100],
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weatherData.cityName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(cloudIcon, size: 24), // Ajout de l'icône de couverture nuageuse
                                SizedBox(width: 8),
                                Text('Température: ${weatherData.temperature}°C'),

                              ],
                            ),
                          ],
                        ),
                      ),
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

  void simulateProgress() {
    const int totalSteps = 60;
    const Duration stepDuration = Duration(seconds: 1);

    for (int step = 1; step <= totalSteps; step++) {
      Future.delayed(stepDuration * step, () {
        setState(() {
          progressValue = step / totalSteps;
        });

        if (step == totalSteps) {
          setState(() {
            isProgressComplete = true;
          });
          // Une fois la progression terminée, récupérez les données météo
          for (String city in ['Rennes', 'Paris', 'Nantes', 'Bordeaux', 'Lyon']) {
            fetchWeatherData(city);
          }
        }
      });
    }
  }

  void fetchWeatherData(String city) async {
    String apiKey = '39251b65ac58d6207f9b81af27fcaf5b';
    String url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        weatherDataList.add(WeatherData(
          cityName: city,
          temperature: (jsonResponse['main']['temp'] - 273.15), // Convertir en Celsius
          cloudiness: jsonResponse['weather'][0]['description'],
          animationPath: jsonResponse['weather'][0]['description'],
            onPressed:(){},


        ));
      });
    } else {
      print('Échec de la requête pour $city : ${response.statusCode}');
    }
  }

  void rotateMessages() {
    const List<String> messages = [
      'Nous téléchargeons les données...',
      'C’est presque fini...',
      'Plus que quelques secondes avant d’avoir le résultat...',
    ];

    Timer.periodic(Duration(seconds: 6), (Timer timer) {
      int index = timer.tick % messages.length;
      messageController.add(messages[index]);
      if (timer.tick >= 10) { // Arrêter après 60 secondes (10 itérations de 6 secondes)
        timer.cancel();
        setState(() {

        });


      }
    });
  }

  @override
  void initState() {
    super.initState();
    simulateProgress();
    rotateMessages();
  }

  @override
  void dispose() {
    messageController.close();
    super.dispose();
  }
}
