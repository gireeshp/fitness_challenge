import 'package:fitness_challenge/components/rounded_input_field.dart';
import 'package:fitness_challenge/constants.dart';
import 'package:fitness_challenge/screens/NewChallenge/components/body.dart';
import 'package:flutter/material.dart';

class NewChallengeScreen extends StatelessWidget {
  const NewChallengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Body body = Body();
    return Scaffold(
      appBar: AppBar(
        title: Text('Configure new challenge'),
        backgroundColor: kPrimaryColor,
      ),
      body: body,
    );
  }
}
