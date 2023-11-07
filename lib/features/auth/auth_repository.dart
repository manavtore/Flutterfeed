import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutterfeed/controller/providers/firebase_provider.dart';

final authRepositoryProvider = Provider((ref) => Authrepository(
      firestore: ref.read(firestoreProvider),
      auth: ref.read(authProvider),
      googleSignIn: ref.read(GoogleSignInProvider),
    ));

class Authrepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  Authrepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required GoogleSignIn googleSignIn})
      : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn;

  void signinwithgoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleauth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleauth?.accessToken,
        idToken: googleauth?.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print(userCredential.user?.email);
    } catch (E) {
      print(E);
    }
  }
}
