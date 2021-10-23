import 'package:fitness_challenge/constants.dart';
import 'package:flutter/material.dart';

typedef ContextToVoid = void Function(BuildContext);

class RoundedButton extends StatelessWidget {
  final String text;
  final ContextToVoid press;
  final Color color, textColor;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ButtonStyle roundedButtonStyle = TextButton.styleFrom(
      primary: color,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(29),
      ),
      backgroundColor: color,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: roundedButtonStyle,
          onPressed: () {
            press(context);
          },
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
