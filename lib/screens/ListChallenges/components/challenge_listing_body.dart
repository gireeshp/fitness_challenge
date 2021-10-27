import 'package:appwrite/models.dart';
import 'package:fitness_challenge/screens/ListChallenges/components/challenge_list_tile.dart';
import 'package:fitness_challenge/services/appwrite_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ChallengeListingBody extends StatefulWidget {
  const ChallengeListingBody({Key? key}) : super(key: key);

  @override
  _ChallengeListingBodyState createState() => _ChallengeListingBodyState();
}

class _ChallengeListingBodyState extends State<ChallengeListingBody> {
  @override
  Widget build(BuildContext context) {
    AppwriteService appwriteService = context.read<AppwriteService>();
    // AsyncSnapshot<DocumentList> docList = appwriteService.getUserChallenges();
    // Future<DocumentList> docListdd = appwriteService.getUserChallenges();

    return FutureBuilder<DocumentList>(
      future: appwriteService.getUserChallenges(),
      builder: (BuildContext context, AsyncSnapshot<DocumentList> docList) {
        if (docList.connectionState == ConnectionState.none &&
            docList.hasData == false) {
          debugPrint('No data');
          return Container();
        } else {
          debugPrint('Has data - ${docList.data?.documents.length}');
          return ListView.builder(
              itemCount:
                  docList.data == null ? 0 : docList.data?.documents.length,
              itemBuilder: (BuildContext context, int index) {
                Document? doc = docList.data?.documents[index];
                return ChallengeListTile(
                  icon: Icons.sports,
                  challengeName: doc?.data['challenge_name'],
                  yourRank: doc?.data['rank'],
                  description: doc?.data['challenge_name'],
                  challengeId: doc?.data['challenge_id'],
                );
              });
        }
      },
    );
  }
}
