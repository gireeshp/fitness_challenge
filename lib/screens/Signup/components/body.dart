import 'package:fitness_challenge/components/already_have_an_account_check.dart';
import 'package:fitness_challenge/components/rounded_button.dart';
import 'package:fitness_challenge/components/rounded_input_field.dart';
import 'package:fitness_challenge/components/rounded_password_field.dart';
import 'package:fitness_challenge/screens/ListChallenges/challenges_screen.dart';
import 'package:fitness_challenge/screens/Login/login_screen.dart';
import 'package:fitness_challenge/screens/Signup/components/background.dart';
import 'package:fitness_challenge/screens/Signup/components/or_divider.dart';
import 'package:fitness_challenge/screens/Signup/components/social_icon.dart';
import 'package:fitness_challenge/services/appwrite_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<void> press(BuildContext context) async {
    AppwriteService appwriteService = context.read<AppwriteService>();
    String snackBarText = 'New user created successfully!';

    bool successfullyRegistered = true;
    int snackBarTime = 1500;

    try {
      await appwriteService.signUp(
          email: _emailIdController.text,
          password: _passwordController.text,
          name: _userNameController.text);
    } catch (e) {
      snackBarText = e.toString();
      snackBarTime = 2500;
      successfullyRegistered = false;
    }
    SnackBar newUserSnackBar = SnackBar(
      content: Text(snackBarText),
      duration: Duration(milliseconds: snackBarTime),
    );

    ScaffoldMessenger.of(context).showSnackBar(newUserSnackBar);
    if (successfullyRegistered) {
      appwriteService.signIn(
          email: _emailIdController.text, password: _passwordController.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ChallengesScreen();
          },
        ),
      );
    }
  }

  late TextEditingController _userNameController;
  late TextEditingController _emailIdController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _emailIdController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              'assets/icons/signup.svg',
              height: size.height * 0.3,
            ),
            RoundedInputField(
              hintText: 'Your Name',
              icon: Icons.person,
              onChanged: (value) {},
              controller: _userNameController,
            ),
            RoundedInputField(
              hintText: 'Your Email',
              icon: Icons.email,
              onChanged: (value) {},
              controller: _emailIdController,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
              controller: _passwordController,
            ),
            RoundedButton(text: 'Signup', press: press),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            const OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: 'assets/icons/facebook.svg',
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: 'assets/icons/twitter.svg',
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: 'assets/icons/google-plus.svg',
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
