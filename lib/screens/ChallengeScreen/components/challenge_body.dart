import 'package:appwrite/models.dart';
import 'package:fitness_challenge/screens/ChallengeScreen/components/leaderboard_list_tile.dart';
import 'package:fitness_challenge/screens/ListChallenges/components/challenge_list_tile.dart';
import 'package:fitness_challenge/services/appwrite_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ChallengeBody extends StatefulWidget {
  final String challengeId;
  const ChallengeBody({Key? key, required this.challengeId}) : super(key: key);

  @override
  _ChallengeBodyState createState() => _ChallengeBodyState();
}

class _ChallengeBodyState extends State<ChallengeBody> {
  @override
  Widget build(BuildContext context) {
    AppwriteService appwriteService = context.read<AppwriteService>();

    return FutureBuilder<DocumentList>(
      future: appwriteService.getLeaderBoard(widget.challengeId),
      builder: (BuildContext context, AsyncSnapshot<DocumentList> docList) {
        if (docList.connectionState == ConnectionState.none &&
            docList.hasData == false) {
          debugPrint('No data');
          return Container();
        } else {
          debugPrint('Has data 1 - ${docList.data?.documents.length}');
          return ListView.builder(
              itemCount:
                  docList.data == null ? 0 : docList.data?.documents.length,
              itemBuilder: (BuildContext context, int index) {
                Document? doc = docList.data?.documents[index];
                return LeaderboardListTile(
                  icon: Icons.person,
                  userEmail: doc?.data['email'],
                  userId: doc?.data['challenge_id'],
                  userName: doc?.data['user_name'],
                  yourRank: doc?.data['rank'],
                );
              });
        }
      },
    );
  }
}
