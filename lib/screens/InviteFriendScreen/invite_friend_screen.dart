import 'package:fitness_challenge/components/rounded_button.dart';
import 'package:fitness_challenge/components/rounded_input_field.dart';
import 'package:fitness_challenge/constants.dart';
import 'package:fitness_challenge/screens/NewChallenge/components/body.dart';
import 'package:fitness_challenge/services/appwrite_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class InviteFriendScreen extends StatefulWidget {
  final String challengeId;
  final String challengeName;
  final String measureType;
  const InviteFriendScreen(
      {Key? key,
      required this.challengeId,
      required this.challengeName,
      required this.measureType})
      : super(key: key);

  @override
  _InviteFriendScreenState createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  late TextEditingController _emailIdController;
  @override
  void initState() {
    super.initState();
    _emailIdController = TextEditingController();
  }

  @override
  void dispose() {
    _emailIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Invite friends to ${widget.challengeName}'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15),
        width: size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 10),
          const Text(
            "Friend's email id",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          RoundedInputField(
              hintText: 'Email id',
              icon: Icons.sports,
              onChanged: (value) {},
              controller: _emailIdController),
          const SizedBox(height: 20),
          RoundedButton(text: 'Invite', press: press),
        ]),
      ),
    );
  }

  press(BuildContext context) async {
    String snackBarText = 'User invited to the challenge successfully!';
    bool successfullyInvitedToChallenge = true;
    int snackBarTime = 1500;

    try {
      AppwriteService appwriteService = context.read<AppwriteService>();

      await appwriteService.inviteUserToChallenge(
        challengeId: widget.challengeId,
        challengeName: widget.challengeName,
        email: _emailIdController.text,
        measureType: widget.measureType,
      );
    } catch (e) {
      snackBarText = e.toString();
      snackBarTime = 2500;
      successfullyInvitedToChallenge = false;
    }
    SnackBar newUserSnackBar = SnackBar(
      content: Text(snackBarText),
      duration: Duration(milliseconds: snackBarTime),
    );
    ScaffoldMessenger.of(context).showSnackBar(newUserSnackBar);

    if (successfullyInvitedToChallenge) {
      Navigator.of(context).pop();
    }
  }
}
