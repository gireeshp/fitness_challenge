import 'package:fitness_challenge/constants.dart';
import 'package:fitness_challenge/screens/ListChallenges/components/challenge_listing_body.dart';
import 'package:fitness_challenge/screens/ListChallenges/components/profile_body.dart';
import 'package:fitness_challenge/screens/NewChallenge/new_challenges_screen.dart';
import 'package:fitness_challenge/services/appwrite_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ChallengesListingScreen extends StatefulWidget {
  const ChallengesListingScreen({Key? key}) : super(key: key);

  @override
  _ChallengesListingScreenState createState() =>
      _ChallengesListingScreenState();
}

class _ChallengesListingScreenState extends State<ChallengesListingScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppwriteService appwriteService = context.read<AppwriteService>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Your Challenges'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const NewChallengeScreen();
                }));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: showTheRightPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.badge), label: 'Challenges'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          appwriteService.synchHealthData();
        },
        label: const Text('Sync Health Data'),
        icon: const Icon(Icons.health_and_safety),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget showTheRightPage(int selectedIndex) {
  if (selectedIndex == 0) {
    return ChallengeListingBody();
  } else {
    return ProfileBody();
  }
}
