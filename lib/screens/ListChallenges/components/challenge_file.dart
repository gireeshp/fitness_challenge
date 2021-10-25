import 'package:flutter/material.dart';

class ChallengeTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final int yourRank;
  final String description;

  const ChallengeTile({
    Key? key,
    required this.icon,
    required this.name,
    required this.yourRank,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FlutterLogo(),
      title: Text(name),
      subtitle: Text(description),
      trailing: Text(yourRank.toString()),
    );
  }
}
