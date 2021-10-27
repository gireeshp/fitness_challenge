import 'package:fitness_challenge/constants.dart';
import 'package:fitness_challenge/screens/ListChallenges/challenges_listing_screen.dart';
import 'package:fitness_challenge/screens/Welcome/welcome_screen.dart';
import 'package:fitness_challenge/services/appwrite_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AppwriteService(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: const WelcomeScreen(),
      home: Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}
