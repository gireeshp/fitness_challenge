import 'package:fitness_challenge/screens/ChallengeScreen/challenge_screen.dart';
import 'package:flutter/material.dart';

class ChallengeListTile extends StatelessWidget {
  final IconData icon;
  final String challengeName;
  final int yourRank;
  final String description;
  final String challengeId;

  const ChallengeListTile({
    Key? key,
    required this.icon,
    required this.challengeName,
    required this.yourRank,
    required this.description,
    required this.challengeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChallengeScreen(
              challengeId: challengeId, challengeName: challengeName);
        }));
      },
      child: ListTile(
        leading: FlutterLogo(),
        title: Text(challengeName),
        subtitle: Text(description),
        trailing: Text(yourRank.toString()),
      ),
    );
  }
}
