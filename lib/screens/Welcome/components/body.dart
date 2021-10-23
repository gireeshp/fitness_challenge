import 'package:fitness_challenge/constants.dart';
import 'package:fitness_challenge/screens/Login/login_screen.dart';
import 'package:fitness_challenge/screens/Signup/signup_screen.dart';
import 'package:fitness_challenge/screens/Welcome/components/background.dart';
import 'package:fitness_challenge/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  void pressLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ),
    );
  }

  void pressSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const SignUpScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Fitness Challenge',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              'assets/icons/chat.svg',
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: 'Login',
              press: pressLogin,
            ),
            RoundedButton(
              text: 'Sign up',
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: pressSignup,
            ),
          ],
        ),
      ),
    );
  }
}
