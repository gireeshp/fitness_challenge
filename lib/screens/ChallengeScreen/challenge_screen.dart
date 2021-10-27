import 'package:fitness_challenge/components/rounded_button.dart';
import 'package:fitness_challenge/components/rounded_input_field.dart';
import 'package:fitness_challenge/constants.dart';
import 'package:fitness_challenge/services/appwrite_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ChallengeScreen extends StatefulWidget {
  final String challengeId;
  final String challengeName;

  const ChallengeScreen(
      {Key? key, required this.challengeId, required this.challengeName})
      : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(this.widget.challengeName),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChallengeScreen(
                    challengeId: this.widget.challengeId,
                    challengeName: this.widget.challengeName);
              }));
            },
            icon: Icon(Icons.add),
            tooltip: 'Invite friends to challenge',
          ),
        ],
      ),
      body: Container(),
    );
  }
}
