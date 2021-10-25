import 'package:fitness_challenge/components/already_have_an_account_check.dart';
import 'package:fitness_challenge/components/rounded_button.dart';
import 'package:fitness_challenge/components/rounded_input_field.dart';
import 'package:fitness_challenge/components/rounded_password_field.dart';
import 'package:fitness_challenge/screens/Login/components/background.dart';
import 'package:fitness_challenge/screens/Signup/signup_screen.dart';
import 'package:fitness_challenge/services/appwrite_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<void> press(BuildContext context) async {
    AppwriteService loginService = context.read<AppwriteService>();
    String snackBarText = 'Logged in successfully!';

    bool successfullyLoggedIn = true;
    int snackBarTime = 1500;

    try {
      await loginService.signIn(
        email: _emailIdController.text,
        password: _passwordController.text,
      );
    } catch (e) {
      snackBarText = e.toString();
      snackBarTime = 2500;
      successfullyLoggedIn = false;
    }
    SnackBar newUserSnackBar = SnackBar(
      content: Text(snackBarText),
      duration: Duration(milliseconds: snackBarTime),
    );

    ScaffoldMessenger.of(context).showSnackBar(newUserSnackBar);
    if (successfullyLoggedIn) {}
  }

  late TextEditingController _emailIdController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailIdController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
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
              'assets/icons/login.svg',
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: 'Your Email',
              onChanged: (value) {},
              icon: Icons.email,
              controller: _emailIdController,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
              controller: _passwordController,
            ),
            RoundedButton(
              text: 'Login',
              press: press,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
