import 'package:fitness_challenge/components/rounded_button.dart';
import 'package:fitness_challenge/components/rounded_input_field.dart';
import 'package:fitness_challenge/services/appwrite_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';

enum MeasureType { calories, steps }

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  MeasureType _measureType = MeasureType.calories;
  late TextEditingController _challengeNameController;

  @override
  void initState() {
    super.initState();
    _challengeNameController = TextEditingController();
  }

  @override
  void dispose() {
    _challengeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          SizedBox(height: 10),
          const Text(
            'Challenge name:',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          RoundedInputField(
              hintText: 'Challenge name',
              icon: Icons.sports,
              onChanged: (value) {},
              controller: _challengeNameController),
          SizedBox(height: 20),
          const Text(
            'Challenge on:',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          buildRadio(title: 'Calories', measureType: MeasureType.calories),
          buildRadio(title: 'Steps', measureType: MeasureType.steps),
          RoundedButton(text: 'Save', press: press),
        ],
      ),
    );
  }

  press(BuildContext context) {
    String snackBarText = 'New challenge created successfully!';
    bool successfullyCreatedChallenge = true;
    int snackBarTime = 1500;

    try {
      AppwriteService appwriteService = context.read<AppwriteService>();
      String measureType = "";
      if (_measureType.toString() == MeasureType.calories.toString()) {
        measureType = MeasureType.calories.toString();
      } else {
        measureType = MeasureType.steps.toString();
      }

      appwriteService.createNewChallenge(
          challengeName: _challengeNameController.text,
          measureType: measureType);
    } on Exception catch (e) {
      snackBarText = e.toString();
      snackBarTime = 2500;
      successfullyCreatedChallenge = false;
    }
    SnackBar newUserSnackBar = SnackBar(
      content: Text(snackBarText),
      duration: Duration(milliseconds: snackBarTime),
    );
    ScaffoldMessenger.of(context).showSnackBar(newUserSnackBar);

    if (successfullyCreatedChallenge) {
      Navigator.of(context).pop();
    }
  }

  ListTile buildRadio(
      {required String title, required MeasureType measureType}) {
    return ListTile(
      title: Text(title),
      leading: Radio<MeasureType>(
        value: measureType,
        groupValue: _measureType,
        onChanged: (MeasureType? value) {
          setState(() {
            if (value.toString() == MeasureType.calories.toString()) {
              _measureType = MeasureType.calories;
            } else {
              _measureType = MeasureType.steps;
            }
          });
        },
      ),
    );
  }
}
