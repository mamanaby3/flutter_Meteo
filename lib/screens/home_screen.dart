import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'ProgressionScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}); // Supprimez super.key

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String accueil= 'assets/images/animation0.json';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Accueil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue sur l\'écran d\'accueil!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Ajout d'un espacement entre le texte et l'image
            Lottie.asset(
              accueil, // Chemin de votre fichier d'animation Lottie dans les actifs
              height: 200, // Hauteur de l'animation
              width: 200, // Largeur de l'animation
            ),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProgressScreen()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.purple), // Couleur mauve
              ),
              child: Text(
                'Aller à l\'écran suivant',
                style: TextStyle(fontSize: 18,color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
