import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

class LoginService {
  Client client = Client();

  LoginService() {
    client
        .setEndpoint('https://localhost/v1')
        .setProject('616e3d7396bfb')
        .setSelfSigned(status: true);
  }

  signIn(String email, String password) {
    Account account = Account(client);
    Future result = account.createSession(email: email, password: password);

    result.then((response) {
      debugPrint(response.toString());
    }).catchError((error) {
      debugPrint('Error while signing in');
      debugPrint(error.toString());
    });
  }

  signUp(String email, String password, String name) {
    Account account = Account(client);
    Future result =
        account.create(email: email, password: password, name: name);

    result.then((response) {
      debugPrint(response.toString());
    }).catchError((error) {
      debugPrint('Error while signing up');
      debugPrint(error.toString());
    });
  }
}
