import 'package:flutter/material.dart';

class LeaderboardListTile extends StatelessWidget {
  final IconData icon;
  final String userName;
  final int yourRank;
  final String userEmail;
  final String userId;

  const LeaderboardListTile({
    Key? key,
    required this.icon,
    required this.userName,
    required this.yourRank,
    required this.userEmail,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        leading: Icon(icon),
        title: Text(userName),
        subtitle: Text(userEmail),
        trailing: yourRank <= 0 ? const Text('NA') : Text(yourRank.toString()),
      ),
    );
  }
}
