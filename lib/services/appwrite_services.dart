import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fitness_challenge/beans/user_challenges_bean.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AppwriteService with ChangeNotifier {
  final projectId = '616e3d7396bfb';
  final userCollectionId = '617497ffb09f7';
  final userActivitiesCollectionId = '6174984332af8';
  final challengesCollectionId = '617872e12c3d8';
  final userChallengesCollectionId = '617873272866b';
  final leaderboardCollectionId = '617873ddacaec';
  final appWriteEndPoint = 'https://localhost/v1';
  final uuid = const Uuid();

  late String _loggedInUser;

  final Client _client = Client();
  late Account _account;
  late Database _database;

  AppwriteService() {
    _client
        .setEndpoint(appWriteEndPoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
    _account = Account(_client);
    _database = Database(_client);
  }

  signIn({required String email, required String password}) async {
    Future result = _account.createSession(email: email, password: password);

    await result.then((response) {
      debugPrint(response.toString());
      Session session = response;
      _loggedInUser = session.userId;
      debugPrint(session.toString());
    }).catchError((error) {
      debugPrint('Error while signing in');
      debugPrint(error.toString());
      throw (error);
    });
  }

  signUp(
      {required String email,
      required String password,
      required String name}) async {
    Future result =
        _account.create(email: email, password: password, name: name);

    await result.then((response) {
      debugPrint('Signup done');
    }).catchError((error) {
      debugPrint('Error while signing up');
      debugPrint(error.toString());
      throw (error);
    });
  }

  void createNewChallenge(
      {required String challengeName, required String measureType}) async {
    try {
      String challengeId = uuid.v4();
      Document challengeDoc = await _database.createDocument(
        collectionId: challengesCollectionId,
        data: {
          'challenge_id': challengeId,
          'challenge_name': challengeName,
          'measure_type': measureType
        },
      );
      debugPrint(challengeDoc.toString());
      debugPrint('New challenge created');

      Document userChallengeDoc = await _database
          .createDocument(collectionId: userChallengesCollectionId, data: {
        'user_id': _loggedInUser,
        'challenge_id': challengeId,
        'challenge_name': challengeName,
        'rank': 0
      });
      debugPrint('User challenge doc created');
      debugPrint(userChallengeDoc.toString());
    } catch (e) {
      debugPrint('Error while creating new challenge');
      debugPrint(e.toString());
    }
  }

  Future<DocumentList> getUserChallenges() async {
    debugPrint('User id is: $_loggedInUser');
    DocumentList docList = await _database.listDocuments(
        collectionId: userChallengesCollectionId,
        filters: ['user_id=$_loggedInUser']);

    return docList;
  }

  void inviteUserToChallenge(
      {required String email,
      required String challengeId,
      required String challengeName}) async {
    DocumentList docList = await _database.listDocuments(
        collectionId: userCollectionId, filters: ['email=$email'], limit: 1);

    if (docList.documents == null || docList.documents.length == 0) {
      throw (Exception("User doesn't exist"));
    }

    String userId = docList.documents[0].data['user_id'];
    debugPrint('User id is: $userId');

    try {
      Document userChallengeDoc = await _database
          .createDocument(collectionId: userChallengesCollectionId, data: {
        'user_id': userId,
        'challenge_id': challengeId,
        'challenge_name': challengeName,
        'rank': 0
      });
      debugPrint('User challenge doc created');
      debugPrint(userChallengeDoc.toString());
    } catch (e) {
      debugPrint('Error while creating new challenge');
      debugPrint(e.toString());
    }
  }
}
