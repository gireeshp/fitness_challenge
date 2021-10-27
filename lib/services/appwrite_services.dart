import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
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
      Document doc = await _database.createDocument(
        collectionId: challengesCollectionId,
        data: {
          'challenge_id': uuid.v4(),
          'challenge_name': challengeName,
          'measure_type': measureType
        },
      );
      debugPrint(doc.toString());
      debugPrint('New challenge created');
    } catch (e) {
      debugPrint('Error while creating new challenge');
      debugPrint(e.toString());
    }
  }
}
