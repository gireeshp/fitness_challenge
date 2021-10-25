import 'package:fitness_challenge/constants.dart';
import 'package:fitness_challenge/screens/ListChallenges/components/challenge_body.dart';
import 'package:fitness_challenge/screens/ListChallenges/components/profile_body.dart';
import 'package:fitness_challenge/screens/NewChallenge/new_challenges_screen.dart';
import 'package:flutter/material.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  _ChallengesScreenState createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
    );
  }
}

openNewChallengePage() {}

Widget showTheRightPage(int selectedIndex) {
  if (selectedIndex == 0) {
    return ChallengeBody();
  } else {
    return ProfileBody();
  }
}
