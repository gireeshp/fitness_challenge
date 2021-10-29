import 'package:fitness_challenge/screens/ChallengeScreen/challenge_screen.dart';
import 'package:flutter/material.dart';

class ChallengeListTile extends StatelessWidget {
  final IconData icon;
  final String challengeName;
  final int yourRank;
  final String measureType;
  final String challengeId;

  const ChallengeListTile({
    Key? key,
    required this.icon,
    required this.challengeName,
    required this.yourRank,
    required this.measureType,
    required this.challengeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChallengeScreen(
            challengeId: challengeId,
            challengeName: challengeName,
            measureType: measureType,
          );
        }));
      },
      child: ListTile(
        leading: const FlutterLogo(),
        title: Text(challengeName),
        subtitle: Text(measureType),
        trailing: yourRank <= 0 ? const Text('NA') : Text(yourRank.toString()),
      ),
    );
  }
}
