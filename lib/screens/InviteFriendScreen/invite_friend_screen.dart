import 'package:fitness_challenge/components/rounded_button.dart';
import 'package:fitness_challenge/components/rounded_input_field.dart';
import 'package:fitness_challenge/constants.dart';
import 'package:fitness_challenge/services/appwrite_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class InviteFriendScreen extends StatefulWidget {
  final String challengeId;
  final String challengeName;
  const InviteFriendScreen(
      {Key? key, required this.challengeId, required this.challengeName})
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Invite friends to ${this.widget.challengeName}'),
      ),
      body: Container(
        child: Column(children: [
          SizedBox(height: 10),
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
          SizedBox(height: 20),
          RoundedButton(text: 'Invite', press: press),
        ]),
      ),
    );
  }

  press(BuildContext context) {
    String snackBarText = 'User invited to the challenge successfully!';
    bool successfullyInvitedToChallenge = true;
    int snackBarTime = 1500;

    try {
      AppwriteService appwriteService = context.read<AppwriteService>();

      appwriteService.inviteUserToChallenge(
          challengeId: this.widget.challengeId,
          challengeName: this.widget.challengeName,
          email: _emailIdController.text);
    } on Exception catch (e) {
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
