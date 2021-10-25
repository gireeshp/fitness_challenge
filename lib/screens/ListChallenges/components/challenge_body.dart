import 'package:fitness_challenge/screens/ListChallenges/components/challenge_file.dart';
import 'package:flutter/material.dart';

class ChallengeBody extends StatefulWidget {
  const ChallengeBody({Key? key}) : super(key: key);

  @override
  _ChallengeBodyState createState() => _ChallengeBodyState();
}

class _ChallengeBodyState extends State<ChallengeBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        ChallengeTile(
            icon: Icons.sports,
            name: 'Challenge1',
            description: 'My challenge 1',
            yourRank: 1),
        ChallengeTile(
            icon: Icons.sports,
            name: 'Challenge2',
            description: 'My challenge 2',
            yourRank: 2),
        ChallengeTile(
            icon: Icons.sports,
            name: 'Challenge2',
            description: 'My challenge 2',
            yourRank: 2),
        ChallengeTile(
            icon: Icons.sports,
            name: 'Challenge2',
            description: 'My challenge 2',
            yourRank: 2),
        ChallengeTile(
            icon: Icons.sports,
            name: 'Challenge2',
            description: 'My challenge 2',
            yourRank: 2),
        ChallengeTile(
            icon: Icons.sports,
            name: 'Challenge2',
            description: 'My challenge 2',
            yourRank: 2),
        ChallengeTile(
            icon: Icons.sports,
            name: 'Challenge2',
            description: 'My challenge 2',
            yourRank: 2),
        ChallengeTile(
            icon: Icons.sports,
            name: 'Challenge2',
            description: 'My challenge 2',
            yourRank: 2),
        ChallengeTile(
            icon: Icons.sports,
            name: 'Challenge2',
            description: 'My challenge 2',
            yourRank: 2),
        ChallengeTile(
            icon: Icons.sports,
            name: 'Challenge2',
            description: 'My challenge 2',
            yourRank: 2),
      ],
    );
  }
}
