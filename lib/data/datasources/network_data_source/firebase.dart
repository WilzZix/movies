import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/utils/firebase_provider.dart';
import 'package:movies/domain/repositories/i_firebase_auth.dart';

class FirebaseAuthRepository implements FireBaseAuth {
  @override
  Future login({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseProvider.auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      log(e.toString());
      return;
    }
  }

  @override
  Future registration(
      {required String email, required String passwords}) async {
    try {
      final UserCredential userCredential = await FirebaseProvider.auth
          .createUserWithEmailAndPassword(email: email, password: passwords);
      return userCredential;
    } catch (e) {
      log(e.toString());
      return;
    }
  }

  @override
  Future getUserCollection() async {
    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        FirebaseProvider.firestore.collection('users').snapshots();
    return snapshot;
  }
}
